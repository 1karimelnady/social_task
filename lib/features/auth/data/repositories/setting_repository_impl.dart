import 'package:dartz/dartz.dart';
import 'package:social_task/core/exeptions/exeptions_handler.dart';
import 'package:social_task/core/exeptions/failure.dart';
import 'package:social_task/features/auth/data/data_source/device_connection_data_source.dart';
import 'package:social_task/features/auth/data/data_source/setting_local_data_source.dart';
import 'package:social_task/features/auth/domain/entities/device_entity.dart';
import 'package:social_task/features/auth/domain/repositories/setting_repository.dart';

class SettingsRepositoryImpl implements SettingsBaseRepository {
  final SettingsBaseDataSource settingsDataSource;
  final DeviceConnectionsBaseDataSource deviceConnectionsDataSource;

  SettingsRepositoryImpl({
    required this.settingsDataSource,
    required this.deviceConnectionsDataSource,
  });

  @override
  Future<Either<Failure, String>> getWebUrl() async {
    try {
      final url = await settingsDataSource.getWebUrl();
      return Right(url!);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveWebUrl(String url) async {
    try {
      await settingsDataSource.saveWebUrl(url);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<DeviceEntity>>> getAvailableDevices() async {
    try {
      final deviceModels = await deviceConnectionsDataSource.getAvailableDevices();
      final deviceEntities = deviceModels.map((m) => DeviceEntity(name: m.name, address: m.address)).toList();
      return Right(deviceEntities);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }
}