import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String weeklySpending;
  final bool forGoal;
  final String currentMoney;
  final DateTime createdAt;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastCheckInDate;
  const UserProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.weeklySpending,
    required this.forGoal,
    required this.currentMoney,
    required this.createdAt,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastCheckInDate,
  });

  UserProfileEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? weeklySpending,
    bool? forGoal,
    String? currentMoney,
    DateTime? createdAt,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastCheckInDate,
  }) {
    return UserProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      weeklySpending: weeklySpending ?? this.weeklySpending,
      forGoal: forGoal ?? this.forGoal,
      currentMoney: currentMoney ?? this.currentMoney,
      createdAt: createdAt ?? this.createdAt,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastCheckInDate: lastCheckInDate ?? this.lastCheckInDate,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    weeklySpending,
    forGoal,
    currentMoney,
    createdAt,
    currentStreak,
    longestStreak,
    lastCheckInDate,
  ];
}
