import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/user_profile_entity.dart';
import 'package:finance_tracking/features/get_profile/domain/repositories/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetProfileUseCase {
  final HomeRepositoryContract homeRepositoryContract;
  GetProfileUseCase({required this.homeRepositoryContract});
  Future<Either<String, UserProfileEntity>> call() async {
    return await homeRepositoryContract.getProfile();
  }
}
