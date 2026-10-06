import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_buffers.dart';

// Importa tus modelos y comandos generados
import 'package:untitled/pellet_stove_commands.pb.dart';
import 'package:untitled/ble_device_model.dart';


Future<void> _requestBleAndLocationPermissions() async {
  debugPrint('[PERMISSIONS] Checking and requesting runtime permissions...');

  Map<Permission, PermissionStatus> statuses = await [
    Permission.locationWhenInUse,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
  ].request();

  bool allGranted = statuses.values.every((status) => status.isGranted);

  if (allGranted) {
    debugPrint('[PERMISSIONS] ✅ All BLE and Location permissions granted.');
  } else {
    debugPrint('[PERMISSIONS] ⚠️ Location or Bluetooth permissions were denied by user.');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('--- [BOOT] Initializing Flutter & Isar DB ---');

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [BleDeviceModelSchema],
    directory: dir.path,
  );

  debugPrint('--- [BOOT] Isar DB opened successfully at: ${dir.path} ---');
  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  final Isar isar;
  const MyApp({super.key, required this.isar});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Si917 BLE Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BleScanScreen(isar: isar),
    );
  }
}

// ============================================================================
// PANTALLA 1: ESCANEO Y VINCULACIÓN INICIAL (BleScanScreen)
// ============================================================================

class BleScanScreen extends StatefulWidget {
  final Isar isar;
  const BleScanScreen({super.key, required this.isar});

  @override
  State<BleScanScreen> createState() => _BleScanScreenState();
}

class _BleScanScreenState extends State<BleScanScreen> {
  final FlutterReactiveBle _ble = FlutterReactiveBle();

  final List<DiscoveredDevice> _discoveredDevices = [];
  bool _isScanning = false;
  bool _isAutoConnecting = true;
  String _connectionStatus = 'Verificando Isar DB...';

  final String targetDeviceName = "SL_MC_GATT_DEMO";
  String? _savedTargetDeviceName;

  StreamSubscription<DiscoveredDevice>? _scanStream;
  StreamSubscription<ConnectionStateUpdate>? _connectionStream;
  Timer? _connectionTimer;

  static const int autoConnectTimeoutSeconds = 15;

  @override
  void initState() {
    super.initState();
    _initializeAndStartAutoConnect();
  }

  Future<void> _initializeAndStartAutoConnect() async {
    await _requestBleAndLocationPermissions();
    await _tryAutoConnectToLastDevice();
  }

  void _startWatchdogTimer() {
    _connectionTimer?.cancel();
    debugPrint('[WATCHDOG] Arming $autoConnectTimeoutSeconds-second timeout watchdog.');

    _connectionTimer = Timer(const Duration(seconds: autoConnectTimeoutSeconds), () {
      debugPrint('[WATCHDOG] ⚠️ TIMEOUT TRIGGERED ($autoConnectTimeoutSeconds s)! Device not found or unresponsive.');
      _stopScan();
      _connectionStream?.cancel();
      _connectionStream = null;

      _handleConnectionFailure(
        true,
        'Tiempo de espera agotado ($autoConnectTimeoutSeconds s). Dispositivo no detectado.',
      );
    });
  }

  Future<void> _tryAutoConnectToLastDevice() async {
    debugPrint('\n==================================================');
    debugPrint('[AUTO-CONNECT] Querying Isar for last saved device...');

    final lastSavedDevice = await widget.isar.bleDeviceModels
        .where()
        .sortByLastConnectedDesc()
        .findFirst();

    if (lastSavedDevice != null) {
      _savedTargetDeviceName = (lastSavedDevice.name != null && lastSavedDevice.name!.isNotEmpty)
          ? lastSavedDevice.name
          : targetDeviceName;

      debugPrint('[AUTO-CONNECT] Saved device found in DB: "$_savedTargetDeviceName"');

      setState(() {
        _isAutoConnecting = true;
        _connectionStatus = 'Escaneando publicidad de "$_savedTargetDeviceName"...';
      });

      _startWatchdogTimer();
      _startScan(targetNameFilter: _savedTargetDeviceName);
    } else {
      debugPrint('[AUTO-CONNECT] No saved devices found in Isar DB.');
      setState(() {
        _isAutoConnecting = false;
        _connectionStatus = 'Sin vinculación previa. Presiona "Escanear".';
      });
    }
  }

