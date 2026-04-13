import 'package:injectable/injectable.dart';
import '../entities/goal_entity.dart';
import '../repositories/goal_repository.dart';

@lazySingleton
class AddGoalUseCase {
  final GoalRepository _repository;

  AddGoalUseCase(this._repository);

  Future<void> execute(GoalEntity goal) async {
    return await _repository.addGoal(goal);
  }
}
