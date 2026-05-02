import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String weeklySpending;
  final bool forGoal;
  final String currentMoney;
  final DateTime createdAt;
  
  const UserProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.weeklySpending,
    required this.forGoal,
    required this.currentMoney,
    required this.createdAt,
  });

  UserProfileEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? weeklySpending,
    bool? forGoal,
    String? currentMoney,
    DateTime? createdAt,
  }) {
    return UserProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      weeklySpending: weeklySpending ?? this.weeklySpending,
      forGoal: forGoal ?? this.forGoal,
      currentMoney: currentMoney ?? this.currentMoney,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, email, weeklySpending, forGoal, currentMoney, createdAt];
}