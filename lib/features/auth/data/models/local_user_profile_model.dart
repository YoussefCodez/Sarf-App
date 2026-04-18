import 'package:finance_tracking/config/entities/user_profile_entity.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'local_user_profile_model.g.dart';

@HiveType(typeId: 1)
class LocalUserProfileModel extends HiveObject {
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

  LocalUserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.weeklySpending,
    required this.forGoal,
    required this.createdAt,
  });

  factory LocalUserProfileModel.fromEntity(UserProfileEntity entity) {
    return LocalUserProfileModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      weeklySpending: entity.weeklySpending,
      forGoal: entity.forGoal,
      createdAt: entity.createdAt,
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
    );
  }
}
