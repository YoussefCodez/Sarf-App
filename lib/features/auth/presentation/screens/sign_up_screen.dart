import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/app_strings/sign_up_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/theme/app_gradients.dart';
import 'package:finance_tracking/core/widgets/info_card.dart';
import 'package:finance_tracking/features/auth/presentation/widgets/sign_up_widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final useTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: AppGradients.primaryGradient,
          ),
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 24),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      const Spacer(),
                      Text(
                        SignUpStrings.createNewAccount,
                        style: useTextTheme.bodyMedium,
                      ),
                      Text(
                        SignUpStrings.createNewAccountDescription,
                        style: useTextTheme.bodySmall,
                      ),
                      Gap(20.h),
                      SignUpForm(useTextTheme: useTextTheme),
                      Gap(20.h),
                      InfoCard(
                        title: "Why to sign up?",
                        subTitle:
                            "To Recovry your account data and sync it across devices",
                        svgPath: AppSvgs.privacy,
                        bgColor: AppColors.secondaryColor.withValues(alpha: 0.1),
                        iconBgColor: AppColors.secondaryColor.withValues(alpha: 0.2),
                        textColor: AppColors.secondaryColor,
                      ),
                      const Spacer(),
                      Gap(20.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            SignUpStrings.createNewAccount,
                            style: useTextTheme.labelMedium,
                          ),
                        ),
                      ),
                      Gap(20.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
