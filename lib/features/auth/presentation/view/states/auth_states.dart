import 'package:finance_tracking/features/auth/domain/entities/auth_user_entity.dart';

sealed class AuthStates {}

class AuthInitial extends AuthStates {}

// Sign Up States
class SignUpLoading extends AuthStates {}

class SignUpSuccess extends AuthStates {
  final AuthUserEntity user;
  SignUpSuccess({required this.user});
}

class SignUpError extends AuthStates {
  final String errorMessage;
  SignUpError({required this.errorMessage});
}

// Login States
class LoginLoading extends AuthStates {}

class LoginSuccess extends AuthStates {
  final AuthUserEntity user;
  LoginSuccess({required this.user});
}

class LoginError extends AuthStates {
  final String errorMessage;
  LoginError({required this.errorMessage});
}

// Logout States
class LogoutLoading extends AuthStates {}

class LogoutSuccess extends AuthStates {}

class LogoutError extends AuthStates {
  final String errorMessage;
  LogoutError({required this.errorMessage});
}
