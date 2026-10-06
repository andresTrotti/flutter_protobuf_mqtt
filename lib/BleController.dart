import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';

class BleController {
  final flutterReactiveBle = FlutterReactiveBle();
  StreamSubscription<DiscoveredDevice>? _scanStream;
  StreamSubscription<ConnectionStateUpdate>? _connectionStream;

  void discoverAndConnect() {
    print("Starting scan...");

    _scanStream = flutterReactiveBle.scanForDevices(
      withServices: [], // Add specific service UUIDs here if needed
      scanMode: ScanMode.lowLatency,
    ).listen((device) {
      if (device.name == "SL_MC_GATT_DEMO") {
        print("Si917 Found! Stopping scan...");
        _scanStream?.cancel();
        _connectToDevice(device.id);
      }
    }, onError: (Object error) {
      print("Scan error: $error");
    });
  }

  void _connectToDevice(String deviceId) {
    _connectionStream = flutterReactiveBle.connectToDevice(
      id: deviceId,
      connectionTimeout: const Duration(seconds: 10),
    ).listen((connectionStateUpdate) {
      print("Connection State: ${connectionStateUpdate.connectionState}");

      if (connectionStateUpdate.connectionState == DeviceConnectionState.connected) {
        print("Connected! The OS should prompt for the passkey (123456) when securing the link.");
        // Proceed to discover services and characteristics here
      }
    }, onError: (Object error) {
      print("Connection failed: $error");
    });
  }
}