import 'package:finance_tracking/app_routes.dart';
import 'package:finance_tracking/core/app_strings/home_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeTransactionHeader extends StatelessWidget {
  const HomeTransactionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          HomeStrings.recentTransactions,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontSize: 20.sp),
        ),
        GestureDetector(
          onTap: () {
            context.push(AppRoutes.transactionHistory);
          },
          child: Text(
            HomeStrings.viewAll,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
