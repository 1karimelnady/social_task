import 'package:equatable/equatable.dart';

class DeviceEntity extends Equatable {
  final String name;
  final String address;

  const DeviceEntity({required this.name, required this.address});

  @override
  List<Object?> get props => [name, address];
}