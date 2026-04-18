import 'package:finance_tracking/features/auth/domain/repositories/auth_repository_contract.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUsecase {
  final AuthRepositoryContract repository;

  LogoutUsecase({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}
