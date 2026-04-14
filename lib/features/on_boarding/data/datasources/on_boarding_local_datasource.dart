import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

abstract interface class OnBoardingLocalDataSource {
  Future<void> saveTrackingReason(bool value);
  Future<void> saveWeeklySpending(double value);
  Future<void> saveEndOnBoarding(bool value);
  bool getEndOnBoarding();
}

@LazySingleton(as: OnBoardingLocalDataSource)
class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {
  final HiveInterface _hive;
  static const String _boxName = 'settings_box';
  static const String _trackingKey = 'TrackingForReason';
  static const String _weeklySpendingKey = 'weeklySpending';
  static const String _endOnBoardingKey = 'endOnBoarding';

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
}
