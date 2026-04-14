import 'package:finance_tracking/core/app_strings/sign_up_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, required this.useTextTheme});

  final TextTheme useTextTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: double.infinity,
                  padding: REdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.onBackGroundColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: AppColors.primaryColor,
                        cursorHeight: 20.h,
                        style: useTextTheme.labelSmall,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                          ),
                          hintText: SignUpStrings.nameHint,
                          hintStyle: useTextTheme.bodySmall,
                          fillColor: AppColors.greyIconBackgroundColor,
                          filled: true,
                        ),
                      ),
                      Gap(20.h),
                      TextFormField(
                        cursorColor: AppColors.primaryColor,
                        cursorHeight: 20.h,
                        style: useTextTheme.labelSmall,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColors.primaryColor,
                          ),
                          hintText: SignUpStrings.emailHint,
                          hintStyle: useTextTheme.bodySmall,
                          fillColor: AppColors.greyIconBackgroundColor,
                          filled: true,
                        ),
                      ),
                      Gap(20.h),
                      TextFormField(
                        cursorColor: AppColors.primaryColor,
                        cursorHeight: 20.h,
                        style: useTextTheme.labelSmall,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.primaryColor,
                          ),
                          hintText: SignUpStrings.passwordHint,
                          hintStyle: useTextTheme.bodySmall,
                          fillColor: AppColors.greyIconBackgroundColor,
                          filled: true,
                        ),
                      ),
                      Gap(20.h),
                      TextFormField(
                        cursorColor: AppColors.primaryColor,
                        cursorHeight: 20.h,
                        style: useTextTheme.labelSmall,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.primaryColor,
                          ),
                          hintText: SignUpStrings.confirmPasswordHint,
                          hintStyle: useTextTheme.bodySmall,
                          fillColor: AppColors.greyIconBackgroundColor,
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                );
  }
}