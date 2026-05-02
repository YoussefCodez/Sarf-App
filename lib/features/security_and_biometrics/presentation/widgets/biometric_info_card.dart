import 'package:finance_tracking/core/app_strings/biometrics_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BiometricInfoCard extends StatelessWidget {
  const BiometricInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.onBackGroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.hintTextColor,
            size: 20.sp,
          ),
          Gap(12.w),
          Expanded(
            child: Text(
              BiometricsStrings.biometricInfoNote,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.hintTextColor,
                    height: 1.5,
                    fontSize: 14.sp,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
