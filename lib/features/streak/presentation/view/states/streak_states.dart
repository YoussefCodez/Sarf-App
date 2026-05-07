import 'package:finance_tracking/features/streak/domain/entities/streak_entity.dart';

sealed class StreakState {}

class StreakInitial extends StreakState {}

class StreakLoading extends StreakState {}

class StreakSuccess extends StreakState {
  final StreakEntity streak;

  StreakSuccess(this.streak);
}

class StreakError extends StreakState {
  final String error;

  StreakError(this.error);
}
