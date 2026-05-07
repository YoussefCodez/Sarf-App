import 'package:finance_tracking/features/notifications/domain/usecases/get_notifications_use_case.dart';
import 'package:finance_tracking/features/notifications/presentation/view/intents/notification_history_intents.dart';
import 'package:finance_tracking/features/notifications/presentation/view/states/notification_history_states.dart';
import 'package:flutter_riverpod/legacy.dart';

class NotificationHistoryNotifier extends StateNotifier<NotificationHistoryState> {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationHistoryNotifier({required this.getNotificationsUseCase})
    : super(NotificationHistoryInitial());

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
