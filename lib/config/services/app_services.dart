import 'package:finance_tracking/config/services/supabase_service.dart';
import 'package:flutter/widgets.dart';
import 'package:finance_tracking/config/services/notifications_service.dart';
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

    // Configure Supabase
    await SupabaseService.init();

    // Initialize Notifications
    await getIt<NotificationService>().init();
  }
}
