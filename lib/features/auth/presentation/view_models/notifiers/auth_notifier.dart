import 'package:finance_tracking/features/auth/domain/use_cases/login_usecase.dart';
import 'package:finance_tracking/features/auth/domain/use_cases/signup_usecase.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/intents/auth_intent.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/states/auth_states.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthStates> {
  final SignupUsecase signUpUseCase;
  final LoginUsecase loginUseCase;

  AuthNotifier({
    required this.signUpUseCase,
    required this.loginUseCase,
  }) : super(AuthInitial());

  Future<void> handleIntent(AuthIntent intent) async {
    switch (intent) {
      case SignUpIntent():
        await _signUp(intent.email, intent.password);
        break;
      case LoginIntent():
        await _login(intent.email, intent.password);
        break;
    }
  }

  Future<void> _signUp(String email, String password) async {
    state = SignUpLoading();
    try {
      final result = await signUpUseCase(email: email, password: password);
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