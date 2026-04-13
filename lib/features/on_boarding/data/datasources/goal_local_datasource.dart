import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';
import '../models/goal_model.dart';

abstract interface class GoalLocalDataSource {
  Future<void> addGoal(GoalModel goal);
}

@LazySingleton(as: GoalLocalDataSource)
class GoalLocalDataSourceImpl implements GoalLocalDataSource {
  final HiveInterface _hive;
  static const String _boxName = 'goals_box';

  GoalLocalDataSourceImpl(this._hive);

  @override
  Future<void> addGoal(GoalModel goal) async {
    final box = await _hive.openBox<GoalModel>(_boxName);
    await box.add(goal);
  }
}
