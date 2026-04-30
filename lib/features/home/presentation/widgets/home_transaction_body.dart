import 'dart:math' as math;
import 'package:finance_tracking/config/utils/format_price.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/widgets/icon_with_background.dart';
import 'package:finance_tracking/core/widgets/main_card.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/get_transaction_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeTransactionBody extends ConsumerWidget {
  const HomeTransactionBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getTransactionProvider);

    if (state is GetTransactionLoading || state is GetTransactionInitial) {
      return SliverList.separated(
        itemCount: 5,
        itemBuilder: (context, index) =>
            Skeletonizer(enabled: true, child: _buildItemCard(context, null)),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
      );
    }

    if (state is GetTransactionError) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

    final successState = state as GetTransactionSuccess;
    final transactions = successState.transactions;

    if (transactions.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: Center(
            child: Text(
              "No transactions yet",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.hintTextColor),
            ),
          ),
        ),
      );
    }

    final displayCount = math.min(transactions.length, 5);

    return SliverList.separated(
      itemCount: displayCount,
      itemBuilder: (context, index) {
        return _buildItemCard(context, transactions[index]);
      },
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
    );
  }

  Widget _buildItemCard(BuildContext context, dynamic transaction) {
    final price = transaction?.price ?? 0.0;
    IconData icon = Icons.other_houses;
    if (transaction != null) {
      switch (transaction.category) {
        case "income":
          icon = Icons.trending_up;
          break;
        case "transport":
          icon = Icons.directions_transit;
          break;
        case "food":
          icon = Icons.fastfood;
          break;
        case "market":
          icon = Icons.shopping_cart;
          break;
        case "medical":
          icon = Icons.medical_services;
          break;
        case "rent":
          icon = Icons.house;
          break;
      }
    }

    return MainCard(
      title: transaction?.category == "income" ? "Income" : transaction?.name ?? "Loading..",
      subTitle:
          transaction?.createdAt.toString().substring(0, 10) ?? "2 Hours Ago",
      subTitleFontSize: 13,
      leading: IconWithBackGround(
        icon: icon,
        backgroundColor: AppColors.greyIconBackgroundColor,
        iconColor: AppColors.whiteColor,
        iconSize: 24,
      ),
      trailing: Text(
        "${formatPrice(price)} EGP",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: transaction?.type == 'income'
              ? AppColors.primaryColor
              : AppColors.tertiaryColor,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
