import 'package:finance_tracking/core/app_strings/biometrics_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SecurityHeaderCard extends StatelessWidget {
  const SecurityHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Container(
            padding: REdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withValues(alpha: 0.12),
            ),
            child: Icon(
              Icons.shield_rounded,
              size: 48.sp,
              color: AppColors.primaryColor,
            ),
          ),
          Gap(20.h),
          Text(
            BiometricsStrings.protectYourFinances,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor,
                  fontSize: 18.sp,
                ),
          ),
          Gap(8.h),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 12),
            child: Text(
              BiometricsStrings.protectYourFinancesDesc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.subTitleColor,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
