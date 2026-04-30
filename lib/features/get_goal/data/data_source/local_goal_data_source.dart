import 'package:finance_tracking/features/get_goal/data/models/home_local_goal_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

abstract interface class LocalGoalDataSource {
  Future<void> saveGoal(HomeLocalGoalModel goal);
  Future<HomeLocalGoalModel?> getGoal();
  Future<void> clearGoal();
}

@LazySingleton(as: LocalGoalDataSource)
class LocalGoalDataSourceImpl implements LocalGoalDataSource {
  final HiveInterface _hive;
  static const String _boxName = 'home_goal_box';
  static const String _goalKey = 'current_goal';

  LocalGoalDataSourceImpl(this._hive);

  @override
  Future<void> saveGoal(HomeLocalGoalModel goal) async {
    final box = await _hive.openBox(_boxName);
    await box.put(_goalKey, goal);
  }

  @override
  Future<HomeLocalGoalModel?> getGoal() async {
    final box = await _hive.openBox(_boxName);
    return box.get(_goalKey);
  }

  @override
  Future<void> clearGoal() async {
    final box = await _hive.openBox(_boxName);
    await box.delete(_goalKey);
  }
}