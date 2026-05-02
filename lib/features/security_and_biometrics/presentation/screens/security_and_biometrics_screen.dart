import 'package:finance_tracking/core/app_strings/biometrics_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/widgets/custom_toast.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/view/intents/biometrics_intents.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/view/providers/biometrics_provider.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/view/states/biometrics_states.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/widgets/biometric_info_card.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/widgets/biometrics_switch_widget.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/widgets/security_header_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SecurityAndBiometricsScreen extends ConsumerStatefulWidget {
  const SecurityAndBiometricsScreen({super.key});

  @override
  ConsumerState<SecurityAndBiometricsScreen> createState() =>
      _SecurityAndBiometricsScreenState();
}

class _SecurityAndBiometricsScreenState
    extends ConsumerState<SecurityAndBiometricsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(biometricsProvider.notifier)
          .handleIntent(GetBiometricsStatusIntent());
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(biometricsProvider, (previous, next) {
      if (next is BiometricsError) {
        CustomToast.show(
          context: context,
          message: next.message,
          type: ToastType.error,
        );
      } else if (next is BiometricsAuthFailed) {
        CustomToast.show(
          context: context,
          message: BiometricsStrings.authFailed,
          type: ToastType.error,
        );
      }
    });

    final state = ref.watch(biometricsProvider);

    bool isEnabled = false;
    if (state is BiometricsStatusLoaded) {
      isEnabled = state.isEnabled;
    } else if (state is BiometricsAuthSuccess) {
      isEnabled = state.newStatus;
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
            size: 20.sp,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          BiometricsStrings.securityAndBiometrics,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(16.h),
              const SecurityHeaderCard(),
              Gap(28.h),
              Text(
                BiometricsStrings.biometricAuth.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.hintTextColor,
                      letterSpacing: 1.0,
                    ),
              ),
              Gap(12.h),
              BiometricSwitchWidget(
                isEnabled: isEnabled,
                title: BiometricsStrings.biometricAuth,
                subtitle: BiometricsStrings.biometricAuthDesc,
                icon: Icons.fingerprint,
                onChanged: (value) {
                  ref.read(biometricsProvider.notifier).handleIntent(
                        ToggleBiometricsIntent(
                          enable: value,
                          localizedReason:
                              BiometricsStrings.authenticateToEnable,
                        ),
                      );
                },
              ),
              Gap(20.h),
              const BiometricInfoCard(),
              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }
}
