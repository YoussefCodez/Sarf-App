import 'package:finance_tracking/config/models/remote_user_profile_model.dart';
import 'package:finance_tracking/config/models/remote_goal_model.dart';

sealed class AuthIntent {}

class SignUpIntent extends AuthIntent {
  final String email;
  final String password;
  final RemoteUserProfileModel userProfileModel;
  final RemoteGoalModel? goalModel;

  SignUpIntent({
    required this.email,
    required this.password,
    required this.userProfileModel,
    this.goalModel,
  });
}

class LoginIntent extends AuthIntent {
  final String email;
  final String password;

  LoginIntent({required this.email, required this.password});
}

class LogoutIntent extends AuthIntent {}
