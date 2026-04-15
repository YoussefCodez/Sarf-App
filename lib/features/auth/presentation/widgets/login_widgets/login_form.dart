import 'package:finance_tracking/config/utils.dart';
import 'package:finance_tracking/core/app_strings/login_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.useTextTheme,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final TextTheme useTextTheme;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

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
                  controller: emailController,
                  validator: Validators.validateEmail,
                  cursorColor: AppColors.primaryColor,
                  cursorHeight: 20.h,
                  style: useTextTheme.labelSmall,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.primaryColor,
                    ),
                    hintText: LoginStrings.emailHint,
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
                    hintText: LoginStrings.passwordHint,
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
          ],
        ),
      ),
    );
  }
}
