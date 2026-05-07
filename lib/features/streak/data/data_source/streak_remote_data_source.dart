import 'package:finance_tracking/config/const/app_tables.dart';
import 'package:finance_tracking/features/streak/domain/entities/streak_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class StreakRemoteDataSource {
  final SupabaseClient supabaseClient;

  StreakRemoteDataSource({required this.supabaseClient});

  String getUserId() {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    return user.id;
  }

  Future<DateTime> getServerTimestamp() async {
    final response = await supabaseClient.rpc('get_server_timestamp');
    return DateTime.parse(response.toString()).toUtc();
  }

  Future<StreakEntity> getStreak() async {
    final userId = getUserId();
    final response = await supabaseClient
        .from(AppTables.profiles)
        .select('current_streak, longest_streak, last_check_in_date')
        .eq('id', userId)
        .single();

    return StreakEntity(
      userId: userId,
      currentStreak: int.tryParse(response['current_streak']?.toString() ?? '0') ?? 0,
      longestStreak: int.tryParse(response['longest_streak']?.toString() ?? '0') ?? 0,
      lastCheckInDate: response['last_check_in_date'] != null
          ? DateTime.tryParse(response['last_check_in_date'].toString())?.toUtc() ?? DateTime.now().toUtc()
          : DateTime.now().toUtc(),
    );
  }

  Future<void> updateStreak({
    required int currentStreak,
    required int longestStreak,
    required DateTime lastCheckInDate,
  }) async {
    final userId = getUserId();
    await supabaseClient
        .from(AppTables.profiles)
        .update({
          'current_streak': currentStreak,
          'longest_streak': longestStreak,
          'last_check_in_date': lastCheckInDate.toUtc().toIso8601String(),
        })
        .eq('id', userId);
  }
}
