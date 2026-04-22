import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static ThemeData get theme => ThemeData(
    brightness: .dark,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    fontFamily: "Main",
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.secondCardColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontWeight: .bold,
        fontSize: 28.sp,
        color: AppColors.whiteColor,
      ),
      bodySmall: TextStyle(
        fontWeight: .w500,
        fontSize: 16.sp,
        color: AppColors.subTitleColor,
      ),
      labelMedium: TextStyle(
        fontSize: 18.sp,
        color: AppColors.darkGreen,
        fontWeight: .bold,
      ),
      labelSmall: TextStyle(
        fontSize: 16.sp,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: REdgeInsets.symmetric(vertical: 12.h),
        minimumSize: Size(double.infinity, 50.h),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.onBackGroundColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.transparent),
      ),
    ),
  );
}
