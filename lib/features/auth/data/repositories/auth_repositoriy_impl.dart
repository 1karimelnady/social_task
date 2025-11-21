import 'package:dartz/dartz.dart';
import 'package:social_task/core/exeptions/exeptions_handler.dart';
import 'package:social_task/core/exeptions/failure.dart';
import 'package:social_task/core/secure_storage/secure_storage_helper.dart';
import 'package:social_task/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:social_task/features/auth/domain/entities/user_entity.dart';
import 'package:social_task/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthBaseRepostiory {
  final AuthBaseRemoteDataSource authBaseRemoteDateSource;
  final SecureStorageHelper secureStorageHelper;

  AuthRepositoryImpl({
    required this.authBaseRemoteDateSource,
    required this.secureStorageHelper,
  });

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    try {
      final userModel = await authBaseRemoteDateSource.loginWithGoogle();
      return Right(userModel);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithFacebook() async {
    try {
      final userModel = await authBaseRemoteDateSource.loginWithFacebook();
      return Right(userModel);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }
  
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authBaseRemoteDateSource.logout();
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }
}