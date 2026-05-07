import 'package:finance_tracking/config/const/app_tables.dart';
import 'package:finance_tracking/config/models/transaction_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteAnalyticsDataSource {
  Future<List<TransactionModel>> getDailyTransactions(
    DateTime start,
    DateTime end,
  );
}

@LazySingleton(as: RemoteAnalyticsDataSource)
class RemoteAnalyticsDataSourceImpl implements RemoteAnalyticsDataSource {
  final SupabaseClient supabaseClient;
  
  String getUserId() {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    return user.id;
  }

  RemoteAnalyticsDataSourceImpl({required this.supabaseClient});
  @override
  Future<List<TransactionModel>> getDailyTransactions(
    DateTime start,
    DateTime end,
  ) async {
    final userId = getUserId();
    final response = await supabaseClient
        .from(AppTables.transactions)
        .select()
        .eq('user_id', userId)
        .gte('created_at', start.toIso8601String())
        .lte('created_at', end.toIso8601String());
    return response.map((e) => TransactionModel.fromSupabase(e)).toList();
  }
}
