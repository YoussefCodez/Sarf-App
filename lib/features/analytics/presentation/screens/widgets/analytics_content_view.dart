import 'package:finance_tracking/features/analytics/domain/entities/daily_analytics_entity.dart';
import 'package:finance_tracking/features/analytics/presentation/screens/widgets/analytics_chart_card.dart';
import 'package:finance_tracking/features/analytics/presentation/screens/widgets/analytics_summary_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AnalyticsContentView extends StatelessWidget {
  final DailyAnalyticsEntity dailyAnalyticsEntity;

  const AnalyticsContentView({super.key, required this.dailyAnalyticsEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnalyticsChartCard(dailyAnalyticsEntity: dailyAnalyticsEntity),
        Gap(16.h),
        AnalyticsSummarySection(dailyAnalyticsEntity: dailyAnalyticsEntity),
      ],
    );
  }
}
