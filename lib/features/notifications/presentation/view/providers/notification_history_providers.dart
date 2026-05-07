import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/get_notifications_use_case.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/watch_notifications_use_case.dart';
import 'package:finance_tracking/features/notifications/presentation/view/notifiers/notification_history_notifier.dart';
import 'package:finance_tracking/features/notifications/presentation/view/states/notification_history_states.dart';
import 'package:flutter_riverpod/legacy.dart';

final notificationHistoryProvider =
    StateNotifierProvider<NotificationHistoryNotifier, NotificationHistoryState>((ref) {
      return NotificationHistoryNotifier(
        getNotificationsUseCase: getIt<GetNotificationsUseCase>(),
        watchNotificationsUseCase: getIt<WatchNotificationsUseCase>(),
      );
    });
