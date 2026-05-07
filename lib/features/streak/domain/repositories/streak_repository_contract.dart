import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/streak/domain/entities/streak_entity.dart';

abstract class StreakRepositoryContract {
  Future<Either<String, StreakEntity>> getStreak();
  Future<Either<String, StreakEntity>> recordCheckIn();
}
