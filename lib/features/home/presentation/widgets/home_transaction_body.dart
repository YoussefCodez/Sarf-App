import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/widgets/icon_with_background.dart';
import 'package:finance_tracking/core/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeTransactionBody extends StatelessWidget {
  const HomeTransactionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 5,
      itemBuilder: (context, index) {
        return MainCard(
          title: "Burger",
          subTitle: "2 Hours Ago",
          subTitleFontSize: 18,
          leading: IconWithBackGround(
            icon: Icons.fastfood,
            backgroundColor: AppColors.greyIconBackgroundColor,
            iconColor: AppColors.whiteColor,
            iconSize: 24,
          ),
          trailing: Text(
            "200 EGP",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.tertiaryColor,
              fontSize: 20.sp,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Gap(16.h);
      },
    );
  }
}
