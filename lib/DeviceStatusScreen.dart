import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:isar/isar.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_data.dart';
import 'package:untitled/pellet_stove_commands.pb.dart';
import 'package:untitled/ble_device_model.dart';

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

  // RSSI, Heartbeat & Connection State
  late int _currentRssi;
  StreamSubscription<DiscoveredDevice>? _rssiSubscription;
  StreamSubscription<DiscoveredDevice>? _reconnectScanSubscription;
  StreamSubscription<ConnectionStateUpdate>? _connectionStateSubscription;
  StreamSubscription<ConnectionStateUpdate>? _reconnectStream;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimeoutTimer;

  bool _isDisconnecting = false;
  bool _isReconnecting = false;
  DeviceConnectionState _connectionState = DeviceConnectionState.connected;

  // --- RETRY MECHANISM CONTROL ---
  int _reconnectAttempts = 0;
  static const int maxReconnectAttempts = 8;
  static const int reconnectScanTimeoutSeconds = 15; // Scan window duration

  static const int rssiCutoffThreshold = -2000;

  @override
  void initState() {
    super.initState();
    _currentRssi = widget.device.rssi;
    _listenToConnectionState();
    _startInstantHeartbeatAndRssiMonitoring();
    // Solicitar alta prioridad inmediatamente al iniciar la pantalla
    _requestHighPerformance();
  }

  /// Pide al SO que se comunique más rápido con el dispositivo
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

  /// Listens to real-time BLE stack updates for this device
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
            _reconnectAttempts = 0;
          });
          _startRssiScanStream();
        }
      }
    });
  }

  /// Active Heartbeat (500ms): Pings the device via RSSI read to catch instant resets/power drops.
  /// Active Heartbeat (1 segundo): Pings the device via RSSI read with a STRICT TIMEOUT
  void _startInstantHeartbeatAndRssiMonitoring() {
    _startRssiScanStream();

    _heartbeatTimer?.cancel();
    // Aumentamos a 1000ms para no saturar el canal, pero imponemos un timeout de 800ms
    _heartbeatTimer = Timer.periodic(const Duration(milliseconds: 1000), (_) async {
      if (_isDisconnecting || _isReconnecting || _connectionState != DeviceConnectionState.connected) return;

      try {
        // Envolvemos la llamada al OS en un Timeout de Dart
        final rssi = await widget.ble.readRssi(widget.device.id).timeout(
          const Duration(milliseconds: 1500),
        );

        if (mounted) {
          setState(() {
            _currentRssi = rssi;
          });
        }
      } on TimeoutException {
        // Dart cancela la espera si pasaron 800ms sin respuesta del Si917
        debugPrint('⚠️ [HEARTBEAT TIMEOUT] El Si917 dejó de responder. Forzando desconexión rápida...');
        _onDisconnectionDetected('⏳ Dispositivo inalcanzable (Timeout). Intentando reconectar...');
      } catch (e) {
        // El OS reportó un error directamente
        debugPrint('⚠️ [INSTANT DISCONNECT DETECTED] Error de hardware/stack: $e');
        _onDisconnectionDetected('⚡ Conexión BLE perdida. Intentando reconectar...');
      }
    });
  }

  void _startRssiScanStream() {
    _rssiSubscription?.cancel();
    _rssiSubscription = widget.ble.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
    ).listen((discoveredDevice) {
      if (discoveredDevice.id == widget.device.id && mounted) {
        setState(() {
          _currentRssi = discoveredDevice.rssi;
        });
      }
    }, onError: (_) {});
  }

  void _stopRssiScanStream() {
    _rssiSubscription?.cancel();
    _rssiSubscription = null;
  }

  void _onDisconnectionDetected(String reason) {
    if (_isDisconnecting || _isReconnecting) return;

    if (mounted) {
      setState(() {
        _connectionState = DeviceConnectionState.disconnected;
      });
    }

    //_attemptBackgroundReconnection(resetCounter: true);
  }



  /// Immediate Background Reconnection Loop (Replicates the speed of the manual scan-then-connect button)
  void _attemptBackgroundReconnection({bool resetCounter = false}) {
    if (resetCounter) {
      _reconnectAttempts = 0;
    }

    if (_reconnectAttempts >= maxReconnectAttempts) {
      debugPrint('[RECONNECT] ❌ Reached max reconnection attempts ($maxReconnectAttempts). Stopping auto-retries.');
      setState(() {
        _isReconnecting = false;
      });
      return;
    }

    // Stop passive RSSI scan stream to clear the radio for an active targeted scan
    _stopRssiScanStream();

    _reconnectAttempts++;
    setState(() {
      _isReconnecting = true;
    });

    debugPrint('\n==================================================');
    debugPrint('[RECONNECT LOOP] Starting immediate scan attempt #$_reconnectAttempts / $maxReconnectAttempts...');

    _reconnectScanSubscription?.cancel();
    _reconnectStream?.cancel();
    _reconnectTimeoutTimer?.cancel();

    bool deviceMatchFound = false;

    // Scan for advertising packets immediately without arbitrary delays
    _reconnectScanSubscription = widget.ble.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
    ).listen((discoveredDevice) {
      if (discoveredDevice.id == widget.device.id && !deviceMatchFound) {
        deviceMatchFound = true;
        _reconnectTimeoutTimer?.cancel();

        debugPrint('[RECONNECT LOOP] 🎯 Si917 packet detected! Stopping scan and initiating GATT connection...');

        // Stop scanning instantly upon discovery to free up the BLE stack for connection
        _reconnectScanSubscription?.cancel();
        _reconnectScanSubscription = null;

        // Execute GATT connection
        _reconnectStream = widget.ble.connectToDevice(
          id: widget.device.id,
          connectionTimeout: const Duration(seconds: 15),
        ).listen((update) {
          debugPrint('[RECONNECT GATT STATUS] -> ${update.connectionState.name}');

          if (!mounted) return;

          setState(() {
            _connectionState = update.connectionState;
          });

          if (update.connectionState == DeviceConnectionState.connected) {
            debugPrint('✅ [RECONNECT SUCCESS] BLE connection restored on attempt #$_reconnectAttempts!');
            setState(() {
              _isReconnecting = false;
              _reconnectAttempts = 0;
            });

            _reconnectStream?.cancel();
            _reconnectStream = null;
            _startRssiScanStream();
          }
        }, onError: (error) {
          debugPrint('[RECONNECT GATT ERROR] ❌ Attempt #$_reconnectAttempts failed: $error');
          // Short 2s buffer to prevent Android throttling on immediate retry
          Timer(const Duration(seconds: 2), () {
            if (mounted && _connectionState != DeviceConnectionState.connected) {
              _attemptBackgroundReconnection(resetCounter: false);
            }
          });
        });
      }
    }, onError: (error) {
      debugPrint('[RECONNECT SCAN ERROR] ❌ Scan error on attempt #$_reconnectAttempts: $error');
      _reconnectTimeoutTimer?.cancel();
      // Short 2s buffer to prevent Android throttling on immediate retry
      Timer(const Duration(seconds: 2), () {
        if (mounted && _connectionState != DeviceConnectionState.connected) {
          _attemptBackgroundReconnection(resetCounter: false);
        }
      });
    });

    // Watchdog timeout for individual scan attempt (if Si917 hasn't rebooted yet)
    _reconnectTimeoutTimer = Timer(const Duration(seconds: reconnectScanTimeoutSeconds), () {
      if (!deviceMatchFound && _isReconnecting) {
        debugPrint('[RECONNECT LOOP] ⚠️ Attempt #$_reconnectAttempts timed out after ${reconnectScanTimeoutSeconds}s.');
        _reconnectScanSubscription?.cancel();

        if (mounted && _connectionState != DeviceConnectionState.connected) {
          _attemptBackgroundReconnection(resetCounter: false);
        }
      }
    });
  }

  void _stopMonitoringAndStreams() {
    _heartbeatTimer?.cancel();
    _reconnectTimeoutTimer?.cancel();
    _stopRssiScanStream();
    _reconnectScanSubscription?.cancel();
    _connectionStateSubscription?.cancel();
    _reconnectStream?.cancel();
  }

  @override
  void dispose() {
    _stopMonitoringAndStreams();
    super.dispose();
  }

  Color _getSignalColor(int rssi) {
    if (_isReconnecting || _connectionState != DeviceConnectionState.connected) {
      return Colors.orange.shade800;
    }
    if (rssi >= -65) return Colors.green;
    if (rssi >= -78) return Colors.orange;
    return Colors.red;
  }

  /// Main routing function: Tries BLE, falls back directly to MQTT if disconnected or write fails.
  Future<void> _sendCommand(Command command, String actionText) async {
    _printCommandDetails(command, actionText);

    final List<int> payload = command.writeToBuffer();
    final Stopwatch stopwatch = Stopwatch()..start();

    if (_connectionState != DeviceConnectionState.connected || _isReconnecting) {
      debugPrint('[SEND] BLE link down. Sending command directly via MQTT fallback...');
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
    final signalColor = _getSignalColor(_currentRssi);
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
                                const Text('Signal Strength (RSSI)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  '$_currentRssi dBm',
                                  style: TextStyle(
                                    fontSize: 18,
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
                                ? 'Reconectando ($_reconnectAttempts/$maxReconnectAttempts)...'
                                : (_connectionState == DeviceConnectionState.disconnected
                                ? 'Disconnected'
                                : (_currentRssi < rssiCutoffThreshold ? 'Out of Range' : 'Connected')),
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
                                ? 'Reconectando ($_reconnectAttempts/$maxReconnectAttempts)...'
                                : 'Reconectar BLE Manualmente',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          onPressed: _isReconnecting
                              ? null
                              : () {
                            _attemptBackgroundReconnection(resetCounter: true);
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