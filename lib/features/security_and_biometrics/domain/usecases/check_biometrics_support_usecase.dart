import 'package:finance_tracking/features/security_and_biometrics/domain/repositories/biometrics_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CheckBiometricsSupportUseCase {
  final BiometricsRepositoryContract repository;

  CheckBiometricsSupportUseCase({required this.repository});

  Future<bool> call() async {
    return await repository.isDeviceSupported();
  }
}
