import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:finance_tracking/core/app_strings/on_boarding_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SelectGoalPhoto extends StatelessWidget {
  const SelectGoalPhoto({
    super.key,
    required this.onTap,
    this.imagePath,
  });

  final VoidCallback onTap;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: AppColors.greyIconBackgroundColor,
          strokeWidth: 1.w,
          dashPattern: [10.w, 10.w],
          strokeCap: StrokeCap.round,
          radius: Radius.circular(20.r),
        ),
        child: Container(
          width: double.infinity,
          height: 350.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.onBackGroundColor,
          ),
          child: imagePath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.file(
                    File(imagePath!),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 350.h,
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 50.r,
                        color: AppColors.primaryColor,
                      ),
                      Gap(20.h),
                      Text(
                        OnBoardingStrings.addPhotoForYourGoal,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}