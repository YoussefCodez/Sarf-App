import 'package:finance_tracking/features/notifications/domain/entities/notification_entity.dart';

sealed class NotificationHistoryState {}

class NotificationHistoryInitial extends NotificationHistoryState {}

class NotificationHistoryLoading extends NotificationHistoryState {}

class NotificationHistorySuccess extends NotificationHistoryState {
  final List<NotificationEntity> notifications;

  NotificationHistorySuccess(this.notifications);
}

class NotificationHistoryError extends NotificationHistoryState {
  final String error;

  NotificationHistoryError(this.error);
}
