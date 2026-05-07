import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/notifications/domain/entities/notification_entity.dart';
import 'package:finance_tracking/features/notifications/domain/repositories/notification_history_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetNotificationsUseCase {
  final NotificationHistoryRepository repository;

  GetNotificationsUseCase({required this.repository});

  Future<Either<String, List<NotificationEntity>>> call() async {
    return repository.getNotifications();
  }
}
