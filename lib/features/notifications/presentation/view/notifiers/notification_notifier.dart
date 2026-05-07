import 'package:finance_tracking/features/notifications/domain/usecases/check_streak_and_notify_use_case.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/schedule_daily_evening_notification_use_case.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/schedule_daily_morning_notification_use_case.dart';
import 'package:flutter_riverpod/legacy.dart';

class NotificationNotifier extends StateNotifier<void> {
  final ScheduleDailyMorningNotificationUseCase _morningUseCase;
  final ScheduleDailyEveningNotificationUseCase _eveningUseCase;
  final CheckStreakAndNotifyUseCase _streakUseCase;

  NotificationNotifier(
    this._morningUseCase,
    this._eveningUseCase,
    this._streakUseCase,
  ) : super(null);

  Future<void> scheduleAllReminders() async {
    await _morningUseCase();
    await _eveningUseCase();
    await _streakUseCase();
  }
}
