import 'package:finance_tracking/features/on_boarding/presentation/view_models/intents/why_tracking_intent.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/providers/why_tracking_provider.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/states/why_tracking_state.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/add_goal.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/why_tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardingPageTwo extends ConsumerWidget {
  const OnBoardingPageTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(whyTrackingNotifierProvider.select((s) => s.step));

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: step == WhyTrackingStep.addGoal
          ? AddGoal()
          : WhyTracking(
              onContinue: () {
                ref
                    .read(whyTrackingNotifierProvider.notifier)
                    .handleIntent(const SubmitSavingPreferenceIntent());
              },
            ),
    );
  }
}