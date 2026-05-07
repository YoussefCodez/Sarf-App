import 'package:finance_tracking/features/analytics/domain/entities/analytics_period.dart';

sealed class GetDailyAnalyticsIntent {}

class GetDailyAnalyticsIntentImpl implements GetDailyAnalyticsIntent {
  final AnalyticsPeriod period;
  GetDailyAnalyticsIntentImpl({this.period = AnalyticsPeriod.day});
}
