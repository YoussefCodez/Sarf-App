import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;

  const TransactionTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      cursorColor: AppColors.primaryColor,
      cursorHeight: 30.h,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.whiteColor,
            fontSize: 18.sp,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.hintTextColor,
              fontSize: 18.sp,
            ),
        filled: true,
        fillColor: AppColors.secondCardColor,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
        ),
        contentPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
