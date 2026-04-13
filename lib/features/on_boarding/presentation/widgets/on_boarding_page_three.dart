import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/app_strings/on_boarding_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/intents/money_tracking_intnet.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/providers/week_money_tracking_provider.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/on_boarding_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OnBoardingPageThree extends StatelessWidget {
  const OnBoardingPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            OnBoardingStrings.weeklySpendTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          Gap(32.h),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.onBackGroundColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final weekMoneyTracking = ref.watch(
                      weekMoneyTrackingNotifierProvider,
                    );
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: weekMoneyTracking.toStringAsFixed(0),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 65.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          WidgetSpan(child: Gap(5.w)),
                          TextSpan(
                            text: OnBoardingStrings.egp,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Text(
                  OnBoardingStrings.estimatedWeeklySpending,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.greyTextColor,
                  ),
                ),
                Gap(16.h),
                Consumer(
                  builder: (context, ref, child) {
                    final weekMoneyTracking = ref.watch(
                      weekMoneyTrackingNotifierProvider,
                    );
                    return SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 12.r,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 20.r,
                        ),
                      ),
                      child: Slider(
                        value: weekMoneyTracking,
                        onChanged: (value) {
                          ref
                              .read(weekMoneyTrackingNotifierProvider.notifier)
                              .handleIntent(
                                MoneyTrackingIntentUpdate(
                                  weekMoneyTracking: value,
                                ),
                              );
                        },
                        min: 50,
                        max: 5000,
                        divisions: 100,
                        activeColor: AppColors.primaryColor,
                        thumbColor: AppColors.primaryColor,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        OnBoardingStrings.minWeeklySpend,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.hintTextColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        OnBoardingStrings.maxWeeklySpend,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.hintTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(16.h),
          OnBoardingCard(
            title: OnBoardingStrings.privacyWarningTitle,
            subTitle: OnBoardingStrings.privacyWarningSubtitle,
            svgPath: AppSvgs.badge,
            bgColor: AppColors.secondaryColor.withValues(alpha: 0.1),
            iconBgColor: AppColors.secondaryColor.withValues(alpha: 0.2),
          ),
          const Spacer(),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () {
                  ref
                      .read(weekMoneyTrackingNotifierProvider.notifier)
                      .handleIntent(MoneyTrackingIntentFinish());
                },
                child: Text(
                  OnBoardingStrings.finishButton,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
            },
          ),
          Gap(16.h),
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () {
                  ref
                      .read(weekMoneyTrackingNotifierProvider.notifier)
                      .handleIntent(MoneyTrackingIntentSkip());
                },
                child: Text(
                  OnBoardingStrings.skipButton,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
