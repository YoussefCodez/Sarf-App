import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionTypeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const TransactionTypeButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 20.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ),
      ),
    );
  }
}
