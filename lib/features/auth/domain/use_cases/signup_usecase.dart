import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/auth/domain/entities/user_entity.dart';
import 'package:finance_tracking/features/auth/domain/repositories/auth_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SignupUsecase {
  final AuthRepositoryContract authRepositoryContract;

  SignupUsecase({required this.authRepositoryContract});

  Future<Either<String, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await authRepositoryContract.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}