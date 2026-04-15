import 'package:finance_tracking/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromSupabase(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? "000",
      name: map['name'] ?? "Unknown",
      email: map['email'] ?? "Unknown",
    );
  }

  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
