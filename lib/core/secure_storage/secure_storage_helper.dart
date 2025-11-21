import 'package:dartz/dartz.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:social_task/core/exeptions/exeptions.dart';
import 'package:social_task/core/secure_storage/secure_storage_constants.dart';

abstract class SecureStorageHelper {
  Future<void> assignData({required String key, required String value});
  Future<Either<ForbiddenException, String>> getToken();
  Future<void> deleteData({required String key});
}

class SecureStorageHelperImpl implements SecureStorageHelper {
  SecureStorageHelperImpl._();

  static SecureStorageHelper? _instance;

  static Future<SecureStorageHelper> getInstance() async {
    _instance ??= SecureStorageHelperImpl._();

    return _instance!;
  }

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static IOSOptions _getIosOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  final FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
    iOptions: _getIosOptions(),
  );

  @override
  Future<void> assignData({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<Either<ForbiddenException, String>> getToken() async {
    final token = await _storage.read(key: SecureStorageConstants.token);
    if (token == null) {
      return Left(ForbiddenException());
    }

    return Right(token);
  }

  @override
  Future<void> deleteData({required String key}) async {
    await _storage.delete(key: key);
  }
}
