import 'package:finance_tracking/features/security_and_biometrics/domain/repositories/biometrics_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SetBiometricsEnabledUseCase {
  final BiometricsRepositoryContract repository;

  SetBiometricsEnabledUseCase({required this.repository});

  Future<void> call(bool isEnabled) async {
    await repository.setBiometricsEnabled(isEnabled);
  }
}
