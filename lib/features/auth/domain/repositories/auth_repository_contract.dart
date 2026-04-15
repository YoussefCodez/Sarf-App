import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepositoryContract {
  Future<Either<String, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<String, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}