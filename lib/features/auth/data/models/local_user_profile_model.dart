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
  @HiveField(7, defaultValue: 0)
  final int currentStreak;
  @HiveField(8, defaultValue: 0)
  final int longestStreak;
  @HiveField(9)
  final DateTime? lastCheckInDate;

  LocalUserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.weeklySpending,
    required this.forGoal,
    required this.createdAt,
    required this.currentMoney,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastCheckInDate,
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
      currentStreak: entity.currentStreak,
      longestStreak: entity.longestStreak,
      lastCheckInDate: entity.lastCheckInDate,
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
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastCheckInDate: lastCheckInDate,
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
    int? currentStreak,
    int? longestStreak,
    DateTime? lastCheckInDate,
  }) {
    return LocalUserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      weeklySpending: weeklySpending ?? this.weeklySpending,
      forGoal: forGoal ?? this.forGoal,
      createdAt: createdAt ?? this.createdAt,
      currentMoney: currentMoney ?? this.currentMoney,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastCheckInDate: lastCheckInDate ?? this.lastCheckInDate,
    );
  }

  @override
  List<Object?> get props => [id, name, email, weeklySpending, forGoal, createdAt, currentMoney, currentStreak, longestStreak, lastCheckInDate];
}
