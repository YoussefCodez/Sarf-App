import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/auth/domain/entities/auth_user_entity.dart';
import 'package:finance_tracking/features/auth/domain/repositories/auth_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LoginUsecase {
  final AuthRepositoryContract authRepositoryContract;

  LoginUsecase({required this.authRepositoryContract});

  Future<Either<String, AuthUserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await authRepositoryContract.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
