import 'package:finance_tracking/features/daily_advice/domain/entities/user_finance_entity.dart';
import 'package:finance_tracking/features/daily_advice/domain/rules/goal_based_prediction_rule.dart';
import 'package:finance_tracking/features/daily_advice/domain/rules/save_percentage_rule.dart';
import 'package:finance_tracking/features/daily_advice/domain/rules/spending_optimization_rule.dart';
import 'package:finance_tracking/features/daily_advice/domain/usecases/get_daily_advice_usecase.dart';
import 'package:finance_tracking/features/get_goal/presentation/view/providers/get_goal_provider.dart';
import 'package:finance_tracking/features/get_goal/presentation/view/states/get_goal_states.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/providers/get_profile_provider.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/states/get_profile_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the Advice Engine with all available rules.
/// Open-Closed Principle: To add a new rule, just add it to this list.
final adviceEngineProvider = Provider<GetDailyAdviceUseCase>((ref) {
  return GetDailyAdviceUseCase([
    SavePercentageRule(),
    GoalBasedPredictionRule(),
    SpendingOptimizationRule(),
    // Add additional rules here
  ]);
});

/// Computes the daily advice string based on current user parameters
final dailyAdviceProvider = Provider<String>((ref) {
  final engine = ref.read(adviceEngineProvider);
  
  final profileState = ref.watch(getProfileProvider);
  final goalState = ref.watch(getGoalProvider);
  
  final profile = profileState is GetProfileSuccess ? profileState.userProfileEntity : null;
  final goal = goalState is GetGoalSuccess ? goalState.goalEntity : null;
  
  final financeData = UserFinanceEntity(
    userId: profile?.id ?? "",
    goalAmount: goal?.price ?? 0.0,
    weeklySpend: double.tryParse(profile?.weeklySpending ?? "0") ?? 0.0,
    haveGoal: goal != null,
  );

  return engine.execute(financeData);
});
