import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class RemoteDataSource {
  final SupabaseClient supabaseClient;

  RemoteDataSource({required this.supabaseClient});
}