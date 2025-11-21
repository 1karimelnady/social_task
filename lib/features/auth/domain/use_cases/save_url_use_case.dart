import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:social_task/core/exeptions/failure.dart';
import 'package:social_task/features/auth/domain/entities/device_entity.dart';
import 'package:social_task/features/auth/domain/repositories/setting_repository.dart';
import 'package:social_task/features/auth/domain/use_cases/login_use_case.dart';
class SaveUrlParams extends Equatable {
  final String url;
  const SaveUrlParams({required this.url});
  @override
  List<Object?> get props => [url];
}

class SaveUrlUseCase {
  final SettingsBaseRepository settingsRepository;
  SaveUrlUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, void>> call(SaveUrlParams params) async {
    return await settingsRepository.saveWebUrl(params.url);
  }
}

class GetUrlUseCase {
  final SettingsBaseRepository settingsRepository;
  GetUrlUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await settingsRepository.getWebUrl();
  }
}

class GetDevicesUseCase {
  final SettingsBaseRepository settingsRepository;
  GetDevicesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<DeviceEntity>>> call(NoParams params) async {
    return await settingsRepository.getAvailableDevices();
  }
}