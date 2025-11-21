import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:social_task/core/exeptions/failure.dart';
import 'package:social_task/features/auth/domain/entities/user_entity.dart';
import 'package:social_task/features/auth/domain/repositories/auth_repository.dart';

// No params needed for social login
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginWithGoogleUseCase {
  final AuthBaseRepostiory authBaseRepostiory;
  LoginWithGoogleUseCase({required this.authBaseRepostiory});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authBaseRepostiory.loginWithGoogle();
  }
}

class LoginWithFacebookUseCase {
  final AuthBaseRepostiory authBaseRepostiory;
  LoginWithFacebookUseCase({required this.authBaseRepostiory});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authBaseRepostiory.loginWithFacebook();
  }
}

class LogoutUseCase {
  final AuthBaseRepostiory authBaseRepostiory;
  LogoutUseCase({required this.authBaseRepostiory});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authBaseRepostiory.logout();
  }
}