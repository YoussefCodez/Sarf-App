import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.home_rounded,
      Icons.analytics,
      Icons.add,
      Icons.account_balance_wallet_rounded,
      Icons.settings,
    ];

    return Container(
      margin: REdgeInsets.only(left: 24, right: 24, bottom: 32),
      decoration: BoxDecoration(
        color: AppColors.secondCardColor,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20.r,
            spreadRadius: 5.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(icons.length, (index) {
            final isCenter = index == 2;
            final isSelected = currentIndex == index;
            if (isCenter) {
              return GestureDetector(
                onTap: () => onTap(index),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 56.r,
                  width: 56.r,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withValues(alpha: 0.4),
                        blurRadius: 15.r,
                        offset: Offset(0, 5.h),
                      ),
                    ],
                  ),
                  child: Icon(
                    icons[index],
                    color: AppColors.whiteColor,
                    size: 32.sp,
                  ),
                ),
              );
            }

            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutBack,
                padding: REdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor.withValues(alpha: 0.15)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: isSelected ? 1.1 : 1.0,
                  child: Icon(
                    icons[index],
                    color: isSelected ? AppColors.primaryColor : AppColors.hintTextColor,
                    size: 28.sp,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
