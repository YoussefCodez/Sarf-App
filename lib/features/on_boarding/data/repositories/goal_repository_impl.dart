import 'package:injectable/injectable.dart';
import '../../domain/entities/goal_entity.dart';
import '../../domain/repositories/goal_repository.dart';
import '../datasources/goal_local_datasource.dart';
import '../models/local_goal_model.dart';

@LazySingleton(as: GoalRepository)
class GoalRepositoryImpl implements GoalRepository {
  final GoalLocalDataSource _localDataSource;

  GoalRepositoryImpl(this._localDataSource);

  @override
  Future<void> addGoal(GoalEntity goal) async {
    final model = LocalGoalModel.fromEntity(goal);
    await _localDataSource.addGoal(model);
  }
}
