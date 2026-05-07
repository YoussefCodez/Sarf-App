import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/analytics/domain/entities/daily_analytics_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalyticsChartCard extends StatelessWidget {
  final DailyAnalyticsEntity dailyAnalyticsEntity;

  const AnalyticsChartCard({super.key, required this.dailyAnalyticsEntity});

  @override
  Widget build(BuildContext context) {
    final categories = dailyAnalyticsEntity.categoryExpenses.keys.toList();
    final values = dailyAnalyticsEntity.categoryExpenses.values.toList();
    final maxValue = values.isEmpty ? 0.0 : values.reduce((a, b) => a > b ? a : b);
    final maxY = maxValue == 0 ? 100.0 : maxValue + (maxValue * 0.25);

    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 18.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SizedBox(
        height: 280.h,
        child: BarChart(
          BarChartData(
            maxY: maxY,
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: maxY / 4,
              getDrawingHorizontalLine: (_) => FlLine(
                color: AppColors.greyIconBackgroundColor,
                strokeWidth: 1.w,
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28.h,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= categories.length) {
                      return const SizedBox.shrink();
                    }
                    final label = categories[index];
                    final displayLabel = label.length > 8 
                        ? '${label.substring(0, 6)}…' 
                        : label;
                    return Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Text(
                        displayLabel,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '${categories[group.x]}: ${rod.toY.toStringAsFixed(0)}',
                    TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  );
                },
              ),
            ),
            barGroups: List.generate(values.length, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: values[index],
                    width: 20.w,
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(6.r),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: AppColors.onScreenColor.withValues(alpha: 0.35),
                    ),
                  ),
                ],
              );
            }),
          ),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutBack,
        ),
      ),
    );
  }
}
