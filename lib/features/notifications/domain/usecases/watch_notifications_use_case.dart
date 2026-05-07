import 'package:finance_tracking/features/notifications/domain/entities/notification_entity.dart';
import 'package:finance_tracking/features/notifications/domain/repositories/notification_history_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchNotificationsUseCase {
  final NotificationHistoryRepository repository;

  WatchNotificationsUseCase({required this.repository});

  Stream<List<NotificationEntity>> call() {
    return repository.watchNotifications();
  }
}
