import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String image;
  final String message;

  const Failure({required this.image, required this.message});

  @override
  List<Object?> get props => [image, message];
}
