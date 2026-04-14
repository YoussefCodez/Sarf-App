import 'package:finance_tracking/features/on_boarding/data/models/goal_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveService {
  /// Initializes Hive and opens necessary boxes.
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(GoalModelAdapter());
    
    // Open static boxes
    await Hive.openBox('settings_box');
  }
}
