import 'package:finance_tracking/app_routes.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/app_strings/settings_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PaymentCardsRow extends StatelessWidget {
  const PaymentCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.paymentCardsScreen);
      },
      child: Container(
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.onBackGroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.cardColor, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 45.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryColor, AppColors.darkGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Icon(Icons.credit_card, color: Colors.white, size: 16.sp),
                  ),
                ),
                Gap(4.w),
                Container(
                  width: 45.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.secondaryColor, const Color(0xFFD4A017)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Icon(Icons.credit_card, color: Colors.white, size: 16.sp),
                  ),
                ),
                Gap(12.w),
                Text(
                  SettingsStrings.myCards,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.hintTextColor,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
