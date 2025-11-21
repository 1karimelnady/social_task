import 'package:dartz/dartz.dart';
import 'package:social_task/core/exeptions/failure.dart';
import 'package:social_task/features/auth/domain/entities/device_entity.dart';


abstract class SettingsBaseRepository {
  Future<Either<Failure, String>> getWebUrl();
  Future<Either<Failure, void>> saveWebUrl(String url);
  Future<Either<Failure, List<DeviceEntity>>> getAvailableDevices();
}