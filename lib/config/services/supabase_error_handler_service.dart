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
          return AppStrings.emailNotConfirmed;
        default:
          return e.message;
      }
    } else if (e is PostgrestException) {
      // Handling Supabase Database Operations (Insert, Select, Delete, Update)
      switch (e.code) {
        case '23505': // unique_violation
          return AppStrings.recordAlreadyExists;
        case '23503': // foreign_key_violation
          return AppStrings.referencedDataNotFound;
        case '23502': // not_null_violation
          return AppStrings.missingRequiredFields;
        case '42P01': // undefined_table
          return AppStrings.tableNotFound;
        case 'PGRST116': // Single row expected but 0 rows returned
          return AppStrings.noRecordFound;
        case 'PGRST204': // Column not found
          return AppStrings.internalDbError;
        case '42501': // insufficient_privilege / RLS violation
          return AppStrings.permissionDenied;
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
