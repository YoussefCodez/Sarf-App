import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionSearchField extends ConsumerWidget {
  const TransactionSearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
      style: TextStyle(color: AppColors.whiteColor, fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: 'Search transactions...',
        hintStyle: TextStyle(color: AppColors.hintTextColor, fontSize: 16.sp),
        prefixIcon: Icon(Icons.search, color: AppColors.hintTextColor, size: 24.sp),
        filled: true,
        fillColor: AppColors.secondCardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      ),
    );
  }
}
