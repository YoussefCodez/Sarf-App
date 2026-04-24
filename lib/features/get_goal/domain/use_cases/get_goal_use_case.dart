import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/remote_goal_entity.dart';
import 'package:finance_tracking/features/get_goal/domain/repositories/goal_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetGoalUseCase {
  final GoalRepositoryContract goalRepositoryContract;

  GetGoalUseCase({required this.goalRepositoryContract});

  Future<Either<String, RemoteGoalEntity>> call() async {
    return await goalRepositoryContract.getGoal();
  }
}
