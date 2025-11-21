

import 'package:social_task/core/exeptions/exeptions.dart';

class DeviceModel {
  final String name;
  final String address;
  final String type; 

  DeviceModel({required this.name, required this.address, required this.type});
}

abstract class DeviceConnectionsBaseDataSource {
  Future<List<DeviceModel>> getAvailableDevices();
}

class DeviceConnectionsDataSourceImpl implements DeviceConnectionsBaseDataSource {
 

  @override
  Future<List<DeviceModel>> getAvailableDevices() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); 
      

      
      return [
        DeviceModel(name: 'Office Printer B300', address: '192.168.1.50', type: 'Wi-Fi'),
        DeviceModel(name: 'Bluetooth POS 01', address: 'AA:BB:CC:DD:EE:FF', type: 'Bluetooth'),
        DeviceModel(name: 'Network Scanner', address: '192.168.1.51', type: 'Wi-Fi'),
      ];
    } catch (e) {
      throw ExceptionWithMessage(message: "Failed to scan devices.");
    }
  }
}