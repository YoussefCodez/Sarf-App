import 'package:finance_tracking/core/app_strings/on_boarding_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/select_goal_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddGoal extends StatelessWidget {
  const AddGoal({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SelectGoalPhoto(onTap: () {})
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: -0.1, end: 0, duration: 500.ms),
              Gap(40.h),
              Text(
                OnBoardingStrings.goalName,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 16.sp),
              ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideX(begin: 0.1, end: 0, duration: 500.ms),
              Gap(10.h),
              TextFormField(
                cursorColor: AppColors.primaryColor,
                cursorHeight: 20.h,
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return OnBoardingStrings.goalNameError;
                  }
                  return null;
                },
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: OnBoardingStrings.goalNameHint,
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontSize: 16.sp),
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideX(begin: 0.1, end: 0, duration: 500.ms),
              Gap(30.h),
              Text(
                OnBoardingStrings.targetAmount,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 16.sp),
              ).animate().fadeIn(duration: 500.ms, delay: 600.ms).slideX(begin: 0.1, end: 0, duration: 500.ms),
              Gap(10.h),
              TextFormField(
                cursorColor: AppColors.primaryColor,
                cursorHeight: 30.h,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 32.sp,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: OnBoardingStrings.targetAmountHint,
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 32.sp,
                    fontWeight: .bold,
                  ),
                  suffixIcon: Container(
                    padding: REdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          OnBoardingStrings.egp,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  contentPadding: REdgeInsets.symmetric(vertical: 20.h),
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 800.ms).slideX(begin: 0.1, end: 0, duration: 500.ms),
              Gap(20.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColors.primaryColor,
                        side: BorderSide(color: AppColors.primaryColor),
                      ),
                      onPressed: () {
                        //TODO: Navigate
                      },
                      child: Text(
                        OnBoardingStrings.back,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 1000.ms).slideX(
                      begin: 0.1,
                      end: 0,
                      duration: 500.ms,
                    ),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        //TODO: Navigate
                      },
                      child: Text(
                        OnBoardingStrings.continueButton,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 1000.ms).slideX(
                      begin: 0.1,
                      end: 0,
                      duration: 500.ms,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
