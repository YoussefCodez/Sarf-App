import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/calculate_daily_analytics_use_case.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/get_daily_transactions_use_case.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/get_weekly_transactions_use_case.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/get_monthly_transactions_use_case.dart';
import 'package:finance_tracking/features/analytics/presentation/view/intents/get_daily_analytics_intents.dart';
import 'package:finance_tracking/features/analytics/presentation/view/notifiers/get_daily_analytics_notifier.dart';
import 'package:finance_tracking/features/analytics/presentation/view/states/get_daily_analytics_states.dart';
import 'package:flutter_riverpod/legacy.dart';

final getDailyAnalyticsProvider = StateNotifierProvider<GetDailyAnalyticsNotifier, GetDailyAnalyticsStates>((ref) {
  final notifier = GetDailyAnalyticsNotifier(
    getIt<GetDailyTransactionsUseCase>(),
    getIt<GetWeeklyTransactionsUseCase>(),
    getIt<GetMonthlyTransactionsUseCase>(),
    getIt<CalculateDailyAnalyticsUseCase>(),
  );
  Future.microtask(() => notifier.handleIntent(GetDailyAnalyticsIntentImpl()));
  return notifier;
});