part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {}

class SaveUrlEvent extends SettingsEvent {
  final String url;
  const SaveUrlEvent({required this.url});
  @override
  List<Object> get props => [url];
}

class LoadDevicesEvent extends SettingsEvent {}