import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/app_strings/on_boarding_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/intents/page_view_intent.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/providers/page_view_provider.dart';
import 'package:finance_tracking/core/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OnBoardingPageOne extends StatefulWidget {
  const OnBoardingPageOne({super.key});

  @override
  State<OnBoardingPageOne> createState() => _OnBoardingPageOneState();
}

class _OnBoardingPageOneState extends State<OnBoardingPageOne> {
  Alignment _alignment = .center;
  bool _isFirstCardVisible = false;
  bool _isSecondCardVisible = false;
  bool _isThirdCardVisible = false;
  bool buttonVisible = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: _alignment,
      duration: Duration(milliseconds: 800),
      onEnd: () {
        setState(() {
          _isFirstCardVisible = true;
        });
      },
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            Text(
              OnBoardingStrings.onBoardingTitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: .center,
            ).animate().fadeIn(duration: Duration(milliseconds: 600)),
            Gap(20.h),
            Text(
                  OnBoardingStrings.onBoardingSubTitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: .center,
                )
                .animate(
                  onComplete: (controller) {
                    Future.delayed(Duration(milliseconds: 200), () {
                      setState(() {
                        _alignment = .topCenter;
                      });
                    });
                  },
                )
                .fadeIn(
                  duration: Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 650),
                ),
            if (_isFirstCardVisible) ...[
              Gap(20.h),
              InfoCard(
                    title: OnBoardingStrings.cardOneTitle,
                    subTitle: OnBoardingStrings.cardOneSubTitle,
                    svgPath: AppSvgs.privacy,
                    bgColor: AppColors.onBackGroundColor,
                  )
                  .animate(
                    onComplete: (controller) {
                      setState(() {
                        _isSecondCardVisible = true;
                      });
                    },
                  )
                  .fadeIn(duration: Duration(milliseconds: 600)),
            ],
            if (_isSecondCardVisible) ...[
              Gap(10.h),
              InfoCard(
                    title: OnBoardingStrings.cardTwoTitle,
                    subTitle: OnBoardingStrings.cardTwoSubTitle,
                    svgPath: AppSvgs.lamp,
                    bgColor: AppColors.greenIconBackgroundColor.withValues(
                      alpha: .1,
                    ),
                    iconBgColor: AppColors.greenIconBackgroundColor.withValues(
                      alpha: .2,
                    ),
                    textColor: AppColors.greenIconBackgroundColor,
                  )
                  .animate(
                    onComplete: (controller) {
                      setState(() {
                        _isThirdCardVisible = true;
                      });
                    },
                  )
                  .fadeIn(duration: Duration(milliseconds: 600)),
            ],
            if (_isThirdCardVisible) ...[
              Gap(10.h),
              InfoCard(
                    title: OnBoardingStrings.cardThreeTitle,
                    subTitle: OnBoardingStrings.cardThreeSubTitle,
                    svgPath: AppSvgs.badge,
                    bgColor: AppColors.secondaryColor.withValues(alpha: .1),
                    iconBgColor: AppColors.secondaryColor.withValues(alpha: .2),
                    textColor: AppColors.secondaryColor,
                  )
                  .animate(
                    onComplete: (controller) {
                      setState(() {
                        buttonVisible = true;
                      });
                    },
                  )
                  .fadeIn(duration: Duration(milliseconds: 600)),
            ],
            if (buttonVisible) ...[
              Spacer(),
              Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () {
                      ref
                          .read(pageViewProvider.notifier)
                          .handleIntent(NextPageIntent());
                    },
                    child: Text(
                      OnBoardingStrings.getStarted,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ).animate().fadeIn(duration: Duration(milliseconds: 600));
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
