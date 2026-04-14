import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      AppColors.primaryColor,
      AppColors.backgroundColor,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}