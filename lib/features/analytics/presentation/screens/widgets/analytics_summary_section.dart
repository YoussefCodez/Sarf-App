import 'package:finance_tracking/config/utils/format_price.dart';
import 'package:finance_tracking/core/app_strings/analytics_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/analytics/domain/entities/daily_analytics_entity.dart';
import 'package:finance_tracking/features/analytics/presentation/screens/widgets/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AnalyticsSummarySection extends StatelessWidget {
  final DailyAnalyticsEntity dailyAnalyticsEntity;

  const AnalyticsSummarySection({super.key, required this.dailyAnalyticsEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: AnalyticsStrings.summaryIncome,
                value: formatPrice(dailyAnalyticsEntity.totalIncome),
                icon: Icons.trending_up,
                color: AppColors.greenIconBackgroundColor,
              ),
            ),
            Gap(12.w),
            Expanded(
              child: SummaryCard(
                title: AnalyticsStrings.summaryTotal,
                value: formatPrice(dailyAnalyticsEntity.totalExpenses),
                icon: Icons.account_balance_wallet_outlined,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        Gap(12.h),
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: AnalyticsStrings.summaryHighest,
                value: formatPrice(dailyAnalyticsEntity.highestSingleExpense),
                icon: Icons.stars_rounded,
                color: AppColors.secondaryColor,
              ),
            ),
            Gap(12.w),
            Expanded(
              child: SummaryCard(
                title: AnalyticsStrings.summaryAverage,
                value: formatPrice(dailyAnalyticsEntity.averageExpense),
                icon: Icons.analytics_outlined,
                color: AppColors.tertiaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
