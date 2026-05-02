import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BiometricSwitchWidget extends StatelessWidget {
  final bool isEnabled;
  final ValueChanged<bool> onChanged;
  final String title;
  final String subtitle;
  final IconData icon;

  const BiometricSwitchWidget({
    super.key,
    required this.isEnabled,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: REdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.greyIconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 22.sp),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                ),
                Gap(4.h),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.hintTextColor,
                        fontSize: 11.sp,
                      ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: isEnabled,
            onChanged: onChanged,
            activeThumbColor: AppColors.primaryColor,
            activeTrackColor: AppColors.primaryColor.withValues(alpha: 0.3),
            inactiveThumbColor: AppColors.hintTextColor,
            inactiveTrackColor: AppColors.greyIconBackgroundColor,
          ),
        ],
      ),
    );
  }
}
