
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_task/core/secure_storage/secure_storage_helper.dart';
import 'package:social_task/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:social_task/features/auth/data/data_source/device_connection_data_source.dart';
import 'package:social_task/features/auth/data/data_source/setting_local_data_source.dart';
import 'package:social_task/features/auth/data/repositories/auth_repositoriy_impl.dart';
import 'package:social_task/features/auth/data/repositories/setting_repository_impl.dart';
import 'package:social_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:social_task/features/auth/domain/repositories/setting_repository.dart';
import 'package:social_task/features/auth/domain/use_cases/login_use_case.dart';
import 'package:social_task/features/auth/domain/use_cases/save_url_use_case.dart';
import 'package:social_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:social_task/features/auth/presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> getItSetup() async {
  await _injectExternalDependencies();
  await _injectCore();
  injectDataSources();
  injectRepositories();
  injectUseCases();
  injectBlocs();
}

_injectExternalDependencies() async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

sl.registerLazySingleton<GoogleSignIn>(
  () => GoogleSignIn.instance

);

  sl.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);
}

_injectCore() async {
  const secStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  sl.registerLazySingleton<FlutterSecureStorage>(() => secStorage);
  final secureHelper = await SecureStorageHelperImpl.getInstance();
  sl.registerLazySingleton<SecureStorageHelper>(() => secureHelper);
}

injectDataSources() {
  sl.registerLazySingleton<AuthBaseRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      secureStorageHelper: sl(),
      firebaseAuth: sl(),
      googleSignIn: sl(),
      facebookAuth: sl(),
    ),
  );

  sl.registerLazySingleton<SettingsBaseDataSource>(
    () => SettingsDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<DeviceConnectionsBaseDataSource>(
    () => DeviceConnectionsDataSourceImpl(),
  );
}

injectRepositories() {
  sl.registerLazySingleton<AuthBaseRepostiory>(
    () => AuthRepositoryImpl(
      authBaseRemoteDateSource: sl(),
      secureStorageHelper: sl(),
    ),
  );

  sl.registerLazySingleton<SettingsBaseRepository>(
    () => SettingsRepositoryImpl(
      settingsDataSource: sl(),
      deviceConnectionsDataSource: sl(),
    ),
  );
}

injectUseCases() {
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(authBaseRepostiory: sl()));
  sl.registerLazySingleton(() => LoginWithFacebookUseCase(authBaseRepostiory: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(authBaseRepostiory: sl()));

  sl.registerLazySingleton(() => GetUrlUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => SaveUrlUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetDevicesUseCase(settingsRepository: sl()));
}

injectBlocs() {
  sl.registerFactory(() => AuthBloc(
    loginWithGoogleUseCase: sl(),
    loginWithFacebookUseCase: sl(),
    logoutUseCase: sl(),
  ));

  sl.registerFactory(() => SettingsBloc(
    getUrlUseCase: sl(),
    saveUrlUseCase: sl(),
    getDevicesUseCase: sl(),
  ));
}