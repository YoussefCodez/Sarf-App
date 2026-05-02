import 'package:equatable/equatable.dart';
import 'package:finance_tracking/config/entities/user_profile_entity.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'local_user_profile_model.g.dart';

@HiveType(typeId: 1)
class LocalUserProfileModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String weeklySpending;
  @HiveField(4)
  final bool forGoal;
  @HiveField(5)
  final DateTime createdAt;
  @HiveField(6, defaultValue: "0")
  final String currentMoney; 

  LocalUserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.weeklySpending,
    required this.forGoal,
    required this.createdAt,
    required this.currentMoney,
  });

  factory LocalUserProfileModel.fromEntity(UserProfileEntity entity) {
    return LocalUserProfileModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      weeklySpending: entity.weeklySpending,
      forGoal: entity.forGoal,
      createdAt: entity.createdAt,
      currentMoney: entity.currentMoney,
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      name: name,
      email: email,
      weeklySpending: weeklySpending,
      forGoal: forGoal,
      createdAt: createdAt,
      currentMoney: currentMoney,
    );
  }

  LocalUserProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? weeklySpending,
    bool? forGoal,
    DateTime? createdAt,
    String? currentMoney,
  }) {
    return LocalUserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      weeklySpending: weeklySpending ?? this.weeklySpending,
      forGoal: forGoal ?? this.forGoal,
      createdAt: createdAt ?? this.createdAt,
      currentMoney: currentMoney ?? this.currentMoney,
    );
  }

  @override
  List<Object?> get props => [id, name, email, weeklySpending, forGoal, createdAt, currentMoney];
}
