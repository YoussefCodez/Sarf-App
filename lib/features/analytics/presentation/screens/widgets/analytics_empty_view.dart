import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AnalyticsEmptyView extends StatelessWidget {
  final String message;

  const AnalyticsEmptyView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.query_stats_outlined,
            size: 48.sp,
            color: AppColors.greyTextColor.withValues(alpha: 0.5),
          ),
          Gap(12.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.greyTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
