import 'package:finance_tracking/config/utils/format_price.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/widgets/icon_with_background.dart';
import 'package:finance_tracking/core/widgets/main_card.dart';
import 'package:finance_tracking/features/transaction/presentation/view/intents/transaction_intents.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/get_transaction_states.dart';
import 'package:finance_tracking/features/transaction/presentation/screens/widgets/transaction_category_tabs.dart';
import 'package:finance_tracking/features/transaction/presentation/screens/widgets/transaction_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  ConsumerState<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends ConsumerState<TransactionHistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getTransactionProvider.notifier).handleIntent(
        GetTransactionsIntent(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getTransactionProvider);
    final filteredTransactions = ref.watch(filteredTransactionsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.whiteColor, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Transactions',
          style: TextStyle(color: AppColors.whiteColor, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Gap(10.h),
            const TransactionSearchField(),
            Gap(20.h),
            const TransactionCategoryTabs(),
            Gap(24.h),
            Expanded(
              child: state is GetTransactionLoading
                  ? Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: AppColors.primaryColor,
                        size: 50.sp,
                      ),
                    )
                  : filteredTransactions.isEmpty
                      ? _buildEmptyState()
                      : _buildGroupedList(filteredTransactions),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64.sp, color: AppColors.hintTextColor),
          Gap(16.h),
          Text(
            'No transactions found',
            style: TextStyle(color: AppColors.hintTextColor, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedList(List<dynamic> transactions) {
    final grouped = _groupTransactionsByDate(transactions);

    return ListView.builder(
      itemCount: grouped.keys.length,
      itemBuilder: (context, index) {
        final dateKey = grouped.keys.elementAt(index);
        final txs = grouped[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text(
                dateKey,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...txs.map((tx) => Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: _buildTransactionItem(tx),
                )),
            Gap(10.h),
          ],
        );
      },
    );
  }

  Map<String, List<dynamic>> _groupTransactionsByDate(List<dynamic> transactions) {
    final Map<String, List<dynamic>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var tx in transactions) {
      final date = DateTime(tx.createdAt.year, tx.createdAt.month, tx.createdAt.day);
      String key;
      if (date == today) {
        key = 'Today';
      } else if (date == yesterday) {
        key = 'Yesterday';
      } else {
        key = DateFormat('dd MMMM yyyy').format(tx.createdAt);
      }

      if (grouped[key] == null) {
        grouped[key] = [];
      }
      grouped[key]!.add(tx);
    }
    return grouped;
  }

  Widget _buildTransactionItem(dynamic transaction) {
    IconData icon = Icons.paid_outlined;
    switch (transaction.category.toLowerCase()) {
      case "income": icon = Icons.trending_up; break;
      case "transport": icon = Icons.directions_transit; break;
      case "food": icon = Icons.fastfood; break;
      case "market": icon = Icons.shopping_cart; break;
      case "medical": icon = Icons.medical_services; break;
      case "rent": icon = Icons.house; break;
      case "other": icon = Icons.paid_outlined; break;
    }

    return MainCard(
      title: transaction.category == "income" ? "Income" : transaction.name,
      subTitle: DateFormat('hh:mm a').format(transaction.createdAt),
      subTitleFontSize: 13,
      leading: IconWithBackGround(
        icon: icon,
        backgroundColor: AppColors.greyIconBackgroundColor,
        iconColor: AppColors.whiteColor,
        iconSize: 24,
      ),
      isNoted: transaction.note != null,
      note: transaction.note ?? "",
      trailing: Text(
        "${formatPrice(transaction.price)} EGP",
        style: TextStyle(
          color: transaction.type == 'income' ? AppColors.primaryColor : AppColors.tertiaryColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
