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

  Future<List<TransactionModel>> getTransactions({int? limit}) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      return [];
    }
    final response = limit != null
        ? await supabaseClient
              .from(AppTables.transactions)
              .select()
              .eq('user_id', user.id)
              .order('created_at', ascending: false)
              .limit(limit)
        : await supabaseClient
              .from(AppTables.transactions)
              .select()
              .eq('user_id', user.id)
              .order('created_at', ascending: false);
    return response.map((e) => TransactionModel.fromSupabase(e)).toList();
  }
}
