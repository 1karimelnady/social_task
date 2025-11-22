import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_task/core/services/service.dart';
import 'package:social_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:social_task/features/auth/presentation/screens/settings_screen.dart'; 
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Login')),
      body: BlocProvider(
        create: (context) => sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Welcome, ${state.user.name}')),
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginWithGoogleEvent());
                    },
                    icon: const Icon(Icons.g_mobiledata),
                    label: const Text('Login with Google'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginWithFacebookEvent());
                    },
                    icon: const Icon(Icons.facebook),
                    label: const Text('Login with Facebook'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}