  void _startScan({String? targetNameFilter}) {
    debugPrint('\n--------------------------------------------------');
    debugPrint('[SCANNER] Starting BLE scan (LowLatency Mode)...');
    if (targetNameFilter != null) {
      debugPrint('[SCANNER] Auto-connect NAME filter ACTIVE for: "$targetNameFilter"');
    }

    setState(() {
      _discoveredDevices.clear();
      _isScanning = true;
      if (!_isAutoConnecting) {
        _connectionStatus = 'Escaneando dispositivos...';
      }
    });

    _scanStream?.cancel();
    _scanStream = _ble.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
    ).listen((device) {
      final existingIndex = _discoveredDevices.indexWhere((d) => d.id == device.id);

      setState(() {
        if (existingIndex >= 0) {
          _discoveredDevices[existingIndex] = device;
        } else {
          _discoveredDevices.add(device);
        }
      });

      if (targetNameFilter != null && device.name == targetNameFilter) {
        debugPrint('\n==================================================');
        debugPrint('[INTERCEPTOR] TARGET DEVICE MATCHED ("${device.name}")!');
        debugPrint('   -> Discovered ID: ${device.id}');
        debugPrint('   -> Stopping scan and connecting immediately...');

        _stopScan();

        if (mounted) {
          setState(() {
            _connectionStatus = '¡Dispositivo "${device.name}" encontrado! Conectando...';
          });
        }

        _connectToDeviceId(
          device.id,
          device.name.isEmpty ? targetDeviceName : device.name,
          isAutoConnect: true,
        );
      }
    }, onError: (error) {
      debugPrint('[SCANNER] Scan Error: $error');
      setState(() {
        _connectionStatus = 'Error de escaneo: $error';
        _isScanning = false;
      });
    });

