import 'package:equatable/equatable.dart';

sealed class SpalshState extends Equatable {
  const SpalshState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SpalshState {}

class OpenAuthScreenState extends SpalshState {}

class OpenHomeScreenState extends SpalshState {}
