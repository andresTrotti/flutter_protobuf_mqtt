import 'package:isar/isar.dart';

part 'ble_device_model.g.dart';

@collection
class BleDeviceModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String deviceId;

  String? name;
  DateTime? lastConnected;
}