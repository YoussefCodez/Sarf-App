
import 'package:finance_tracking/features/get_goal/presentation/view/providers/get_goal_provider.dart';
import 'package:finance_tracking/features/get_goal/presentation/view/states/get_goal_states.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/providers/get_profile_provider.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/states/get_profile_states.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/get_transaction_states.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/goal_tracker_states.dart';

class GoalTrackerNotifier extends Notifier<GoalTrackerState> {
  @override
  GoalTrackerState build() {
    final goalState = ref.watch(getGoalProvider);
    final profileState = ref.watch(getProfileProvider);
    final transactionsState = ref.watch(getTransactionProvider);

    if (goalState is GetGoalLoading || profileState is GetProfileLoading) {
      return const GoalTrackerLoading();
    }

    if (goalState is GetGoalError) {
      return GoalTrackerError(goalState.error);
    }
    if (profileState is GetProfileError) {
      return GoalTrackerError(profileState.error);
    }

    if (goalState is GetGoalSuccess && profileState is GetProfileSuccess) {
      final profile = profileState.userProfileEntity;
      final currentMoney = double.tryParse(profile.currentMoney) ?? 0.0;

      final goal = goalState.goalEntity;
      final goalPrice = goal.price;
      final goalName = goal.name;

      final percentage = goalPrice > 0 ? (currentMoney / goalPrice) * 100 : 0.0;

      final transactions = transactionsState is GetTransactionSuccess
          ? transactionsState.transactions
          : [];

      double growthPercent = 0.0;
      if (transactions.isNotEmpty) {
        final lastTx = transactions.first;

        final bool isIncome = lastTx.type.toLowerCase() == 'income';
        final lastTxEffect = isIncome ? lastTx.price : -lastTx.price;

        final previousMoney = currentMoney - lastTxEffect;

        if (previousMoney != 0) {
          growthPercent = (lastTxEffect / previousMoney) * 100;
        } else {
          growthPercent = currentMoney > 0 ? 100.0 : 0.0;
        }
      }

      return GoalTrackerSuccess(
        percentage: percentage,
        growthPercent: growthPercent,
        goalName: goalName,
        goalPrice: goalPrice,
        currentMoney: currentMoney,
      );
    }

    return const GoalTrackerInitial();
  }
}
