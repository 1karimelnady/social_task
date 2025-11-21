import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_task/core/secure_storage/secure_storage_helper.dart';
import 'package:social_task/features/splash/presentation/bloc/spalsh_state.dart';
import 'package:social_task/features/splash/presentation/bloc/splash_event.dart';


class SplashBloc extends Bloc<SplashEvent, SpalshState> {
  final SecureStorageHelper _secureStorageHelper;

  SplashBloc({required SecureStorageHelper secureStorageHelper})
    : _secureStorageHelper = secureStorageHelper,
      super(SplashInitial()) {
    on<GetUserStatusEvent>((event, emit) async {
      final token = await _secureStorageHelper.getToken();
      token.fold(
        (l) {
          emit(OpenAuthScreenState());
        },
        (r) {
          emit(OpenHomeScreenState());
        },
      );
    });
  }
}
