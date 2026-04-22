import 'package:finance_tracking/config/models/remote_user_profile_model.dart';
import 'package:finance_tracking/config/models/remote_goal_model.dart';
import 'package:finance_tracking/features/auth/domain/use_cases/login_usecase.dart';
import 'package:finance_tracking/features/auth/domain/use_cases/signup_usecase.dart';
import 'package:finance_tracking/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:finance_tracking/features/auth/presentation/view/intents/auth_intent.dart';
import 'package:finance_tracking/features/auth/presentation/view/states/auth_states.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthStates> {
  final SignupUsecase signUpUseCase;
  final LoginUsecase loginUseCase;
  final LogoutUsecase logoutUseCase;

  AuthNotifier({
    required this.signUpUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  Future<void> handleIntent(AuthIntent intent) async {
    switch (intent) {
      case SignUpIntent():
        await _signUp(
          intent.email,
          intent.password,
          intent.userProfileModel,
          intent.goalModel,
        );
        break;
      case LoginIntent():
        await _login(intent.email, intent.password);
        break;
      case LogoutIntent():
        await _logout();
        break;
    }
  }

  Future<void> _logout() async {
    try {
      await logoutUseCase();
      state = AuthInitial();
    } catch (e) {
      state = LoginError(errorMessage: e.toString());
    }
  }

  Future<void> _signUp(
    String email,
    String password,
    RemoteUserProfileModel userProfileModel,
    RemoteGoalModel? goalModel,
  ) async {
    state = SignUpLoading();
    try {
      final result = await signUpUseCase(
        email: email,
        password: password,
        userProfileModel: userProfileModel,
        goalModel: goalModel,
      );
      result.fold(
        (failure) => state = SignUpError(errorMessage: failure),
        (user) => state = SignUpSuccess(user: user),
      );
    } catch (e) {
      state = SignUpError(errorMessage: e.toString());
    }
  }

  Future<void> _login(String email, String password) async {
    state = LoginLoading();
    try {
      final result = await loginUseCase(email: email, password: password);
      result.fold(
        (failure) => state = LoginError(errorMessage: failure),
        (user) => state = LoginSuccess(user: user),
      );
    } catch (e) {
      state = LoginError(errorMessage: e.toString());
    }
  }
}
