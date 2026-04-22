import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSource({required this.supabaseClient});

  Future<AuthResponse> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return supabaseClient.auth.signUp(email: email, password: password, data: {
      'display_name': name,
    });
  }

  Future<void> insertData({
    required String table,
    required Map<String, dynamic> data,
  }) {
    return supabaseClient.from(table).insert(data);
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<Map<String, dynamic>> selectSingle({
    required String table,
    required String column,
    required dynamic value,
  }) {
    return supabaseClient.from(table).select().eq(column, value).single();
  }

  Future<String> uploadImage({
    required String bucket,
    required String path,
    required File file,
  }) async {
    await supabaseClient.storage.from(bucket).upload(path, file);
    return supabaseClient.storage.from(bucket).getPublicUrl(path);
  }
}
