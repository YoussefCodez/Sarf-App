import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/models/remote_user_profile_model.dart';
import 'package:finance_tracking/config/models/remote_goal_model.dart';
import 'package:finance_tracking/features/auth/domain/entities/auth_user_entity.dart';

abstract interface class AuthRepositoryContract {
  Future<Either<String, AuthUserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required RemoteUserProfileModel userProfileModel,
    RemoteGoalModel? goalModel,
  });

  Future<Either<String, AuthUserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
