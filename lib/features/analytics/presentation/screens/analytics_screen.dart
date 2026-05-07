import 'package:finance_tracking/core/app_strings/analytics_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/analytics/presentation/screens/widgets/analytics_content_view.dart';
import 'package:finance_tracking/features/analytics/presentation/screens/widgets/analytics_empty_view.dart';
import 'package:finance_tracking/features/analytics/presentation/screens/widgets/analytics_error_view.dart';
import 'package:finance_tracking/features/analytics/presentation/screens/widgets/analytics_header.dart';
import 'package:finance_tracking/features/analytics/presentation/screens/widgets/analytics_loading_view.dart';
import 'package:finance_tracking/features/analytics/presentation/view/intents/get_daily_analytics_intents.dart';
import 'package:finance_tracking/features/analytics/presentation/view/providers/get_daily_analytics_provider.dart';
import 'package:finance_tracking/features/analytics/presentation/view/states/get_daily_analytics_states.dart';
import 'package:finance_tracking/features/analytics/domain/entities/analytics_period.dart';
import 'package:finance_tracking/features/analytics/presentation/screens/widgets/analytics_period_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getDailyAnalyticsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            final currentPeriod = state is GetDailyAnalyticsSuccess 
                ? state.period 
                : AnalyticsPeriod.day;
            await ref
                .read(getDailyAnalyticsProvider.notifier)
                .handleIntent(GetDailyAnalyticsIntentImpl(period: currentPeriod));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AnalyticsHeader(),
                Gap(20.h),
                AnalyticsPeriodSelector(
                  selectedPeriod: state is GetDailyAnalyticsSuccess 
                      ? state.period 
                      : AnalyticsPeriod.day,
                  onPeriodChanged: (period) {
                    ref
                        .read(getDailyAnalyticsProvider.notifier)
                        .handleIntent(GetDailyAnalyticsIntentImpl(period: period));
                  },
                ),
                Gap(20.h),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildContent(state),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(GetDailyAnalyticsStates state) {
    if (state is GetDailyAnalyticsLoading || state is GetDailyAnalyticsInitial) {
      return const AnalyticsLoadingView();
    }

    if (state is GetDailyAnalyticsFailure) {
      return AnalyticsErrorView(message: state.error);
    }

    if (state is GetDailyAnalyticsSuccess) {
      final analytics = state.dailyAnalyticsEntity;
      
      if (analytics.totalIncome == 0 && analytics.totalExpenses == 0) {
        return AnalyticsEmptyView(
          message: AnalyticsStrings.noTransactionsToday,
        );
      }

      if (analytics.totalExpenses == 0) {
        return AnalyticsEmptyView(
          message: AnalyticsStrings.noExpensesToday,
        );
      }

      return AnalyticsContentView(dailyAnalyticsEntity: analytics);
    }

    return const SizedBox.shrink();
  }
}
