
import 'package:social_task/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromFirebaseUser(String id, String name, String email) {
    return UserModel(
      id: id,
      name: name,
      email: email,
    );
  }
}