import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class BiometricsLocalDataSource {
  Future<void> setBiometricsEnabled(bool isEnabled);
  bool isBiometricsEnabled();
}

@LazySingleton(as: BiometricsLocalDataSource)
class BiometricsLocalDataSourceImpl implements BiometricsLocalDataSource {
  final Box _settingsBox;
  
  BiometricsLocalDataSourceImpl() : _settingsBox = Hive.box('settings_box');

  @override
  Future<void> setBiometricsEnabled(bool isEnabled) async {
    await _settingsBox.put('isBiometricsEnabled', isEnabled);
  }

  @override
  bool isBiometricsEnabled() {
    return _settingsBox.get('isBiometricsEnabled', defaultValue: false);
  }
}
