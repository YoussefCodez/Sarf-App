import 'package:finance_tracking/config/entities/user_profile_entity.dart';

class RemoteUserProfileModel extends UserProfileEntity {
  RemoteUserProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.weeklySpending,
    required super.forGoal,
    required super.createdAt,
  });

  factory RemoteUserProfileModel.fromSupabase(Map<String, dynamic> map) {
    return RemoteUserProfileModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      weeklySpending: map['weekly_spending'] ?? "0",
      forGoal: map['for_goal'] ?? false,
      createdAt: DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'weekly_spending': weeklySpending,
      'for_goal': forGoal,
      'created_at': createdAt.toIso8601String(),
    };
  }

  RemoteUserProfileModel copyWith({String? id}) {
    return RemoteUserProfileModel(
      id: id ?? this.id,
      name: name,
      email: email,
      weeklySpending: weeklySpending,
      forGoal: forGoal,
      createdAt: createdAt,
    );
  }
}