import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/app_strings/settings_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PhoneNumberRow extends StatelessWidget {
  const PhoneNumberRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.onBackGroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.cardColor, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: REdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.greyIconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.phone,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  SettingsStrings.phoneNumber,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 12.sp,
                  ),
                ),
                Gap(2.h),
                Text(
                  SettingsStrings.dummyPhoneNumber, // Would be fetched from user profile if available
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.edit_outlined,
            color: AppColors.hintTextColor,
            size: 18.sp,
          ),
        ],
      ),
    );
  }
}
