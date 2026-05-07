import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/app_strings/home_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/widgets/icon_with_background.dart';
import 'package:finance_tracking/core/widgets/main_card.dart';
import 'package:finance_tracking/features/streak/presentation/view/intents/streak_intents.dart';
import 'package:finance_tracking/features/streak/presentation/view/providers/streak_providers.dart';
import 'package:finance_tracking/features/streak/presentation/view/states/streak_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StreakWidget extends ConsumerStatefulWidget {
  const StreakWidget({super.key});

  @override
  ConsumerState<StreakWidget> createState() => _StreakWidgetState();
}

class _StreakWidgetState extends ConsumerState<StreakWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(streakProvider.notifier).handleIntent(RecordCheckInIntent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final streakState = ref.watch(streakProvider);

    final int currentStreak;
    if (streakState is StreakSuccess) {
      currentStreak = streakState.streak.currentStreak;
    } else {
      currentStreak = 0;
    }

    final String subtitle = currentStreak == 0
        ? HomeStrings.noStreakYet
        : currentStreak == 1
            ? "$currentStreak ${HomeStrings.dayInARow}"
            : "$currentStreak ${HomeStrings.daysInARow}";

    return MainCard(
          title: HomeStrings.discpline,
          subTitle: subtitle,
          leading: IconWithBackGround(
            icon: Icons.local_fire_department,
            backgroundColor: AppColors.secondaryColor.withValues(alpha: 0.2),
            iconColor: AppColors.secondaryColor,
          ),
          svg: AppSvgs.streakBadge,
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 400),
          duration: Duration(milliseconds: 600),
        )
        .slideY(begin: 0.1, duration: Duration(milliseconds: 600));
  }
}
