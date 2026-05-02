import 'package:finance_tracking/config/entities/user_profile_entity.dart';

class RemoteUserProfileModel extends UserProfileEntity {
  RemoteUserProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.weeklySpending,
    required super.forGoal,
    required super.currentMoney,
    required super.createdAt,
  });

  factory RemoteUserProfileModel.fromSupabase(Map<String, dynamic> map) {
    return RemoteUserProfileModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      weeklySpending: map['weekly_spending'] ?? "0",
      forGoal: map['for_goal'] ?? false,
      currentMoney: map['current_money'] ?? "0",
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
      'current_money': currentMoney,
      'created_at': createdAt.toIso8601String(),
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      name: name,
      email: email,
      weeklySpending: weeklySpending,
      forGoal: forGoal,
      currentMoney: currentMoney,
      createdAt: createdAt,
    );
  }

  @override
  RemoteUserProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? weeklySpending,
    bool? forGoal,
    String? currentMoney,
    DateTime? createdAt,
  }) {
    return RemoteUserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      weeklySpending: weeklySpending ?? this.weeklySpending,
      forGoal: forGoal ?? this.forGoal,
      currentMoney: currentMoney ?? this.currentMoney,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}