import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/app_strings/home_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/widgets/icon_with_background.dart';
import 'package:finance_tracking/core/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StreakWidget extends StatelessWidget {
  const StreakWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MainCard(
          title: HomeStrings.discpline,
          subTitle: "3 ${HomeStrings.daysInARow}",
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
