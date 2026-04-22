import 'package:finance_tracking/config/utils/advices_utils.dart';
import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/app_strings/home_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/widgets/info_card.dart';
import 'package:finance_tracking/features/daily_advice/domain/entities/user_finance_entity.dart';
import 'package:finance_tracking/features/daily_advice/presentation/providers/daily_advice_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class GoalTrackerWidget extends StatelessWidget {
  const GoalTrackerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final financeData = UserFinanceEntity(
      userId: "123",
      goalAmount: 2000,
      weeklySpend: 1000,
    );

    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Text(
                "Your Main Goal",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Spacer(),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.greenIconBackgroundColor.withValues(
                    alpha: 0.4,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  "42%",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.greenIconBackgroundColor,
                    fontSize: 14.sp,
                    fontWeight: .bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Laptop",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: .w900,
              fontSize: 32.sp,
            ),
          ),
          Gap(24.h),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1200),
            duration: Duration(seconds: 2),
            builder: (context, value, child) {
              return Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: NumberFormat('#,###').format(value.toInt()),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: "/2,000",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            },
          ),
          Gap(12.h),
          LinearProgressIndicator(
            value: 0.6,
            color: AppColors.primaryColor,
            backgroundColor: AppColors.progressColor,
            borderRadius: BorderRadius.circular(12.r),
            minHeight: 10.h,
          ),
          Gap(24.h),
          Consumer(
            builder: (context, ref, child) {
              final advice = ref.watch(dailyAdviceProvider(financeData));
              return InfoCard(
                title: "Advice",
                subTitle: advice,
                bgColor: AppColors.primaryColor.withValues(alpha: 0.2),
                svgPath: AppSvgs.lamp,
                iconBgColor: AppColors.primaryColor,
                textColor: AppColors.whiteColor,
                svgColor: AppColors.whiteColor,
              );
            },
          ),
          Gap(24.h),
          Text(
            HomeStrings.beforeYouSpend,
            textAlign: .center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
