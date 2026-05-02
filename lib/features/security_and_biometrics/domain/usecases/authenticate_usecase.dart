import 'package:finance_tracking/features/security_and_biometrics/domain/repositories/biometrics_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthenticateUseCase {
  final BiometricsRepositoryContract repository;

  AuthenticateUseCase({required this.repository});

  Future<bool> call(String localizedReason) async {
    return await repository.authenticate(localizedReason);
  }
}
