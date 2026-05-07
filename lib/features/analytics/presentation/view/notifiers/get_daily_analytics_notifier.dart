import 'package:finance_tracking/features/analytics/domain/entities/analytics_period.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/calculate_daily_analytics_use_case.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/get_daily_transactions_use_case.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/get_weekly_transactions_use_case.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/get_monthly_transactions_use_case.dart';
import 'package:finance_tracking/features/analytics/presentation/view/intents/get_daily_analytics_intents.dart';
import 'package:finance_tracking/features/analytics/presentation/view/states/get_daily_analytics_states.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetDailyAnalyticsNotifier extends StateNotifier<GetDailyAnalyticsStates> {
  final GetDailyTransactionsUseCase _getDailyTransactionsUseCase;
  final GetWeeklyTransactionsUseCase _getWeeklyTransactionsUseCase;
  final GetMonthlyTransactionsUseCase _getMonthlyTransactionsUseCase;
  final CalculateDailyAnalyticsUseCase _calculateAnalyticsUseCase;

  GetDailyAnalyticsNotifier(
    this._getDailyTransactionsUseCase,
    this._getWeeklyTransactionsUseCase,
    this._getMonthlyTransactionsUseCase,
    this._calculateAnalyticsUseCase,
  ) : super(GetDailyAnalyticsInitial());

  Future<void> handleIntent(GetDailyAnalyticsIntent intent) async {
    if (intent is GetDailyAnalyticsIntentImpl) {
      state = GetDailyAnalyticsLoading();
      
      final result = await _fetchByPeriod(intent.period);

      result.fold(
        (error) => state = GetDailyAnalyticsFailure(error: error),
        (transactions) {
          final analytics = _calculateAnalyticsUseCase(transactions);
          state = GetDailyAnalyticsSuccess(
            dailyAnalyticsEntity: analytics,
            period: intent.period,
          );
        },
      );
    }
  }

  Future<dynamic> _fetchByPeriod(AnalyticsPeriod period) {
    switch (period) {
      case AnalyticsPeriod.day:
        return _getDailyTransactionsUseCase();
      case AnalyticsPeriod.week:
        return _getWeeklyTransactionsUseCase();
      case AnalyticsPeriod.month:
        return _getMonthlyTransactionsUseCase();
    }
  }
}
