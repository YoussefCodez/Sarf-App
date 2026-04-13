import 'package:finance_tracking/features/on_boarding/data/models/goal_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveService {
  /// Initializes Hive and opens necessary boxes.
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(GoalModelAdapter());
    
    // You can add logic to open static boxes here if needed
    // await Hive.openBox('settings');
  }
}
