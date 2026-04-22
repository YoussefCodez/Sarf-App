import 'package:finance_tracking/features/on_boarding/data/models/local_goal_model.dart'
    as onboarding;
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

abstract interface class OnBoardingLocalDataSource {
  Future<void> saveTrackingReason(bool value);
  Future<void> saveWeeklySpending(double value);
  Future<void> saveEndOnBoarding(bool value);
  bool getEndOnBoarding();
  bool getTrackingReason();
  double getWeeklySpending();
  Future<void> saveGoal(onboarding.LocalGoalModel goal);
  onboarding.LocalGoalModel? getGoal();
  Future<void> clearOnBoardingData();
}

@LazySingleton(as: OnBoardingLocalDataSource)
class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {
  final HiveInterface _hive;
  static const String _boxName = 'settings_box';
  static const String _trackingKey = 'TrackingForReason';
  static const String _weeklySpendingKey = 'weeklySpending';
  static const String _endOnBoardingKey = 'endOnBoarding';
  static const String _goalKey = 'selectedGoal';

  OnBoardingLocalDataSourceImpl(this._hive);

  @override
  Future<void> saveTrackingReason(bool value) async {
    final box = await _hive.openBox(_boxName);
    await box.put(_trackingKey, value);
  }

  @override
  Future<void> saveWeeklySpending(double value) async {
    final box = await _hive.openBox(_boxName);
    await box.put(_weeklySpendingKey, value);
  }

  @override
  Future<void> saveEndOnBoarding(bool value) async {
    final box = await _hive.openBox(_boxName);
    await box.put(_endOnBoardingKey, value);
  }

  @override
  bool getEndOnBoarding() {
    if (!_hive.isBoxOpen(_boxName)) {
      return false;
    }
    final box = _hive.box(_boxName);
    return box.get(_endOnBoardingKey) ?? false;
  }

  @override
  bool getTrackingReason() {
    if (!_hive.isBoxOpen(_boxName)) return false;
    return _hive.box(_boxName).get(_trackingKey) ?? false;
  }

  @override
  double getWeeklySpending() {
    if (!_hive.isBoxOpen(_boxName)) return 0.0;
    return _hive.box(_boxName).get(_weeklySpendingKey) ?? 0.0;
  }

  @override
  Future<void> saveGoal(onboarding.LocalGoalModel goal) async {
    final box = await _hive.openBox(_boxName);
    await box.put(_goalKey, goal);
  }

  @override
  onboarding.LocalGoalModel? getGoal() {
    if (!_hive.isBoxOpen(_boxName)) return null;
    return _hive.box(_boxName).get(_goalKey);
  }

  @override
  Future<void> clearOnBoardingData() async {
    final box = await _hive.openBox(_boxName);
    await box.delete(_goalKey);
    await box.delete(_trackingKey);
    await box.delete(_weeklySpendingKey);
  }
}
