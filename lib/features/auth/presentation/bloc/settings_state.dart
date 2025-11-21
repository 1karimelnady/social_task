part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final String url;
  final List<DeviceEntity> devices;

  const SettingsState({this.url = '', this.devices = const []});
  @override
  List<Object> get props => [url, devices];
}

class SettingsInitial extends SettingsState {}
class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final Failure? devicesError;

  const SettingsLoaded({
    required super.url,
    required super.devices,
    this.devicesError,
  });
  
  @override
  List<Object> get props => [url, devices, devicesError ?? ''];
}

class SettingsUrlSaved extends SettingsState {
  const SettingsUrlSaved({required super.url, required super.devices});
}

class SettingsError extends SettingsState {
  final Failure failure;
  const SettingsError({required this.failure, super.url = '', super.devices = const []});
  @override
  List<Object> get props => [failure, url, devices];
}