import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 5.h,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }
}
