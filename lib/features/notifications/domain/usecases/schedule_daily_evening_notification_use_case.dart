import 'package:dartz/dartz.dart';
import 'package:finance_tracking/core/app_config/notification_config.dart';
import 'package:finance_tracking/core/app_strings/notification_strings.dart';
import 'package:finance_tracking/features/notifications/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ScheduleDailyEveningNotificationUseCase {
  final NotificationRepository _repository;

  ScheduleDailyEveningNotificationUseCase(this._repository);

  Future<Either<String, void>> call() async {
    return _repository.scheduleDailyNotification(
      id: 102,
      title: NotificationStrings.eveningTitle,
      body: NotificationStrings.eveningBody,
      hour: NotificationConfig.eveningHour,
      minute: NotificationConfig.eveningMinute,
    );
  }
}
