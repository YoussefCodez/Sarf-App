import 'package:finance_tracking/features/analytics/domain/entities/daily_analytics_entity.dart';
import 'package:finance_tracking/features/analytics/domain/entities/analytics_period.dart';

sealed class GetDailyAnalyticsStates {}

class GetDailyAnalyticsInitial extends GetDailyAnalyticsStates {}

class GetDailyAnalyticsLoading extends GetDailyAnalyticsStates {}

class GetDailyAnalyticsSuccess extends GetDailyAnalyticsStates {
  final DailyAnalyticsEntity dailyAnalyticsEntity;
  final AnalyticsPeriod period;

  GetDailyAnalyticsSuccess({
    required this.dailyAnalyticsEntity,
    this.period = AnalyticsPeriod.day,
  });
}

class GetDailyAnalyticsFailure extends GetDailyAnalyticsStates {
  final String error;

  GetDailyAnalyticsFailure({required this.error});
}