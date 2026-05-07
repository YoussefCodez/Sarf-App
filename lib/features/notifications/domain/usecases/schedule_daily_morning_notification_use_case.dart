import 'package:dartz/dartz.dart';
import 'package:finance_tracking/core/app_strings/notification_strings.dart';
import 'package:finance_tracking/features/notifications/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ScheduleDailyMorningNotificationUseCase {
  final NotificationRepository _repository;

  ScheduleDailyMorningNotificationUseCase(this._repository);

  Future<Either<String, void>> call() async {
    return _repository.scheduleDailyNotification(
      id: 101,
      title: NotificationStrings.morningTitle,
      body: NotificationStrings.morningBody,
      hour: 9,
      minute: 0,
    );
  }
}
