import 'package:dartz/dartz.dart';
import 'package:finance_tracking/core/app_strings/notification_strings.dart';
import 'package:finance_tracking/features/notifications/domain/repositories/notification_repository.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/schedule_daily_evening_notification_use_case.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/schedule_daily_morning_notification_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNotificationRepository implements NotificationRepository {
  int? scheduledId;
  String? scheduledTitle;
  String? scheduledBody;
  int? scheduledHour;
  int? scheduledMinute;
  Either<String, void> scheduleResponse = const Right(null);

  @override
  Future<Either<String, void>> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    scheduledId = id;
    scheduledTitle = title;
    scheduledBody = body;
    scheduledHour = hour;
    scheduledMinute = minute;
    return scheduleResponse;
  }

  @override
  Future<Either<String, void>> cancelNotification(int id) async {
    return const Right(null);
  }

  @override
  Future<Either<String, void>> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    return const Right(null);
  }
}

void main() {
  test('ScheduleDailyMorningNotificationUseCase sends expected payload', () async {
    final repository = FakeNotificationRepository();
    final useCase = ScheduleDailyMorningNotificationUseCase(repository);

    final result = await useCase();

    expect(result, const Right(null));
    expect(repository.scheduledId, 101);
    expect(repository.scheduledTitle, NotificationStrings.morningTitle);
    expect(repository.scheduledBody, NotificationStrings.morningBody);
    expect(repository.scheduledHour, 9);
    expect(repository.scheduledMinute, 0);
  });

  test('ScheduleDailyEveningNotificationUseCase sends expected payload', () async {
    final repository = FakeNotificationRepository();
    final useCase = ScheduleDailyEveningNotificationUseCase(repository);

    final result = await useCase();

    expect(result, const Right(null));
    expect(repository.scheduledId, 102);
    expect(repository.scheduledTitle, NotificationStrings.eveningTitle);
    expect(repository.scheduledBody, NotificationStrings.eveningBody);
    expect(repository.scheduledHour, 20);
    expect(repository.scheduledMinute, 0);
  });
}
