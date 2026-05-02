import 'package:finance_tracking/config/const/app_tables.dart';
import 'package:finance_tracking/features/transaction/data/models/transaction_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class TransactionRemoteDataSource {
  final SupabaseClient supabaseClient;

  TransactionRemoteDataSource({required this.supabaseClient});

  String getUserId() {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    return user.id;
  }

  Future<void> insertTransaction({required TransactionModel data}) async {
    await supabaseClient.from(AppTables.transactions).insert(data.toSupabase());
  }

  Future<void> updateRemoteProfileBalance({
    required String userId,
    required double amount,
    required String type,
  }) async {
    final profileResponse = await supabaseClient
        .from(AppTables.profiles)
        .select('current_money')
        .eq('id', userId)
        .single();

    final double oldBalance =
        double.tryParse(profileResponse['current_money'].toString()) ?? 0.0;

    final double newBalance = type.toLowerCase() == 'income'
        ? oldBalance + amount
        : oldBalance - amount;

    await supabaseClient
        .from(AppTables.profiles)
        .update({'current_money': newBalance.toString()})
        .eq('id', userId);
  }

  Future<List<TransactionModel>> getTransactions({int? limit}) async {
    final userId = getUserId();
    final response = limit != null
        ? await supabaseClient
              .from(AppTables.transactions)
              .select()
              .eq('user_id', userId)
              .order('created_at', ascending: false)
              .limit(limit)
        : await supabaseClient
              .from(AppTables.transactions)
              .select()
              .eq('user_id', userId)
              .order('created_at', ascending: false);
    return response.map((e) => TransactionModel.fromSupabase(e)).toList();
  }
}
