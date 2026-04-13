import '../entities/goal_entity.dart';

abstract interface class GoalRepository {
  Future<void> addGoal(GoalEntity goal);
}
