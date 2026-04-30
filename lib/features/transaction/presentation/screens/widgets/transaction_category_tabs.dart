import 'package:finance_tracking/core/app_strings/transaction_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/transaction/data/models/transaction_model.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TransactionCategoryTabs extends ConsumerWidget {
  const TransactionCategoryTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> categories = [
      {
        'name': TransactionStrings.all,
        'icon': Icons.all_inclusive,
        'value': 'all',
      },
      {
        'name': TransactionStrings.income,
        'icon': Icons.trending_up,
        'value': 'income',
      },
      {
        'name': TransactionStrings.food,
        'icon': Icons.fastfood,
        'value': Category.food,
      },
      {
        'name': TransactionStrings.market,
        'icon': Icons.shopping_cart,
        'value': Category.market,
      },
      {
        'name': TransactionStrings.transport,
        'icon': Icons.directions_bus,
        'value': Category.transport,
      },
      {
        'name': TransactionStrings.rent,
        'icon': Icons.house,
        'value': Category.rent,
      },
      {
        'name': TransactionStrings.medical,
        'icon': Icons.medical_services,
        'value': Category.medical,
      },
      {
        'name': TransactionStrings.other,
        'icon': Icons.paid_outlined,
        'value': Category.other,
      },
    ];
    final selectedValue = ref.watch(transactionCategoryFilterProvider);

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final categoryValue = category['value'];
          
          final isSelected = (selectedValue == 'all' && categoryValue == 'all') ||
                            (selectedValue == 'income' && categoryValue == 'income') ||
                            (categoryValue is Category && selectedValue == categoryValue.name);

          return GestureDetector(
            onTap: () {
              final newValue = categoryValue is Category ? categoryValue.name : categoryValue.toString();
              ref.read(transactionCategoryFilterProvider.notifier).state = newValue;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.secondCardColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.transparent,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    category['icon'],
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.hintTextColor,
                    size: 20.sp,
                  ),
                  Gap(8.w),
                  Text(
                    category['name'],
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.hintTextColor,
                      fontSize: 14.sp,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
