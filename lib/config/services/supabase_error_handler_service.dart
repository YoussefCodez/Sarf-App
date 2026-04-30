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
    } else if (e is PostgrestException) {
      // Handling Supabase Database Operations (Insert, Select, Delete, Update)
      switch (e.code) {
        case '23505': // unique_violation
          return "This record already exists in the database.";
        case '23503': // foreign_key_violation
          return "Referenced data not found. Please try again.";
        case '23502': // not_null_violation
          return "Please fill in all required fields.";
        case '42P01': // undefined_table
          return "Database table not found. Please contact support.";
        case 'PGRST116': // Single row expected but 0 rows returned
          return "No record found matching the criteria.";
        case 'PGRST204': // Column not found
          return "Internal database error. Please contact support.";
        case '42501': // insufficient_privilege / RLS violation
          return "You do not have permission to perform this action.";
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
