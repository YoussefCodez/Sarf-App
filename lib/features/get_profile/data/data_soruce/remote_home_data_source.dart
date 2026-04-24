import 'package:finance_tracking/config/const/app_tables.dart';
import 'package:finance_tracking/config/models/remote_user_profile_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class RemoteHomeDataSource {
  final SupabaseClient supabaseClient;

  RemoteHomeDataSource({required this.supabaseClient});

  Future<RemoteUserProfileModel> getProfile() async {
    final response = await supabaseClient
        .from(AppTables.profiles)
        .select()
        .eq('id', supabaseClient.auth.currentUser!.id)
        .single();
    return RemoteUserProfileModel.fromSupabase(response);
  }
}
