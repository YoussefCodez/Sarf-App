import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String svgPath;
  final Color bgColor;
  final Color iconBgColor;
  final Color textColor;
  const InfoCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.svgPath,
    required this.bgColor,
    this.iconBgColor = AppColors.greyIconBackgroundColor,
    this.textColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: SvgPicture.asset(svgPath, height: 24.h, width: 24.w),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    color: textColor,
                  ),
                ),
                Text(
                  subTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
