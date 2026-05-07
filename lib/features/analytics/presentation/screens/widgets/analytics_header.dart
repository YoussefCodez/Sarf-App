import 'package:finance_tracking/core/app_strings/analytics_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AnalyticsHeader extends StatelessWidget {
  const AnalyticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AnalyticsStrings.screenTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
        ),
        Gap(6.h),
        Text(
          AnalyticsStrings.screenSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.greyTextColor,
                fontSize: 14.sp,
              ),
        ),
      ],
    );
  }
}
