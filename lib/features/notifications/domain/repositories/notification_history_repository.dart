import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationHistoryRepository {
  Future<Either<String, List<NotificationEntity>>> getNotifications();
  Stream<List<NotificationEntity>> watchNotifications();
}
