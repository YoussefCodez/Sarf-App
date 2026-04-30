import 'dart:io';
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
  final SupabaseErrorHandlerService supabaseErrorHandlerService;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.supabaseErrorHandlerService,
  });

  @override
  Future<Either<String, AuthUserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required RemoteUserProfileModel userProfileModel,
    RemoteGoalModel? goalModel,
  }) async {
    try {
      final response = await remoteDataSource.signUp(
        name: userProfileModel.name,
        email: email,
        password: password,
      );

      try {
        if (response.user == null) {
          return const Left("Signup failed: User is Not Found");
        }

        final updatedProfile = userProfileModel.copyWith(id: response.user!.id);

        await remoteDataSource.insertData(
          table: AppTables.profiles,
          data: updatedProfile.toSupabase(),
        );

        await localDataSource.saveUserProfile(
          LocalUserProfileModel.fromEntity(updatedProfile),
        );

        if (goalModel != null) {
          String? imageUrl = goalModel.image;

          if (imageUrl != null &&
              imageUrl.isNotEmpty &&
              !imageUrl.startsWith('http')) {
            try {
              final fileName =
                  'goal_${response.user!.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
              imageUrl = await remoteDataSource.uploadImage(
                bucket: 'goal_images',
                path: fileName,
                file: File(imageUrl),
              );
            } catch (e) {
              printOutPut(e.toString());
            }
          }

          final updatedGoal = goalModel.copyWith(
            userId: response.user!.id,
            image: imageUrl,
          );

          await remoteDataSource.insertData(
            table: AppTables.goal,
            data: updatedGoal.toSupabase(),
          );
        }
      } catch (dpError) {
        printOutPut(dpError);
        return Left(supabaseErrorHandlerService.handle(dpError));
      }

      return Right(AuthUserModel.fromSupabase(response.user!.toJson()));
    } catch (e) {
      printOutPut(e);
      return Left(supabaseErrorHandlerService.handle(e));
    }
  }

  //--------------------------------------------------------------------------

  @override
  Future<Either<String, AuthUserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.signIn(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return const Left("Signin failed: User is Not Found");
      }

      final profileData = await remoteDataSource.selectSingle(
        table: AppTables.profiles,
        column: "id",
        value: response.user!.id,
      );

      final remoteProfile = RemoteUserProfileModel.fromSupabase(profileData);

      await localDataSource.saveUserProfile(
        LocalUserProfileModel.fromEntity(remoteProfile),
      );

      return Right(AuthUserModel.fromSupabase(response.user!.toJson()));
    } catch (e) {
      printOutPut(e);
      return Left(supabaseErrorHandlerService.handle(e));
    }
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.supabaseClient.auth.signOut();
    await localDataSource.clearUserProfile();
  }
}
