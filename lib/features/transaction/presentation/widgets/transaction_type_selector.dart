import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/app_strings/transaction_strings.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/transaction_states.dart';
import 'package:finance_tracking/features/transaction/presentation/widgets/transaction_type_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionTypeSelector extends ConsumerWidget {
  const TransactionTypeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionType = ref.watch(transactionTypeProvider);
    final isIncome = transactionType == TransactionType.income;

    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(6),
      height: 60.h,
      margin: REdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.secondCardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: isIncome ? Alignment.centerLeft : Alignment.centerRight,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: constraints.maxWidth / 2,
                  decoration: BoxDecoration(
                    color: isIncome ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
              Row(
                children: [
                  TransactionTypeButton(
                    label: TransactionStrings.income,
                    isSelected: isIncome,
                    onTap: () => ref.read(transactionTypeProvider.notifier).setIncome(),
                  ),
                  TransactionTypeButton(
                    label: TransactionStrings.expense,
                    isSelected: !isIncome,
                    onTap: () => ref.read(transactionTypeProvider.notifier).setExpense(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
