import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_task/core/services/service.dart';
import 'package:social_task/core/utils/app_manager_cubit/app_manager_cubit.dart';
import 'package:social_task/core/utils/theme_manager.dart';
import 'package:social_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:social_task/features/auth/presentation/bloc/settings_bloc.dart';
import 'package:social_task/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:social_task/features/splash/presentation/screen/splash_screen.dart';
import 'package:social_task/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  await Future.wait([getItSetup()]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppManagerCubit()),
        BlocProvider(create: (context) => sl<SplashBloc>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<SettingsBloc>()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      enableScaleText: () => true,
      enableScaleWH: () => true,
      ensureScreenSize: true,

      builder: (_, child) {
        return MaterialApp(

          debugShowCheckedModeBanner: false,
          home: child,
          theme: ThemeManager.lightTheme(context),
        );
      },
      child: const SplashScreen(),
    );
  }
}
