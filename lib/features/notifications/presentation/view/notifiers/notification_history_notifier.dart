import 'dart:async';
import 'package:finance_tracking/features/notifications/domain/usecases/get_notifications_use_case.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/watch_notifications_use_case.dart';
import 'package:finance_tracking/features/notifications/presentation/view/intents/notification_history_intents.dart';
import 'package:finance_tracking/features/notifications/presentation/view/states/notification_history_states.dart';
import 'package:flutter_riverpod/legacy.dart';

class NotificationHistoryNotifier extends StateNotifier<NotificationHistoryState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final WatchNotificationsUseCase watchNotificationsUseCase;
  StreamSubscription? _subscription;

  NotificationHistoryNotifier({
    required this.getNotificationsUseCase,
    required this.watchNotificationsUseCase,
  }) : super(NotificationHistoryInitial()) {
    _listenToNotifications();
  }

  void _listenToNotifications() {
    _subscription?.cancel();
    try {
      _subscription = watchNotificationsUseCase().listen(
        (items) {
          state = NotificationHistorySuccess(items);
        },
        onError: (error) {
          state = NotificationHistoryError(error.toString());
        },
      );
    } catch (e) {
      state = NotificationHistoryError(e.toString());
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> handleIntent(NotificationHistoryIntent intent) async {
    if (intent is GetNotificationsIntent) {
      state = NotificationHistoryLoading();
      final result = await getNotificationsUseCase();
      result.fold(
        (error) => state = NotificationHistoryError(error),
        (items) => state = NotificationHistorySuccess(items),
      );
    }
  }
}
