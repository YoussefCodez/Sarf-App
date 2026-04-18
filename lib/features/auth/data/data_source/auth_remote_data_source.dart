import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSource({required this.supabaseClient});
}
