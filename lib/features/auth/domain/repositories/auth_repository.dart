import 'package:dartz/dartz.dart';
import 'package:social_task/core/exeptions/failure.dart';
import 'package:social_task/features/auth/domain/entities/user_entity.dart';

abstract class AuthBaseRepostiory {
  Future<Either<Failure, UserEntity>> loginWithGoogle();
  Future<Either<Failure, UserEntity>> loginWithFacebook();
  Future<Either<Failure, void>> logout();
}