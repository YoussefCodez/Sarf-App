import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpendChipWidget extends StatelessWidget {
  const SpendChipWidget({super.key, required this.amount, required this.isSelected, required this.onPressed});
  final String amount;
  final bool isSelected;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.onBackGroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          amount,
            textAlign: .center,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(
            color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
