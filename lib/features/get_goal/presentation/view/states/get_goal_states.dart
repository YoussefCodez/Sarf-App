import 'package:finance_tracking/config/entities/remote_goal_entity.dart';

sealed class GetGoalStates {}

class GetGoalInitial extends GetGoalStates {}

class GetGoalLoading extends GetGoalStates {}

class GetGoalSuccess extends GetGoalStates {
  final RemoteGoalEntity goalEntity;
  GetGoalSuccess({required this.goalEntity});
}

class GetGoalError extends GetGoalStates {
  final String error;
  GetGoalError({required this.error});
}
