import 'package:finance_tracking/core/app_strings/analytics_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/analytics/domain/entities/analytics_period.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalyticsPeriodSelector extends StatelessWidget {
  final AnalyticsPeriod selectedPeriod;
  final Function(AnalyticsPeriod) onPeriodChanged;

  const AnalyticsPeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: REdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: _getAlignment(),
            child: Container(
              width: (MediaQuery.of(context).size.width - 40.w) / 3,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: AnalyticsPeriod.values.map((period) {
              final isSelected = selectedPeriod == period;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onPeriodChanged(period),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.greyTextColor,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      child: Text(_getLabel(period)),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Alignment _getAlignment() {
    switch (selectedPeriod) {
      case AnalyticsPeriod.day:
        return Alignment.centerLeft;
      case AnalyticsPeriod.week:
        return Alignment.center;
      case AnalyticsPeriod.month:
        return Alignment.centerRight;
    }
  }

  String _getLabel(AnalyticsPeriod period) {
    switch (period) {
      case AnalyticsPeriod.day:
        return AnalyticsStrings.day;
      case AnalyticsPeriod.week:
        return AnalyticsStrings.week;
      case AnalyticsPeriod.month:
        return AnalyticsStrings.month;
    }
  }
}
