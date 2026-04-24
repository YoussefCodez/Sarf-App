import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../const/app_strings.dart';

@LazySingleton()
class SupabaseErrorHandlerService {
  String handle(Object e) {
    if (e is AuthException) {
      switch (e.code) {
        case 'user_already_exists':
          return AppStrings.emailAlreadyInUse;
        case 'weak_password':
          return AppStrings.weakPassword;
        case 'invalid_credentials':
          return AppStrings.wrongPassword;
        case 'email_not_confirmed':
          return "Please confirm your email first.";
        default:
          return e.message;
      }
    } else if (e is SocketException) {
      return AppStrings.netWorkError;
    } else {
      return AppStrings.unexpectedError;
    }
  }
}
