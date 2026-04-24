import 'package:finance_tracking/config/entities/user_profile_entity.dart';

sealed class GetProfileStates {}

class GetProfileInitial extends GetProfileStates {}

class GetProfileLoading extends GetProfileStates {}

class GetProfileSuccess extends GetProfileStates {
  final UserProfileEntity userProfileEntity;
  GetProfileSuccess({required this.userProfileEntity});
}

class GetProfileError extends GetProfileStates {
  final String error;
  GetProfileError({required this.error});
}
