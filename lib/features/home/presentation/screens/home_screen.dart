import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/app_strings/home_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/widgets/icon_with_background.dart';
import 'package:finance_tracking/core/widgets/main_card.dart';
import 'package:finance_tracking/features/home/presentation/widgets/custom_header.dart';
import 'package:finance_tracking/features/home/presentation/widgets/goal_tracker_widget.dart';
import 'package:finance_tracking/features/home/presentation/widgets/home_transaction_body.dart';
import 'package:finance_tracking/features/home/presentation/widgets/home_transaction_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: REdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.greyIconBackgroundColor,
            child: Icon(Icons.person, color: AppColors.whiteColor, size: 20.sp),
          ),
        ),
        title: Text(
          HomeStrings.sarf,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.primaryColor,
            fontSize: 24.sp,
          ),
        ),
        titleSpacing: 4.w,
        actions: [
          IconButton(
            onPressed: () {
              //TODO: Navigate to notifications screen
            },
            icon: Icon(
              Icons.notifications,
              color: AppColors.whiteColor,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: REdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  CustomHeader()
                      .animate()
                      .fadeIn(duration: Duration(milliseconds: 600))
                      .slideY(
                        begin: 0.1,
                        duration: Duration(milliseconds: 600),
                      ),
                  Gap(24.h),
                  GoalTrackerWidget()
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 200),
                        duration: Duration(milliseconds: 600),
                      )
                      .slideY(
                        begin: 0.1,
                        duration: Duration(milliseconds: 600),
                      ),
                  Gap(24.h),
                  MainCard(
                        title: HomeStrings.discpline,
                        subTitle: "3 ${HomeStrings.daysInARow}",
                        leading: IconWithBackGround(
                          icon: Icons.local_fire_department,
                          backgroundColor: AppColors.secondaryColor.withValues(
                            alpha: 0.2,
                          ),
                          iconColor: AppColors.secondaryColor,
                        ),
                        svg: AppSvgs.streakBadge,
                      )
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 400),
                        duration: Duration(milliseconds: 600),
                      )
                      .slideY(
                        begin: 0.1,
                        duration: Duration(milliseconds: 600),
                      ),
                  Gap(24.h),
                  HomeTransactionHeader()
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 600),
                        duration: Duration(milliseconds: 600),
                      )
                      .slideY(
                        begin: 0.1,
                        duration: Duration(milliseconds: 600),
                      ),
                  Gap(16.h),
                ],
              ),
            ),
            HomeTransactionBody(),
            SliverToBoxAdapter(child: Gap(100.h)),
          ],
        ),
      ),
    );
  }
}
