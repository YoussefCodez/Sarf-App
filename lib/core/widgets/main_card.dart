import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leading,
    this.subTitleFontSize = 24,
    this.trailing,
    this.svg = "",
  });

  final String title;
  final String subTitle;
  final String svg;
  final double subTitleFontSize;
  final Widget leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondCardColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          leading,
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodySmall),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: subTitleFontSize.sp,
                  ),
                ),
              ],
            ),
          ),
          if (svg.isNotEmpty) SvgPicture.asset(svg, width: 48.w, height: 40.h),
          trailing ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
