import 'package:finance_tracking/features/auth/domain/entities/auth_user_entity.dart';

class AuthUserModel extends AuthUserEntity {
  AuthUserModel({required super.id, required super.name, required super.email});

  factory AuthUserModel.fromSupabase(Map<String, dynamic> map) {
    return AuthUserModel(
      id: map['id'] ?? "000",
      name: map['name'] ?? "Unknown",
      email: map['email'] ?? "Unknown",
    );
  }

  Map<String, dynamic> toSupabase() {
    return {'id': id, 'name': name, 'email': email};
  }
}
