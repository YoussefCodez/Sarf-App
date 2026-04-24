import 'package:finance_tracking/core/app_strings/home_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/get_goal/presentation/view/providers/get_goal_provider.dart';
import 'package:finance_tracking/features/get_goal/presentation/view/states/get_goal_states.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/providers/get_profile_provider.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/states/get_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GoalTrackerWidget extends StatelessWidget {
  const GoalTrackerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(getGoalProvider);
          final profileState = ref.watch(getProfileProvider);
          final profile = profileState is GetProfileSuccess ? profileState.userProfileEntity : null;
          final currentMoneyStr = profile?.currentMoney ?? "0";
          final currentMoney = double.tryParse(currentMoneyStr) ?? 0.0;
          final percentage = state is GetGoalSuccess && state.goalEntity.price > 0 
              ? (currentMoney / state.goalEntity.price) * 100 
              : 0.0;
          return Skeletonizer(
            enabled: state is GetGoalLoading || profileState is GetProfileLoading,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Text(
                      HomeStrings.yourMainGoal,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Spacer(),
                    Container(
                      padding: REdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.greenIconBackgroundColor.withValues(
                          alpha: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "42%",
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.greenIconBackgroundColor,
                                  fontSize: 14.sp,
                                  fontWeight: .bold,
                                ),
                          ),
                          Gap(4.w),
                          Icon(
                            Icons.trending_up,
                            color: AppColors.greenIconBackgroundColor,
                            size: 16.r,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  state is GetGoalSuccess ? state.goalEntity.name : "GoalName",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: .w900,
                    fontSize: 32.sp,
                  ),
                ),
                Gap(24.h),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: currentMoney),
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
                            text: state is GetGoalSuccess
                                ? "/${NumberFormat('#,###').format(state.goalEntity.price)}"
                                : "/2,000",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                
                Gap(12.h),
                LinearProgressIndicator(
                  value: percentage / 100,
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.progressColor,
                  borderRadius: BorderRadius.circular(12.r),
                  minHeight: 10.h,
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
        },
      ),
    );
  }
}
