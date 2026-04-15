import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/auth/data/data_source/remote_data_source.dart';
import 'package:finance_tracking/features/auth/data/models/user_model.dart';
import 'package:finance_tracking/features/auth/domain/entities/user_entity.dart';
import 'package:finance_tracking/features/auth/domain/repositories/auth_repository_contract.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepositoryContract)
class AuthRepositoryImpl implements AuthRepositoryContract {
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
      return Right(UserModel.fromSupabase(response.user!.toJson()));
    } catch (e) {
      return Left(SupabaseErrorHandlerService.getErrorMessage(e));
    }
  }

  @override
  Future<Either<String, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Right(UserModel.fromSupabase(response.user!.toJson()));
    } catch (e) {
      return Left(SupabaseErrorHandlerService.getErrorMessage(e));
    }
  }
}