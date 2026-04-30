import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/user_profile_entity.dart';

abstract interface class HomeRepositoryContract {
  Future<Either<String, UserProfileEntity>> getProfile();
}
