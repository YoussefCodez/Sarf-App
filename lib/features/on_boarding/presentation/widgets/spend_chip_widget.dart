import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpendChipWidget extends StatelessWidget {
  final String amount;
  final bool isSelected;
  final VoidCallback onPressed;
  final IconData? icon;

  const SpendChipWidget({
    super.key,
    required this.amount,
    required this.isSelected,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.onBackGroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 20.sp,
                color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
              ),
              Gap(6.w),
            ],
            Text(
              amount,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
