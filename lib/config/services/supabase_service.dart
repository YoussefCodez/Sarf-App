import 'package:finance_tracking/config/const/app_const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseService {
  static Future<void> init() async {
    await Supabase.initialize(
      url: AppConst.supabaseUrl,
      anonKey: AppConst.supabaseAnonKey,
    );
  }
}