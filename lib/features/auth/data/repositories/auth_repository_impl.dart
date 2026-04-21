import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/const/app_tables.dart';
import 'package:finance_tracking/config/models/remote_user_profile_model.dart';
import 'package:finance_tracking/config/utils/out_put_print_util.dart';
import 'package:finance_tracking/features/auth/data/models/local_user_profile_model.dart';
import 'package:finance_tracking/config/models/remote_goal_model.dart';
import 'package:finance_tracking/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:finance_tracking/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:finance_tracking/features/auth/data/models/auth_user_model.dart';
import 'package:finance_tracking/features/auth/domain/entities/auth_user_entity.dart';
import 'package:finance_tracking/features/auth/domain/repositories/auth_repository_contract.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepositoryContract)
class AuthRepositoryImpl implements AuthRepositoryContract {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<String, AuthUserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required RemoteUserProfileModel userProfileModel,
    RemoteGoalModel? goalModel,
  }) async {
    try {
      final response = await remoteDataSource.supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      try {
        if (response.user == null) {
          return const Left("Signup failed: User is Not Found");
        }

        final updatedProfile = userProfileModel.copyWith(id: response.user!.id);

        await remoteDataSource.supabaseClient
            .from(AppTables.profiles)
            .insert(updatedProfile.toSupabase());

        await localDataSource.saveUserProfile(
          LocalUserProfileModel.fromEntity(updatedProfile),
        );

        if (goalModel != null) {
          final updatedGoal = goalModel.copyWith(userId: response.user!.id);
          await remoteDataSource.supabaseClient
              .from(AppTables.goal)
              .insert(updatedGoal.toSupabase());
        }
      } catch (dpError) {
        OutPutPrintUtil.printOutPut(dpError);
        return Left(SupabaseErrorHandlerService.getErrorMessage(dpError));
      }

      return Right(AuthUserModel.fromSupabase(response.user!.toJson()));
    } catch (e) {
      OutPutPrintUtil.printOutPut(e);
      return Left(SupabaseErrorHandlerService.getErrorMessage(e));
    }
  }

  @override
  Future<Either<String, AuthUserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.supabaseClient.auth
          .signInWithPassword(email: email, password: password);

      if (response.user == null) {
        return const Left("Signin failed: User is Not Found");
      }

      final profileData = await remoteDataSource.supabaseClient
          .from(AppTables.profiles)
          .select()
          .eq("id", response.user!.id)
          .single();

      final remoteProfile = RemoteUserProfileModel.fromSupabase(profileData);

      await localDataSource.saveUserProfile(
        LocalUserProfileModel.fromEntity(remoteProfile),
      );

      return Right(AuthUserModel.fromSupabase(response.user!.toJson()));
    } catch (e) {
      return Left(SupabaseErrorHandlerService.getErrorMessage(e));
    }
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.supabaseClient.auth.signOut();
    await localDataSource.clearUserProfile();
  }
}
