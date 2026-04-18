import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/models/remote_user_profile_model.dart';
import 'package:finance_tracking/config/models/remote_goal_model.dart';
import 'package:finance_tracking/features/auth/domain/entities/auth_user_entity.dart';
import 'package:finance_tracking/features/auth/domain/repositories/auth_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SignupUsecase {
  final AuthRepositoryContract authRepositoryContract;

  SignupUsecase({required this.authRepositoryContract});

  Future<Either<String, AuthUserEntity>> call({
    required String email,
    required String password,
    required RemoteUserProfileModel userProfileModel,
    RemoteGoalModel? goalModel,
  }) async {
    return await authRepositoryContract.signUpWithEmailAndPassword(
      email: email,
      password: password,
      userProfileModel: userProfileModel,
      goalModel: goalModel,
    );
  }
}
