import 'package:finance_tracking/core/app_strings/biometrics_strings.dart';
import 'package:finance_tracking/features/security_and_biometrics/domain/usecases/authenticate_usecase.dart';
import 'package:finance_tracking/features/security_and_biometrics/domain/usecases/check_biometrics_support_usecase.dart';
import 'package:finance_tracking/features/security_and_biometrics/domain/usecases/get_biometrics_status_usecase.dart';
import 'package:finance_tracking/features/security_and_biometrics/domain/usecases/set_biometrics_enabled_usecase.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/view/intents/biometrics_intents.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/view/states/biometrics_states.dart';
import 'package:flutter_riverpod/legacy.dart';

class BiometricsNotifier extends StateNotifier<BiometricsState> {
  final AuthenticateUseCase authenticateUseCase;
  final CheckBiometricsSupportUseCase checkBiometricsSupportUseCase;
  final GetBiometricsStatusUseCase getBiometricsStatusUseCase;
  final SetBiometricsEnabledUseCase setBiometricsEnabledUseCase;

  BiometricsNotifier({
    required this.authenticateUseCase,
    required this.checkBiometricsSupportUseCase,
    required this.getBiometricsStatusUseCase,
    required this.setBiometricsEnabledUseCase,
  }) : super(BiometricsInitial());

  Future<void> handleIntent(BiometricsIntent intent) async {
    if (intent is GetBiometricsStatusIntent) {
      final isEnabled = getBiometricsStatusUseCase();
      state = BiometricsStatusLoaded(isEnabled);
    } else if (intent is ToggleBiometricsIntent) {
      state = BiometricsLoading();
      
      final isSupported = await checkBiometricsSupportUseCase();
      if (!isSupported) {
        state = BiometricsError(BiometricsStrings.deviceNotSupported);
        final isEnabled = getBiometricsStatusUseCase();
        state = BiometricsStatusLoaded(isEnabled);
        return;
      }

      final authSuccess = await authenticateUseCase(intent.localizedReason);
      if (authSuccess) {
        await setBiometricsEnabledUseCase(intent.enable);
        state = BiometricsAuthSuccess(intent.enable);
        state = BiometricsStatusLoaded(intent.enable);
      } else {
        state = BiometricsAuthFailed();
        final isEnabled = getBiometricsStatusUseCase();
        state = BiometricsStatusLoaded(isEnabled);
      }
    } else if (intent is AuthenticateToAccessAppIntent) {
      final isEnabled = getBiometricsStatusUseCase();
      if (!isEnabled) {
        state = BiometricsAuthSuccess(false);
        return;
      }

      state = BiometricsLoading();
      final isSupported = await checkBiometricsSupportUseCase();
      if (!isSupported) {
        state = BiometricsAuthSuccess(true);
        return;
      }

      final authSuccess = await authenticateUseCase(intent.localizedReason);
      if (authSuccess) {
        state = BiometricsAuthSuccess(true);
      } else {
        state = BiometricsAuthFailed();
      }
    }
  }
}
