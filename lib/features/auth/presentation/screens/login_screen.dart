import 'package:finance_tracking/app_routes.dart';
import 'package:finance_tracking/core/app_strings/login_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/theme/app_gradients.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/intents/auth_intent.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/providers/auth_provider.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/states/auth_states.dart';
import 'package:finance_tracking/features/auth/presentation/widgets/login_widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final bool backToSignUp;
  const LoginScreen({super.key, this.backToSignUp = false});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthStates>(authNotifierProvider, (previous, next) {
      if (next is LoginSuccess) {
        context.go(AppRoutes.homeScreen);
      } else if (next is LoginError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage, style: TextStyle(color: AppColors.whiteColor,fontSize: 14.sp),),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });

    final useTextTheme = Theme.of(context).textTheme;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                            LoginStrings.welcomeBack,
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
                            LoginStrings.welcomeBackDescription,
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
                      LoginForm(
                        useTextTheme: useTextTheme,
                        formKey: _formKey,
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LoginStrings.dontHaveAccount,
                            style: useTextTheme.labelMedium?.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: 15.sp,
                            ),
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.zero,
                              ),
                            ),
                            onPressed: () {
                              context.go(AppRoutes.signUpScreen);
                            },
                            child: Text(
                              LoginStrings.signUp,
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
                          final isLoading = authState is LoginLoading;
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
                                                    authNotifierProvider.notifier)
                                                .handleIntent(
                                                  LoginIntent(
                                                    email: _emailController.text
                                                        .trim(),
                                                    password:
                                                        _passwordController.text
                                                            .trim(),
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
                                          LoginStrings.login,
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