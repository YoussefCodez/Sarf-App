import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/app_strings/home_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/widgets/info_card.dart';
import 'package:finance_tracking/features/daily_advice/presentation/providers/daily_advice_provider.dart';
import 'package:finance_tracking/features/get_goal/presentation/view/providers/get_goal_provider.dart';
import 'package:finance_tracking/features/get_goal/presentation/view/states/get_goal_states.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/providers/get_profile_provider.dart';
import 'package:finance_tracking/features/home/presentation/widgets/custom_header.dart';
import 'package:finance_tracking/features/home/presentation/widgets/goal_tracker_widget.dart';
import 'package:finance_tracking/features/home/presentation/widgets/home_transaction_body.dart';
import 'package:finance_tracking/features/home/presentation/widgets/home_transaction_header.dart';
import 'package:finance_tracking/core/widgets/custom_toast.dart';
import 'package:finance_tracking/features/transaction/presentation/view/intents/transaction_intents.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/add_transaction_state.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/get_transaction_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getProfileProvider.notifier).getProfile();
      ref.read(getGoalProvider.notifier).getGoal();
      ref
          .read(getTransactionProvider.notifier)
          .handleIntent(GetTransactionsIntent(limit: 5));
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addTransactionProvider, (previous, next) {
      if (next is AddTransactionSuccess) {
        ref
            .read(getTransactionProvider.notifier)
            .handleIntent(AddTransactionLocallyIntent(next.transaction));
      }
    });

    ref.listen(getGoalProvider, (previous, next) {
      if (next is GetGoalError) {
        CustomToast.show(
          context: context,
          message: next.error,
          type: ToastType.error,
        );
      }
    });
    ref.listen(getTransactionProvider, (previous, next) {
      if (next is GetTransactionError) {
        CustomToast.show(
          context: context,
          message: next.error,
          type: ToastType.error,
        );
      }
    });
    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: () async {
        ref.read(getProfileProvider.notifier).getProfile();
        ref.read(getGoalProvider.notifier).getGoal();
        ref
            .read(getTransactionProvider.notifier)
            .handleIntent(GetTransactionsIntent(limit: 5));
      },
      child: Scaffold(
        appBar: AppBar(
          // leading: Padding(
          //   padding: REdgeInsets.all(8.0),
          //   child: CircleAvatar(
          //     backgroundColor: AppColors.greyIconBackgroundColor,
          //     child: Icon(Icons.person, color: AppColors.whiteColor, size: 20.sp),
          //   ),
          // ),
          title: Text(
            HomeStrings.sarf,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.primaryColor,
              fontSize: 24.sp,
            ),
          ),
          titleSpacing: 20.w,
          actions: [
            Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  "3",
                  textAlign: .center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 20.sp,
                    fontStyle: .italic,
                  ),
                ),
                Gap(4.w),
                Icon(
                  Icons.local_fire_department,
                  color: AppColors.secondaryColor,
                  size: 24.sp,
                ),
              ],
            ),
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
                    Consumer(
                      builder: (context, ref, child) {
                        final advice = ref.watch(dailyAdviceProvider);
                        return InfoCard(
                          title: "Advice",
                          subTitle: advice,
                          bgColor: AppColors.primaryColor.withValues(alpha: 0.2),
                          svgPath: AppSvgs.lamp,
                          iconBgColor: AppColors.primaryColor,
                          textColor: AppColors.whiteColor,
                          svgColor: AppColors.whiteColor,
                        );
                      },
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
      ),
    );
  }
}
