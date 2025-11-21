import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_task/core/exeptions/failure.dart';
import 'package:social_task/features/auth/domain/entities/user_entity.dart';
import 'package:social_task/features/auth/domain/use_cases/login_use_case.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LoginWithFacebookUseCase loginWithFacebookUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginWithGoogleUseCase,
    required this.loginWithFacebookUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
    on<LoginWithFacebookEvent>(_onLoginWithFacebook);
    on<LogoutEvent>(_onLogout);
  }

  void _onLoginWithGoogle(LoginWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginWithGoogleUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure: failure)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  void _onLoginWithFacebook(LoginWithFacebookEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginWithFacebookUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure: failure)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }
  
  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await logoutUseCase(NoParams());
    emit(AuthInitial());
  }
}