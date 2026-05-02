import 'package:finance_tracking/features/security_and_biometrics/domain/repositories/biometrics_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetBiometricsStatusUseCase {
  final BiometricsRepositoryContract repository;

  GetBiometricsStatusUseCase({required this.repository});

  bool call() {
    return repository.isBiometricsEnabled();
  }
}
