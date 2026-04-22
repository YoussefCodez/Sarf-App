import 'package:injectable/injectable.dart';
import '../../domain/entities/goal_entity.dart';
import '../../domain/repositories/goal_repository.dart';
import '../datasources/goal_local_datasource.dart';
import '../models/local_goal_model.dart';
import '../datasources/on_boarding_local_datasource.dart';

@LazySingleton(as: GoalRepository)
class GoalRepositoryImpl implements GoalRepository {
  final GoalLocalDataSource _localDataSource;
  final OnBoardingLocalDataSource _onBoardingLocalDataSource;

  GoalRepositoryImpl(this._localDataSource, this._onBoardingLocalDataSource);

  @override
  Future<void> addGoal(GoalEntity goal) async {
    final modelForGoalsBox = LocalGoalModel.fromEntity(goal);
    final modelForSettingsBox = LocalGoalModel.fromEntity(goal);
    await _localDataSource.addGoal(modelForGoalsBox);
    await _onBoardingLocalDataSource.saveGoal(modelForSettingsBox);
  }
}
