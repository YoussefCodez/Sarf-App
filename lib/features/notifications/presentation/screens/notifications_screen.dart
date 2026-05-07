import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/notifications/presentation/view/intents/notification_history_intents.dart';
import 'package:finance_tracking/features/notifications/presentation/view/providers/notification_history_providers.dart';
import 'package:finance_tracking/features/notifications/presentation/view/states/notification_history_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationHistoryProvider.notifier).handleIntent(
            GetNotificationsIntent(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (state is NotificationHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NotificationHistoryError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: AppColors.whiteColor),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state is NotificationHistorySuccess) {
              if (state.notifications.isEmpty) {
                return const Center(
                  child: Text(
                    'No notifications yet',
                    style: TextStyle(color: AppColors.subTitleColor, fontSize: 16),
                  ),
                );
              }

              return RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () async {
                  await ref
                      .read(notificationHistoryProvider.notifier)
                      .handleIntent(GetNotificationsIntent());
                },
                child: ListView.separated(
                  padding: REdgeInsets.fromLTRB(16, 12, 16, 120),
                  itemCount: state.notifications.length,
                  separatorBuilder: (_, _) => Gap(10.h),
                  itemBuilder: (context, index) {
                    final item = state.notifications[index];
                    final sentAt = DateFormat('dd MMM yyyy, hh:mm a').format(
                      item.sentAt.toLocal(),
                    );

                    return Container(
                      padding: REdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.secondCardColor,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                            ),
                          ),
                          Gap(6.h),
                          Text(
                            item.body,
                            style: TextStyle(
                              color: AppColors.subTitleColor,
                              fontSize: 13.sp,
                            ),
                          ),
                          Gap(10.h),
                          Text(
                            sentAt,
                            style: TextStyle(
                              color: AppColors.hintTextColor,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
