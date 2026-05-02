import 'package:finance_tracking/core/app_strings/home_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/providers/get_profile_provider.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/states/get_profile_states.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/get_transaction_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NoGoalOverviewWidget extends ConsumerWidget {
  const NoGoalOverviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(getProfileProvider);
    String currentMoney = "0.0";
    if (profileState is GetProfileSuccess) {
      currentMoney = profileState.userProfileEntity.currentMoney;
    }

    final transactionState = ref.watch(getTransactionProvider);
    double totalSpent = 0.0;
    if (transactionState is GetTransactionSuccess) {
      for (var trx in transactionState.transactions) {
        if (trx.type.toLowerCase() == 'expense') {
          totalSpent += trx.price;
        }
      }
    }

    return Container(
      padding: REdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    HomeStrings.currentMoney,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.hintTextColor,
                          fontSize: 14.sp,
                        ),
                  ),
                  Gap(8.h),
                  Text(
                    "\$ $currentMoney",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 22.sp,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            VerticalDivider(
              color: AppColors.darkGreen,
              thickness: 1.5,
              width: 30.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    HomeStrings.totalSpent,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.hintTextColor,
                          fontSize: 14.sp,
                        ),
                  ),
                  Gap(8.h),
                  Text(
                    "\$ ${totalSpent.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.tertiaryColor,
                          fontSize: 22.sp,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
