import 'package:finance_tracking/features/on_boarding/presentation/view/intents/why_tracking_intent.dart';
import 'package:finance_tracking/core/app_strings/on_boarding_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/providers/why_tracking_provider.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/choice_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WhyTracking extends ConsumerWidget {
  final VoidCallback onContinue;

  const WhyTracking({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: REdgeInsets.only(left: 20, right: 20, bottom: 20, top: 60.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            OnBoardingStrings.onBoardingPageTwoTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
          Gap(12.h),
          Text(
            OnBoardingStrings.onBoardingPageTwoSubTitle,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
          Gap(40.h),
          Row(
            children: [
              Expanded(
                child: ChoiceContainer(
                  title: OnBoardingStrings.savingGoalYes,
                  icon: Icons.auto_graph_rounded,
                  color: AppColors.primaryColor,
                  onTap: () {
                    ref.read(whyTrackingNotifierProvider.notifier).handleIntent(
                      const SetIsSavingForGoalIntent(isSavingForGoal: true),
                    );
                  },
                ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(
                  begin: -0.1,
                  end: 0,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: ChoiceContainer(
                  title: OnBoardingStrings.savingGoalNo,
                  icon: Icons.track_changes_rounded,
                  color: AppColors.secondaryColor,
                  onTap: () {
                    ref.read(whyTrackingNotifierProvider.notifier).handleIntent(
                      const SetIsSavingForGoalIntent(isSavingForGoal: false),
                    );
                  },
                ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideX(
                  begin: 0.1,
                  end: 0,
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: onContinue,
            child: Text(
              OnBoardingStrings.continueButton,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
        ],
      ),
    );
  }
}
