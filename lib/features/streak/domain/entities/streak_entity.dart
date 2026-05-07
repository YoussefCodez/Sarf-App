import 'package:equatable/equatable.dart';

class StreakEntity extends Equatable {
  final String userId;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastCheckInDate;

  const StreakEntity({
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastCheckInDate,
  });

  @override
  List<Object?> get props => [userId, currentStreak, longestStreak, lastCheckInDate];
}
