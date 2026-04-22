import 'package:finance_tracking/core/app_strings/on_boarding_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/providers/why_tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ChoiceContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const ChoiceContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Consumer(
        builder: (context, ref, child) {
          final refState = ref.watch(whyTrackingNotifierProvider);
          return Container(
            height: 160.h,
            padding: REdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.onBackGroundColor,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: refState.isSavingForGoal && title == OnBoardingStrings.savingGoalYes ||
                    !refState.isSavingForGoal && title == OnBoardingStrings.savingGoalNo
                    ? color
                    : color.withValues(alpha: 0.1),
                width: refState.isSavingForGoal && title == OnBoardingStrings.savingGoalYes ||
                    !refState.isSavingForGoal && title == OnBoardingStrings.savingGoalNo
                    ? 4
                    : 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Container(
                  padding: REdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 32.r),
                ),
                Gap(16.h),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: .center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
