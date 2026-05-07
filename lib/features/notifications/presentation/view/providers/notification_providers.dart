import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/check_streak_and_notify_use_case.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/schedule_daily_evening_notification_use_case.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/schedule_daily_morning_notification_use_case.dart';
import 'package:finance_tracking/features/notifications/presentation/view/notifiers/notification_notifier.dart';
import 'package:flutter_riverpod/legacy.dart';

final notificationProvider = StateNotifierProvider<NotificationNotifier, void>((ref) {
  return NotificationNotifier(
    getIt<ScheduleDailyMorningNotificationUseCase>(),
    getIt<ScheduleDailyEveningNotificationUseCase>(),
    getIt<CheckStreakAndNotifyUseCase>(),
  );
});
