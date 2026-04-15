import 'package:finance_tracking/config/utils.dart';
import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/app_strings/on_boarding_strings.dart';
import 'package:finance_tracking/core/app_strings/sign_up_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.useTextTheme,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextTheme useTextTheme;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.onBackGroundColor.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            TextFormField(
                  controller: nameController,
                  validator: Validators.validateName,
                  cursorColor: AppColors.primaryColor,
                  cursorHeight: 20.h,
                  style: useTextTheme.labelSmall,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: AppColors.primaryColor),
                    hintText: SignUpStrings.nameHint,
                    hintStyle: useTextTheme.bodySmall,
                    fillColor: AppColors.greyIconBackgroundColor,
                    filled: true,
                  ),
                )
                .animate()
                .fadeIn(begin: 0, duration: const Duration(seconds: 1))
                .slideX(
                  begin: -0.1,
                  end: 0.0,
                  duration: const Duration(seconds: 1),
                ),
            Gap(20.h),
            TextFormField(
                  controller: emailController,
                  validator: Validators.validateEmail,
                  cursorColor: AppColors.primaryColor,
                  cursorHeight: 20.h,
                  style: useTextTheme.labelSmall,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: AppColors.primaryColor),
                    hintText: SignUpStrings.emailHint,
                    hintStyle: useTextTheme.bodySmall,
                    fillColor: AppColors.greyIconBackgroundColor,
                    filled: true,
                  ),
                )
                .animate()
                .fadeIn(begin: 0, duration: const Duration(seconds: 1))
                .slideX(
                  begin: 0.1,
                  end: 0.0,
                  duration: const Duration(seconds: 1),
                ),
            Gap(20.h),
            TextFormField(
                  controller: passwordController,
                  validator: Validators.validatePassword,
                  obscureText: true,
                  cursorColor: AppColors.primaryColor,
                  cursorHeight: 20.h,
                  style: useTextTheme.labelSmall,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor),
                    hintText: SignUpStrings.passwordHint,
                    hintStyle: useTextTheme.bodySmall,
                    fillColor: AppColors.greyIconBackgroundColor,
                    filled: true,
                  ),
                )
                .animate()
                .fadeIn(begin: 0, duration: const Duration(seconds: 1))
                .slideX(
                  begin: -0.1,
                  end: 0.0,
                  duration: const Duration(seconds: 1),
                ),
            Gap(20.h),
            TextFormField(
                  controller: confirmPasswordController,
                  validator: (value) => Validators.validateConfirmPassword(
                    value,
                    passwordController.text,
                  ),
                  obscureText: true,
                  cursorColor: AppColors.primaryColor,
                  cursorHeight: 20.h,
                  style: useTextTheme.labelSmall,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor),
                    hintText: SignUpStrings.confirmPasswordHint,
                    hintStyle: useTextTheme.bodySmall,
                    fillColor: AppColors.greyIconBackgroundColor,
                    filled: true,
                  ),
                )
                .animate()
                .fadeIn(begin: 0, duration: const Duration(seconds: 1))
                .slideX(
                  begin: 0.1,
                  end: 0.0,
                  duration: const Duration(seconds: 1),
                ),
            Gap(20.h),
            InfoCard(
                  title: OnBoardingStrings.whyToSignUp,
                  subTitle: OnBoardingStrings.whyToSignUpSubtitle,
                  svgPath: AppSvgs.privacy,
                  bgColor: AppColors.secondaryColor.withValues(alpha: 0.1),
                  iconBgColor: AppColors.secondaryColor.withValues(alpha: 0.2),
                  textColor: AppColors.secondaryColor,
                )
                .animate()
                .fadeIn(begin: 0, duration: const Duration(seconds: 1))
                .slideY(
                  begin: -0.1,
                  end: 0.0,
                  duration: const Duration(seconds: 1),
                ),
          ],
        ),
      ),
    );
  }
}
