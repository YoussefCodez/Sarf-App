import 'package:finance_tracking/config/const/app_tables.dart';
import 'package:finance_tracking/config/models/remote_goal_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class RemoteGoalDataSource {
  final SupabaseClient supabaseClient;

  RemoteGoalDataSource({required this.supabaseClient});

  Future<RemoteGoalModel?> getGoal() async {
    final response = await supabaseClient
        .from(AppTables.goal)
        .select()
        .eq('user_id', supabaseClient.auth.currentUser!.id)
        .maybeSingle();

    if (response == null) return null;
    return RemoteGoalModel.fromSupabase(response);
  }
}
