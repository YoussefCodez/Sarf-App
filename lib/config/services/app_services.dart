import 'package:flutter/widgets.dart';
import 'hive_service.dart';
import 'di_service.dart';

class AppServices {
  /// Initializes all application services.
  static Future<void> init() async {
    // Ensure Flutter bindings are initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Hive
    await HiveService.init();

    // Configure Dependency Injection
    await configureDependencies();
  }
}
