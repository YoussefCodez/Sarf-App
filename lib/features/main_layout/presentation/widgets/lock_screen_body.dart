import 'package:finance_tracking/core/app_strings/biometrics_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LockScreenBody extends StatelessWidget {
  final VoidCallback onUnlockPressed;

  const LockScreenBody({super.key, required this.onUnlockPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 3),
              Container(
                padding: REdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cardColor,
                ),
                child: Container(
                  padding: REdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor.withValues(alpha: 0.12),
                  ),
                  child: Icon(
                    Icons.lock_rounded,
                    size: 48.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Gap(32.h),
              Text(
                BiometricsStrings.appLocked,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                      fontSize: 20.sp,
                    ),
              ),
              Gap(12.h),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  BiometricsStrings.pleaseAuthenticate,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.subTitleColor,
                        height: 1.5,
                      ),
                ),
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: onUnlockPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fingerprint,
                        color: AppColors.backgroundColor,
                        size: 22.sp,
                      ),
                      Gap(10.w),
                      Text(
                        BiometricsStrings.unlockWithBiometrics,
                        style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }
}
