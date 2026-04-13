import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

abstract interface class OnBoardingLocalDataSource {
  Future<void> saveTrackingReason(bool value);
  Future<void> saveWeeklySpending(double value);
}

@LazySingleton(as: OnBoardingLocalDataSource)
class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {
  final HiveInterface _hive;
  static const String _boxName = 'settings_box';
  static const String _trackingKey = 'TrackingForReason';
  static const String _weeklySpendingKey = 'weeklySpending';

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
}
