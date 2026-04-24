import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/get_goal/domain/use_cases/get_goal_use_case.dart';
import 'package:finance_tracking/features/get_goal/presentation/view/states/get_goal_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetGoalNotifier extends Notifier<GetGoalStates> {
  GetGoalUseCase get _getGoalUseCase => getIt<GetGoalUseCase>();

  @override
  GetGoalStates build() {
    return GetGoalInitial();
  }

  Future<void> getGoal() async {
    state = GetGoalLoading();
    final result = await _getGoalUseCase.call();
    result.fold(
      (error) => state = GetGoalError(error: error),
      (goal) => state = GetGoalSuccess(goalEntity: goal),
    );
  }
}
