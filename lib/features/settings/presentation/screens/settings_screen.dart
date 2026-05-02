import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/app_strings/settings_strings.dart';
import 'package:finance_tracking/core/widgets/custom_toast.dart';
import 'package:finance_tracking/core/widgets/custom_confirmation_dialog.dart';
import 'package:finance_tracking/features/settings/presentation/widgets/profile_header.dart';
import 'package:finance_tracking/features/settings/presentation/widgets/payment_cards_row.dart';
import 'package:finance_tracking/features/settings/presentation/widgets/phone_number_row.dart';
import 'package:finance_tracking/features/settings/presentation/widgets/settings_action_row.dart';
import 'package:finance_tracking/features/auth/presentation/view/providers/auth_provider.dart';
import 'package:finance_tracking/features/auth/presentation/view/states/auth_states.dart';
import 'package:finance_tracking/features/auth/presentation/view/intents/auth_intent.dart';
import 'package:finance_tracking/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next is LogoutSuccess) {
        context.go("${AppRoutes.loginScreen}?backToSignUp=false");
      } else if (next is LogoutError) {
        CustomToast.show(
          context: context,
          message: next.errorMessage,
          type: ToastType.error,
        );
      } else if (next is LogoutLoading) {
        CustomToast.show(
          context: context,
          message: "Logging out... , Please Don't Close The App",
          type: ToastType.warning,
        );
      }
    });

    final authState = ref.watch(authNotifierProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: REdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SettingsStrings.settings,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Gap(24.h),
            const ProfileHeader(),
            Gap(24.h),
            const PaymentCardsRow(),
            Gap(16.h),
            const PhoneNumberRow(),
            Gap(24.h),
            Text(
              SettingsStrings.general,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
            Gap(16.h),
            SettingsActionRow(
              icon: Icons.language,
              title: SettingsStrings.language,
              onTap: () {},
            ),
            SettingsActionRow(
              icon: Icons.notifications_active_outlined,
              title: SettingsStrings.notifications,
              onTap: () {},
            ),
            SettingsActionRow(
              icon: Icons.security,
              title: SettingsStrings.securityAndBiometrics,
              onTap: () {
                context.push(AppRoutes.securityAndBiometricsScreen);
              },
            ),
            SettingsActionRow(
              icon: Icons.privacy_tip_outlined,
              title: SettingsStrings.privacyPolicy,
              onTap: () {},
            ),
            Gap(16.h),
            Text(
              SettingsStrings.dangerZone,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.tertiaryColor,
              ),
            ),
            Gap(16.h),
            SettingsActionRow(
              icon: Icons.logout,
              title: SettingsStrings.logout,
              isDestructive: true,
              onTap: () {
                CustomConfirmationDialog.show(
                  context: context,
                  title: SettingsStrings.logoutConfirmationTitle,
                  content: SettingsStrings.logoutConfirmationBody,
                  confirmText: SettingsStrings.logout,
                  cancelText: SettingsStrings.cancel,
                  isDestructive: true,
                  onConfirm: () {
                    authState is LogoutLoading
                        ? null
                        : ref
                            .read(authNotifierProvider.notifier)
                            .handleIntent(LogoutIntent());
                  },
                );
              },
            ),
            Gap(100.h),
          ],
        ),
      ),
    );
  }
}
