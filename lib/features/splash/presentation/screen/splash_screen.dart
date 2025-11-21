import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_task/core/utils/assets_manager.dart';
import 'package:social_task/core/utils/colors_manager.dart';
import 'package:social_task/features/auth/presentation/screens/login_screen.dart';
import 'package:social_task/features/auth/presentation/screens/settings_screen.dart';
import 'package:social_task/features/splash/presentation/bloc/spalsh_state.dart';
import 'package:social_task/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:social_task/features/splash/presentation/bloc/splash_event.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      context.read<SplashBloc>().add(GetUserStatusEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      body: BlocListener<SplashBloc, SpalshState>(
        listener: (context, state) {
          if (state is OpenHomeScreenState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.asset(AssetsManager.splash),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
