import 'package:finance_tracking/features/auth/domain/entities/user_entity.dart';

sealed class AuthStates {}

class AuthInitial extends AuthStates {}

// Sign Up States
class SignUpLoading extends AuthStates {}

class SignUpSuccess extends AuthStates {
  final UserEntity user;
  SignUpSuccess({required this.user});
}

class SignUpError extends AuthStates {
  final String errorMessage;
  SignUpError({required this.errorMessage});
}

// Login States
class LoginLoading extends AuthStates {}

class LoginSuccess extends AuthStates {
  final UserEntity user;
  LoginSuccess({required this.user});
}

class LoginError extends AuthStates {
  final String errorMessage;
  LoginError({required this.errorMessage});
}