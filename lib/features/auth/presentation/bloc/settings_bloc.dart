import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_task/core/exeptions/failure.dart';
import 'package:social_task/features/auth/domain/entities/device_entity.dart';
import 'package:social_task/features/auth/domain/use_cases/login_use_case.dart';
import 'package:social_task/features/auth/domain/use_cases/save_url_use_case.dart';


part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetUrlUseCase getUrlUseCase;
  final SaveUrlUseCase saveUrlUseCase;
  final GetDevicesUseCase getDevicesUseCase;

  SettingsBloc({
    required this.getUrlUseCase,
    required this.saveUrlUseCase,
    required this.getDevicesUseCase,
  }) : super(SettingsInitial()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<SaveUrlEvent>(_onSaveUrl);
    on<LoadDevicesEvent>(_onLoadDevices);
  }

  void _onLoadSettings(LoadSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    final urlResult = await getUrlUseCase(NoParams());
    
    urlResult.fold(
      (failure) => emit(const SettingsLoaded(url: '', devices: [])),
      (url) => emit(SettingsLoaded(url: url, devices: state.devices)),
    );
    add(LoadDevicesEvent());
  }
  
  void _onSaveUrl(SaveUrlEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    final result = await saveUrlUseCase(SaveUrlParams(url: event.url));

    await Future.delayed(const Duration(milliseconds: 500));

    result.fold(
      (failure) => emit(SettingsError(failure: failure)),
      (_) => emit(SettingsUrlSaved(url: event.url, devices: state.devices)),
    );
  }

  void _onLoadDevices(LoadDevicesEvent event, Emitter<SettingsState> emit) async {
    final result = await getDevicesUseCase(NoParams());
    
    result.fold(
      (failure) => emit(SettingsLoaded(url: state.url, devices: [], devicesError: failure)),
      (devices) => emit(SettingsLoaded(url: state.url, devices: devices)),
    );
  }
}