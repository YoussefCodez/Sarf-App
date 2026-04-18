import 'package:finance_tracking/app_routes.dart';
import 'package:finance_tracking/config/models/remote_user_profile_model.dart';
import 'package:finance_tracking/config/models/remote_goal_model.dart';
import 'package:finance_tracking/core/app_strings/sign_up_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/theme/app_gradients.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/intents/auth_intent.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/providers/auth_provider.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/states/auth_states.dart';
import 'package:finance_tracking/features/auth/presentation/widgets/sign_up_widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:finance_tracking/features/on_boarding/data/datasources/on_boarding_local_datasource.dart';
import 'package:finance_tracking/config/services/di_service.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthStates>(authNotifierProvider, (previous, next) {
      if (next is SignUpSuccess) {
        context.go(AppRoutes.homeScreen);
      } else if (next is SignUpError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });

    final useTextTheme = Theme.of(context).textTheme;
    final onBoardingData = getIt<OnBoardingLocalDataSource>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: AppGradients.primaryGradient),
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
                          )
                          .animate()
                          .fadeIn(
                            begin: 0,
                            duration: const Duration(seconds: 1),
                          )
                          .slideX(
                            begin: -0.1,
                            end: 0.0,
                            duration: const Duration(seconds: 1),
                          ),
                      Text(
                            SignUpStrings.createNewAccountDescription,
                            style: useTextTheme.bodySmall,
                          )
                          .animate()
                          .fadeIn(
                            begin: 0,
                            duration: const Duration(seconds: 1),
                          )
                          .slideX(
                            begin: -0.1,
                            end: 0.0,
                            duration: const Duration(seconds: 1),
                          ),
                      Gap(20.h),
                      SignUpForm(
                        useTextTheme: useTextTheme,
                        formKey: _formKey,
                        nameController: _nameController,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            SignUpStrings.alreadyHaveAccount,
                            style: useTextTheme.labelMedium?.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: 15.sp,
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsetsGeometry.zero,
                              ),
                            ),
                            onPressed: () {
                              context.go(
                                "${AppRoutes.loginScreen}?backToSignUp=true",
                              );
                            },
                            child: Text(
                              SignUpStrings.signIn,
                              style: useTextTheme.labelMedium?.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),
                      Consumer(
                        builder: (context, ref, child) {
                          final authState = ref.watch(authNotifierProvider);
                          final isLoading = authState is SignUpLoading;
                          return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            ref
                                                .read(
                                                  authNotifierProvider.notifier,
                                                )
                                                .handleIntent(
                                                  SignUpIntent(
                                                    email: _emailController.text
                                                        .trim(),
                                                    password:
                                                        _passwordController.text
                                                            .trim(),
                                                    userProfileModel: RemoteUserProfileModel(
                                                      id: "",
                                                      name: _nameController.text
                                                          .trim(),
                                                      email: _emailController
                                                          .text
                                                          .trim(),
                                                      weeklySpending:
                                                          onBoardingData
                                                              .getWeeklySpending()
                                                              .toString(),
                                                      forGoal: onBoardingData
                                                          .getTrackingReason(),
                                                      createdAt: DateTime.now(),
                                                    ),
                                                    goalModel:
                                                        onBoardingData
                                                                .getTrackingReason() &&
                                                            onBoardingData
                                                                    .getGoal() !=
                                                                null
                                                        ? RemoteGoalModel(
                                                            id: "",
                                                            createdAt:
                                                                DateTime.now(),
                                                            name: onBoardingData
                                                                .getGoal()!
                                                                .name,
                                                            image:
                                                                onBoardingData
                                                                    .getGoal()!
                                                                    .imagePath,
                                                            price:
                                                                double.tryParse(
                                                                  onBoardingData
                                                                      .getGoal()!
                                                                      .price,
                                                                ) ??
                                                                0.0,
                                                            userId: "",
                                                          )
                                                        : null,
                                                  ),
                                                );
                                          }
                                        },
                                  child: isLoading
                                      ? LoadingAnimationWidget.inkDrop(
                                          color: Colors.white,
                                          size: 24,
                                        )
                                      : Text(
                                          SignUpStrings.createNewAccount,
                                          style: useTextTheme.labelMedium,
                                        ),
                                ),
                              )
                              .animate()
                              .fadeIn(
                                begin: 0,
                                duration: const Duration(seconds: 1),
                              )
                              .slideY(
                                begin: -0.1,
                                end: 0.0,
                                duration: const Duration(seconds: 1),
                              );
                        },
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
