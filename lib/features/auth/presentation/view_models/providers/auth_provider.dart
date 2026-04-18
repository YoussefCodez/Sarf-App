import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/auth/domain/use_cases/login_usecase.dart';
import 'package:finance_tracking/features/auth/domain/use_cases/signup_usecase.dart';
import 'package:finance_tracking/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/notifiers/auth_notifier.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/states/auth_states.dart';
import 'package:flutter_riverpod/legacy.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthStates>(
  (ref) => AuthNotifier(
    signUpUseCase: getIt<SignupUsecase>(),
    loginUseCase: getIt<LoginUsecase>(),
    logoutUseCase: getIt<LogoutUsecase>(),
  ),
);