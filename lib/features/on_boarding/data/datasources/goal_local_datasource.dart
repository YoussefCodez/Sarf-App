import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';
import '../models/local_goal_model.dart';

abstract interface class GoalLocalDataSource {
  Future<void> addGoal(LocalGoalModel goal);
}

@LazySingleton(as: GoalLocalDataSource)
class GoalLocalDataSourceImpl implements GoalLocalDataSource {
  final HiveInterface _hive;
  static const String _boxName = 'goals_box';

  GoalLocalDataSourceImpl(this._hive);

  @override
  Future<void> addGoal(LocalGoalModel goal) async {
    final box = await _hive.openBox<LocalGoalModel>(_boxName);
    await box.add(goal);
  }
}
