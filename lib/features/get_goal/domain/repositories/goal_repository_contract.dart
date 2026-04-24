import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/remote_goal_entity.dart';

abstract interface class GoalRepositoryContract {
  Future<Either<String, RemoteGoalEntity>> getGoal();
}
