import 'package:finance_tracking/core/app_strings/home_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/home/presentation/view/providers/goal_tracker_provider.dart';
import 'package:finance_tracking/features/home/presentation/view/states/goal_tracker_states.dart';
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
          final state = ref.watch(goalTrackerProvider);

          if (state is GoalTrackerError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = state is GoalTrackerSuccess
              ? state
              : GoalTrackerSuccess.skeleton();
          final isLoading = state is GoalTrackerLoading || state is GoalTrackerInitial;

          return Skeletonizer(
            enabled: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      HomeStrings.yourMainGoal,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    Container(
                      padding: REdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: data.growthPercent > 0 ? AppColors.greenIconBackgroundColor.withValues(
                          alpha: 0.4,
                        ) : AppColors.tertiaryColor.withValues(
                          alpha: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${data.growthPercent.toInt()}%",
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: data.growthPercent > 0 ? AppColors.greenIconBackgroundColor : AppColors.tertiaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Gap(4.w),
                          Icon(
                            data.growthPercent > 0 ? Icons.trending_up : Icons.trending_down,
                            color: data.growthPercent > 0 ? AppColors.greenIconBackgroundColor : AppColors.tertiaryColor,
                            size: 16.r,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  data.goalName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 32.sp,
                      ),
                ),
                Gap(24.h),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: data.currentMoney),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: NumberFormat('#,###').format(value.toInt()),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: "/${NumberFormat('#,###').format(data.goalPrice)}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Gap(12.h),
                LinearProgressIndicator(
                  value: data.percentage / 100,
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.onScreenColor,
                  borderRadius: BorderRadius.circular(12.r),
                  minHeight: 10.h,
                ),
                Gap(24.h),
                Text(
                  HomeStrings.beforeYouSpend,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