    if (!_isAutoConnecting) {
      Timer(const Duration(seconds: 10), () {
        if (_isScanning) {
          debugPrint('[SCANNER] Manual scan timeout (10s) reached. Stopping scan.');
          _stopScan();
        }
      });
    }
  }

  void _stopScan() {
    debugPrint('\n--------------------------------------------------');
    debugPrint('[SCANNER SUMMARY] Stopping scan stream.');
    _scanStream?.cancel();
    _scanStream = null;
    setState(() {
      _isScanning = false;
      if (_connectionStatus == 'Escaneando dispositivos...') {
        _connectionStatus = 'Escaneo finalizado';
      }
    });
  }

  void _connectToDeviceId(String deviceId, String deviceName, {required bool isAutoConnect}) {
    debugPrint('\n--------------------------------------------------');
    debugPrint('[GATT CONNECT] Initiating GATT connection procedure...');
    debugPrint('   -> Target ID: $deviceId');
    debugPrint('   -> Target Name: $deviceName');
    debugPrint('   -> AutoConnect Mode: $isAutoConnect');

    _stopScan();

    _connectionStream?.cancel();
    _connectionStream = null;

    if (!isAutoConnect) {
      _startWatchdogTimer();
    }

    _connectionStream = _ble.connectToDevice(
      id: deviceId,
      connectionTimeout: const Duration(seconds: autoConnectTimeoutSeconds),
    ).listen((update) async {
      debugPrint('[GATT STATUS UPDATE] Device State -> ${update.connectionState.name}');

      if (!mounted) return;

      setState(() {
        _connectionStatus = 'Estado: ${update.connectionState.name}';
      });

      if (update.connectionState == DeviceConnectionState.connected) {
        debugPrint('\n[GATT CONNECTED] ✅ Link established with Si917!');
        debugPrint('[GATT CONNECTED] Disarming Watchdog Timer.');
        _connectionTimer?.cancel();

        setState(() {
          _connectionStatus = '¡Conectado! Actualizando Isar DB...';
        });

        try {
          debugPrint('[ISAR] Persisting connection credentials...');
          await _saveDeviceToIsar(deviceId, deviceName);
          debugPrint('[ISAR] Saved successfully.');

          debugPrint('[GATT DISCOVERY] Discovering GATT services...');
          List<DiscoveredService> services = await _ble.discoverServices(deviceId);
          debugPrint('[GATT DISCOVERY] ✅ Found ${services.length} services.');

          if (!mounted) return;

          final connectedDevice = DiscoveredDevice(
            id: deviceId,
            name: deviceName,
            serviceData: const {},
            serviceUuids: const [],
            manufacturerData: Uint8List(0),
            // Valor estático, ya no afecta el comportamiento
            rssi: -60,
          );

          setState(() {
            _isAutoConnecting = false;
          });

          debugPrint('[NAVIGATION] Pushing DeviceDetailsScreen to stack...');
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeviceDetailsScreen(
                device: connectedDevice,
                ble: _ble,
                services: services,
                isar: widget.isar,
              ),
            ),
          );

          debugPrint('[NAVIGATION] Returned from DeviceDetailsScreen. Checking state...');
          _tryAutoConnectToLastDevice();

        } catch (e) {
          debugPrint('[GATT ERROR] ❌ Exception during discovery or navigation: $e');
          _handleConnectionFailure(isAutoConnect, 'Error al descubrir servicios: $e');
        }
      } else if (update.connectionState == DeviceConnectionState.disconnected) {
        debugPrint('[GATT STATUS] Device disconnected.');
      }
    }, onError: (error) {
      debugPrint('[GATT ERROR] ❌ Connection stream error: $error');
      _connectionTimer?.cancel();
      _handleConnectionFailure(isAutoConnect, 'Fallo en la conexión: $error');
    });
  }

  void _handleConnectionFailure(bool isAutoConnect, String errorMessage) {
    debugPrint('[FAILURE HANDLER] Connection Failed. Message: "$errorMessage"');
    _connectionTimer?.cancel();
    if (isAutoConnect) {
      setState(() {
        _isAutoConnecting = false;
        _connectionStatus = '$errorMessage Inicia escaneo manual.';
      });
    } else {
      setState(() {
        _connectionStatus = errorMessage;
      });
    }
  }

  void _cancelAutoConnect() {
    _connectionTimer?.cancel();
    _stopScan();
    _connectionStream?.cancel();
    _connectionStream = null;

    setState(() {
      _isAutoConnecting = false;
      _connectionStatus = 'Reconexión cancelada. Modo de escaneo manual activo.';
    });
  }

  Future<void> _saveDeviceToIsar(String deviceId, String name) async {
    final newDevice = BleDeviceModel()
      ..deviceId = deviceId
      ..name = name
      ..lastConnected = DateTime.now();

    await widget.isar.writeTxn(() async {
      await widget.isar.bleDeviceModels.put(newDevice);
    });
  }

  @override
  void dispose() {
    _connectionTimer?.cancel();
    _stopScan();
    _connectionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Si917 BLE Scanner & Pair'),
      ),
      body: _isAutoConnecting
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                _connectionStatus,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: _cancelAutoConnect,
                icon: const Icon(Icons.cancel_outlined),
                label: const Text('Cancelar y Escanear Manualmente'),
              ),
            ],
          ),
        ),
      )
          : Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade100,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _connectionStatus,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Buscando "$targetDeviceName".',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),
              ],
            ),
          ),
          Expanded(
            child: _discoveredDevices.isEmpty
                ? Center(
              child: Text(
                _isScanning
                    ? 'Buscando dispositivos cercanos...'
                    : 'Presiona "Escanear" para comenzar',
                style: const TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: _discoveredDevices.length,
              itemBuilder: (context, index) {
                final device = _discoveredDevices[index];
                final isTarget = device.name == targetDeviceName;

                return ListTile(
                  leading: Icon(
                    Icons.bluetooth,
                    color: isTarget ? Colors.green : Colors.blue,
                  ),
                  title: Text(
                    device.name.isEmpty ? 'Dispositivo Desconocido' : device.name,
                    style: TextStyle(fontWeight: isTarget ? FontWeight.bold : FontWeight.normal),
                  ),
                  subtitle: Text(device.id),
                  trailing: ElevatedButton(
                    onPressed: () => _connectToDeviceId(
                      device.id,
                      device.name,
                      isAutoConnect: false,
                    ),
                    child: const Text('Conectar'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _isAutoConnecting
          ? null
          : FloatingActionButton.extended(
        onPressed: _isScanning ? _stopScan : () => _startScan(),
        icon: Icon(_isScanning ? Icons.stop : Icons.search),
        label: Text(_isScanning ? 'Detener' : 'Escanear'),
      ),
    );
  }
}

// ============================================================================
// PANTALLA 2: CONTROL Y RECONEXIÓN RÁPIDA CONTINUA (DeviceDetailsScreen)
// ============================================================================

class DeviceDetailsScreen extends StatefulWidget {
  final DiscoveredDevice device;
  final FlutterReactiveBle ble;
  final List<DiscoveredService> services;
  final Isar isar;

  const DeviceDetailsScreen({
    super.key,
    required this.device,
    required this.ble,
    required this.services,
    required this.isar,
  });

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  // BLE Configuration
  final Uuid targetServiceUuid = Uuid.parse("6A4E3300-667B-11E3-949A-0800200C9A66");
  final Uuid targetCharUuid = Uuid.parse("6A4E3304-667B-11E3-949A-0800200C9A66");

  // MQTT Configuration
  final String mqttBrokerUrl = '192.168.103.178';
  final int mqttPort = 1883;
  final String mqttTopic = 'pellet/device_id/command';

  // Execution Timer State
  String _lastExecutionTime = '-- ms';

  // RSSI ya no se actualiza continuamente, se antiene como un valor estático UI.
  late int _currentRssi;

  StreamSubscription<ConnectionStateUpdate>? _connectionStateSubscription;
  StreamSubscription<DiscoveredDevice>? _reconnectScanStream;
  StreamSubscription<ConnectionStateUpdate>? _reconnectConnectionStream;
  Timer? _reconnectTimer;

  bool _isDisconnecting = false;
  bool _isReconnecting = false;
  DeviceConnectionState _connectionState = DeviceConnectionState.connected;

  DateTime _lastScanTime = DateTime.now().subtract(const Duration(seconds: 30));

  @override
  void initState() {
    super.initState();
    _currentRssi = widget.device.rssi; // Valor inicial estático
    _listenToConnectionState();
    _requestHighPerformance();
  }
  //Testing developer-2


  Future<void> _requestHighPerformance() async {
    try {
      await widget.ble.requestConnectionPriority(
        deviceId: widget.device.id,
        priority: ConnectionPriority.highPerformance,
      );
      debugPrint('[BLE] Prioridad de conexión configurada a Alto Rendimiento');
    } catch (e) {
      debugPrint('[BLE] No se pudo cambiar la prioridad: $e');
    }
  }

  // Se encarga de monitorear cualquier cambio de estado a nivel global.
  void _listenToConnectionState() {
    _connectionStateSubscription = widget.ble.connectedDeviceStream.listen((update) {
      if (update.deviceId == widget.device.id) {
        debugPrint('[BLE STATE UPDATE] Device: ${update.deviceId} -> State: ${update.connectionState.name}');

        if (!mounted) return;

        setState(() {
          _connectionState = update.connectionState;
        });

        if (update.connectionState == DeviceConnectionState.disconnected && !_isDisconnecting) {
          _onDisconnectionDetected('Conexión BLE perdida.');
        } else if (update.connectionState == DeviceConnectionState.connected) {
          setState(() {
            _isReconnecting = false;
          });
        }
      }
    });
  }

  void _onDisconnectionDetected(String reason) {
    if (_isDisconnecting || _isReconnecting) return;

    if (mounted) {
      setState(() {
        _connectionState = DeviceConnectionState.disconnected;
      });
    }

    _startScan(targetNameFilter: widget.device.name);
  }

  // ============================================================================
  // ADAPTED FUNCTIONS FOR RECONNECTION WITHIN DETAILS SCREEN
  // ============================================================================

  void _startScan({String? targetNameFilter}) {
    if (_isReconnecting && _reconnectScanStream != null) return;

    final now = DateTime.now();
    // Validamos que hayan pasado al menos 6 segundos desde el último escaneo
    if (now.difference(_lastScanTime).inSeconds < 6) {
      debugPrint('[SCAN GUARD] 🛡️ Previniendo Throttle de Android. Reintentando en 6s...');
      Timer(const Duration(seconds: 6), () {
        if (mounted && _connectionState != DeviceConnectionState.connected) {
          _startScan(targetNameFilter: targetNameFilter);
        }
      });
      return;
    }

    _lastScanTime = now;
    debugPrint('\n--------------------------------------------------');
    debugPrint('[RECONNECT SCANNER] Starting BLE scan (LowLatency Mode)...');

    if (mounted) {
      setState(() {
        _isReconnecting = true;
      });
    }

    _reconnectScanStream?.cancel();
    _reconnectScanStream = widget.ble.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
    ).listen((device) {
      if (device.id == widget.device.id || (targetNameFilter != null && device.name == targetNameFilter)) {
        debugPrint('\n==================================================');
        debugPrint('[INTERCEPTOR] 🎯 TARGET DEVICE MATCHED ("${device.name}")!');
        _stopReconnectScan();
        _connectToDeviceId(device.id, device.name.isEmpty ? widget.device.name : device.name);
      }
    }, onError: (error) {
      debugPrint('[RECONNECT SCANNER] ❌ Scan Error: $error');

      if (error.toString().contains('throttle') || error.toString().contains('2147483646')) {
        debugPrint('⚠️ ANDROID THROTTLE DETECTADO. Esperando 30s.');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Protección Bluetooth de Android activa. Espera 30s.'),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 5),
              )
          );
        }
      }

      // Liberar el estado de reconexión para futuros intentos
      if (mounted) setState(() => _isReconnecting = false);
    });

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 15), () {
      if (_isReconnecting) {
        debugPrint('[RECONNECT SCANNER] 15s timeout alcanzado. Deteniendo escáner.');
        _stopReconnectScan();
        // Liberar el estado al fallar
        if (mounted) setState(() => _isReconnecting = false);
      }
    });
  }

  void _stopReconnectScan() {
    _reconnectScanStream?.cancel();
    _reconnectScanStream = null;
  }

  void _connectToDeviceId(String deviceId, String deviceName) {
    debugPrint('\n--------------------------------------------------');
    debugPrint('[GATT RECONNECT] Initiating GATT connection procedure...');

    _stopReconnectScan();
    _reconnectConnectionStream?.cancel();
    _reconnectConnectionStream = null;

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 15), () {
      debugPrint('[GATT RECONNECT] ⚠️ Connection Timeout reached (15s).');
      _reconnectConnectionStream?.cancel();

      // 🛠️ FIX: Liberar el estado si la conexión falla por timeout para reintentar
      if (mounted) setState(() => _isReconnecting = false);
      _onDisconnectionDetected('Timeout en conexión GATT');
    });

    _reconnectConnectionStream = widget.ble.connectToDevice(
      id: deviceId,
      connectionTimeout: const Duration(seconds: 15),
    ).listen((update) async {
      if (!mounted) return;

      setState(() {
        _connectionState = update.connectionState;
      });

      if (update.connectionState == DeviceConnectionState.connected) {
        debugPrint('\n[GATT CONNECTED] ✅ Link established with Si917!');
        _reconnectTimer?.cancel();

        // 🔄 REINICIAMOS EL TIMER SI LA CONEXIÓN ES EXITOSA
        _lastScanTime = DateTime.now().subtract(const Duration(seconds: 30));

        try {
          await _saveDeviceToIsar(deviceId, deviceName);
          await widget.ble.discoverServices(deviceId);

          if (!mounted) return;
          setState(() {
            _isReconnecting = false;
          });

          _requestHighPerformance();
        } catch (e) {
          debugPrint('[GATT ERROR] ❌ Exception during discovery: $e');
          if (mounted) setState(() => _isReconnecting = false);
        }
      } else if (update.connectionState == DeviceConnectionState.disconnected) {
        debugPrint('[GATT STATUS] Device disconnected.');
        _reconnectTimer?.cancel();

        // 🛠️ FIX: Liberar la bandera de inmediato tras una desconexión explícita
        if (mounted) setState(() => _isReconnecting = false);

        Timer(const Duration(seconds: 2), () {
          if (mounted && _connectionState != DeviceConnectionState.connected) {
            _onDisconnectionDetected('Desconectado en pleno intento');
          }
        });
      }
    }, onError: (error) {
      debugPrint('[GATT ERROR] ❌ Connection stream error: $error');
      _reconnectTimer?.cancel();

      // 🛠️ FIX: Liberar el estado en caso de error directo del radio
      if (mounted) setState(() => _isReconnecting = false);

      Timer(const Duration(seconds: 2), () {
        if (mounted && _connectionState != DeviceConnectionState.connected) {
          _onDisconnectionDetected('Fallo en intento de reconexión');
        }
      });
    });
  }

  Future<void> _saveDeviceToIsar(String deviceId, String name) async {
    final newDevice = BleDeviceModel()
      ..deviceId = deviceId
      ..name = name
      ..lastConnected = DateTime.now();

    await widget.isar.writeTxn(() async {
      await widget.isar.bleDeviceModels.put(newDevice);
    });
  }

  void _stopMonitoringAndStreams() {
    _reconnectTimer?.cancel();
    _stopReconnectScan();
    _connectionStateSubscription?.cancel();
    _reconnectConnectionStream?.cancel();
  }

  @override
  void dispose() {
    _stopMonitoringAndStreams();
    super.dispose();
  }

  Color _getSignalColor() {
    if (_isReconnecting || _connectionState != DeviceConnectionState.connected) {
      return Colors.orange.shade800;
    }
    return Colors.green; // Si está conectado, mostramos verde porque ya no leemos RSSI constante.
  }

  Future<void> _sendCommand(Command command, String actionText) async {
    _printCommandDetails(command, actionText);

    final List<int> payload = command.writeToBuffer();
    final Stopwatch stopwatch = Stopwatch()..start();

    if (_connectionState != DeviceConnectionState.connected || _isReconnecting) {
      debugPrint('[SEND] BLE link down. Sending command directamente via MQTT fallback...');
      await _executeMqttFallback(payload, actionText, stopwatch);
      return;
    }

    try {
      await _sendViaBle(payload);

      stopwatch.stop();
      if (mounted) {
        setState(() {
          _lastExecutionTime = '${stopwatch.elapsedMilliseconds} ms (BLE)';
        });
      }
      debugPrint('Successfully sent "$actionText" via BLE in ${stopwatch.elapsedMilliseconds} ms.');
    } catch (bleError) {
      debugPrint('BLE Error: $bleError. Falling back to MQTT...');
      _onDisconnectionDetected('Fallo en escritura BLE.');

      await _executeMqttFallback(payload, actionText, stopwatch);
    }
  }

  Future<void> _executeMqttFallback(List<int> payload, String actionText, Stopwatch stopwatch) async {
    try {
      await _sendViaMqtt(payload);

      stopwatch.stop();
      if (mounted) {
        setState(() {
          _lastExecutionTime = '${stopwatch.elapsedMilliseconds} ms (MQTT)';
        });
      }
      debugPrint('Successfully sent "$actionText" via MQTT in ${stopwatch.elapsedMilliseconds} ms.');
    } catch (mqttError) {
      stopwatch.stop();
      if (mounted) {
        setState(() {
          _lastExecutionTime = 'Error';
        });
      }
      debugPrint('MQTT Error: $mqttError. Total transmission failure.');
    }
  }

  void _printCommandDetails(Command command, String actionText) {
    debugPrint('\n========================================');
    debugPrint('[SENDING ORDER] $actionText');
    debugPrint('Command ID: ${command.commandId}');

    if (command.hasOnOff()) {
      debugPrint('Argument [OnOff]: ${command.onOff}');
    } else if (command.hasLevel()) {
      debugPrint('Argument [Level]: ${command.level}');
    } else if (command.hasRange()) {
      debugPrint('Argument [Range]: min = ${command.range.minimum}, max = ${command.range.maximum}');
    } else if (command.hasFanSpeed()) {
      debugPrint('Argument [FanSpeed]: ${command.fanSpeed}');
    } else if (command.hasBurnMode()) {
      debugPrint('Argument [BurnMode]: ${command.burnMode}');
    } else if (command.hasIgnitionSettings()) {
      debugPrint('Argument [IgnitionSettings]: Method = ${command.ignitionSettings.ignitionMethod}, State = ${command.ignitionSettings.ignaterState}');
    } else {
      debugPrint('No specific or recognized arguments.');
    }
    debugPrint('========================================\n');
  }

  Future<void> _sendViaBle(List<int> payload) async {
    final characteristic = QualifiedCharacteristic(
      serviceId: targetServiceUuid,
      characteristicId: targetCharUuid,
      deviceId: widget.device.id,
    );

    await widget.ble.writeCharacteristicWithoutResponse(
      characteristic,
      value: payload,
    );
  }

  Future<void> _sendViaMqtt(List<int> payload) async {
    final client = MqttServerClient(mqttBrokerUrl, 'flutter_client_${DateTime.now().millisecondsSinceEpoch}');
    client.port = mqttPort;
    client.logging(on: false);
    client.keepAlivePeriod = 20;

    final status = await client.connect();
    if (status?.state != MqttConnectionState.connected) {
      client.disconnect();
      throw Exception('MQTT Connection Failed');
    }

    final Uint8Buffer dataBuffer = Uint8Buffer()..addAll(payload);
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addBuffer(dataBuffer);

    client.publishMessage(mqttTopic, MqttQos.atLeastOnce, builder.payload!);
    client.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    final signalColor = _getSignalColor();
    final bool isNotConnected = _connectionState != DeviceConnectionState.connected || _isReconnecting;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name.isEmpty ? 'Si917 Device' : widget.device.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            tooltip: 'Olvidar dispositivo',
            onPressed: () async {
              _isDisconnecting = true;
              await widget.isar.writeTxn(() async {
                await widget.isar.bleDeviceModels.clear();
              });
              if (!mounted) return;

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- RSSI SIGNAL STRENGTH CARD ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.wifi_tethering, color: signalColor, size: 28),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Signal Strength', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  'Static (Initial)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: signalColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Chip(
                          label: Text(
                            _isReconnecting
                                ? 'Buscando dispositivo...'
                                : (_connectionState == DeviceConnectionState.disconnected
                                ? 'Desconectado'
                                : 'Conectado'),
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: signalColor,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: ((_currentRssi + 100) / 70).clamp(0.0, 1.0),
                      color: signalColor,
                      backgroundColor: Colors.grey.shade200,
                      minHeight: 6,
                    ),

                    // --- MANUAL RECONNECT BUTTON ---
                    if (isNotConnected) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 38,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.orange.shade900,
                            side: BorderSide(color: Colors.orange.shade700),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          icon: _isReconnecting
                              ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange),
                          )
                              : const Icon(Icons.refresh, size: 18),
                          label: Text(
                            _isReconnecting
                                ? 'Escaneando (hasta 15s)...'
                                : 'Reconectar BLE Manualmente',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          onPressed: _isReconnecting
                              ? null
                              : () {
                            _startScan(targetNameFilter: widget.device.name);
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // --- COMMAND EXECUTION TIME INDICATOR BADGE ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    'Last Order Latency: ',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                  Text(
                    _lastExecutionTime,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _lastExecutionTime.contains('BLE')
                          ? Colors.green.shade700
                          : (_lastExecutionTime.contains('MQTT')
                          ? Colors.orange.shade800
                          : Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            const Icon(Icons.fireplace, size: 40, color: Colors.deepOrange),
            const SizedBox(height: 4),
            const Text(
              'Control Panel (BLE with MQTT Fallback)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text('ID: ${widget.device.id}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
            const Divider(height: 20),

            // --- COMMAND BUTTONS LIST ---
            Expanded(
              child: ListView(
                children: [
                  _buildCommandButton(
                    icon: Icons.power,
                    label: 'TURN STOVE ON',
                    color: Colors.green.shade600,
                    command: Command()..commandId = 2..onOff = true,
                  ),
                  const SizedBox(height: 10),
                  _buildCommandButton(
                    icon: Icons.power_off,
                    label: 'TURN STOVE OFF',
                    color: Colors.red.shade600,
                    command: Command()..commandId = 2..onOff = false,
                  ),
                  const Divider(height: 20),

                  _buildCommandButton(
                    icon: Icons.layers,
                    label: 'SET LEVEL (Level: 3)',
                    color: Colors.blue.shade600,
                    command: Command()..commandId = 4..level = 3,
                  ),
                  const SizedBox(height: 10),

                  _buildCommandButton(
                    icon: Icons.tune,
                    label: 'SET RANGE (Min: 10, Max: 80)',
                    color: Colors.indigo.shade600,
                    command: Command()..commandId = 7..range = (Range()..minimum = 10..maximum = 80),
                  ),
                  const SizedBox(height: 10),

                  _buildCommandButton(
                    icon: Icons.air,
                    label: 'FAN SPEED (MEDIUM)',
                    color: Colors.teal.shade600,
                    command: Command()..commandId = 11..fanSpeed = FanSpeed.FAN_SPEED_MEDIUM,
                  ),
                  const SizedBox(height: 10),

                  _buildCommandButton(
                    icon: Icons.local_fire_department,
                    label: 'BURN MODE (ROOM SENSING)',
                    color: Colors.deepOrange.shade600,
                    command: Command()..commandId = 10..burnMode = BurnMode.ROOM_SENSING,
                  ),
                  const SizedBox(height: 10),

                  _buildCommandButton(
                    icon: Icons.bolt,
                    label: 'AUTOMATIC IGNITION',
                    color: Colors.amber.shade800,
                    command: Command()
                      ..commandId = 8
                      ..ignitionSettings = (IgnitionSettings()
                        ..ignitionMethod = IgnitionMethod.AUTOMATIC
                        ..ignaterState = IgniterState.ACTIVE),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommandButton({
    required IconData icon,
    required String label,
    required Color color,
    required Command command,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        onPressed: () => _sendCommand(command, label),
      ),
    );
  }
}