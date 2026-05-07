import 'package:finance_tracking/config/entities/user_profile_entity.dart';

class RemoteUserProfileModel {
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

  RemoteUserProfileModel({
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

  factory RemoteUserProfileModel.fromSupabase(Map<String, dynamic> map) {
    return RemoteUserProfileModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      weeklySpending: map['weekly_spending'] ?? "0",
      forGoal: map['for_goal'] ?? false,
      currentMoney: map['current_money'] ?? "0",
      createdAt: DateTime.parse(
        map['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      currentStreak: int.tryParse(map['current_streak']?.toString() ?? '0') ?? 0,
      longestStreak: int.tryParse(map['longest_streak']?.toString() ?? '0') ?? 0,
      lastCheckInDate: map['last_check_in_date'] != null
          ? DateTime.tryParse(map['last_check_in_date'].toString())?.toUtc()
          : null,
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
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      if (lastCheckInDate != null)
        'last_check_in_date': lastCheckInDate!.toUtc().toIso8601String(),
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
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastCheckInDate: lastCheckInDate,
    );
  }

  RemoteUserProfileModel copyWith({
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
    return RemoteUserProfileModel(
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
}
