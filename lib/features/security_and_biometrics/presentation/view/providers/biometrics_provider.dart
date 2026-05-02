import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/security_and_biometrics/domain/usecases/authenticate_usecase.dart';
import 'package:finance_tracking/features/security_and_biometrics/domain/usecases/check_biometrics_support_usecase.dart';
import 'package:finance_tracking/features/security_and_biometrics/domain/usecases/get_biometrics_status_usecase.dart';
import 'package:finance_tracking/features/security_and_biometrics/domain/usecases/set_biometrics_enabled_usecase.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/view/notifiers/biometrics_notifier.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/view/states/biometrics_states.dart';
import 'package:flutter_riverpod/legacy.dart';

final biometricsProvider = StateNotifierProvider<BiometricsNotifier, BiometricsState>((ref) {
  return BiometricsNotifier(
    authenticateUseCase: getIt<AuthenticateUseCase>(),
    checkBiometricsSupportUseCase: getIt<CheckBiometricsSupportUseCase>(),
    getBiometricsStatusUseCase: getIt<GetBiometricsStatusUseCase>(),
    setBiometricsEnabledUseCase: getIt<SetBiometricsEnabledUseCase>(),
  );
});
