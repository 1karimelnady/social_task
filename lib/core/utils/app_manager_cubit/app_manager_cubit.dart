import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_task/core/utils/app_manager_cubit/app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(InitialAppMangerState());

  bool passwordVisibility = true;

  void passwordVisibile(String value) {
    if (value == 'visible') {
      passwordVisibility = !passwordVisibility;
      emit(PasswordVisibilityState());
    }
  }
}
