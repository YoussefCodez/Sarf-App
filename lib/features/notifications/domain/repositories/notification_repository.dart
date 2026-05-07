import 'package:dartz/dartz.dart';

abstract class NotificationRepository {
  Future<Either<String, void>> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  });

  Future<Either<String, void>> showInstantNotification({
    required int id,
    required String title,
    required String body,
  });

  Future<Either<String, void>> cancelNotification(int id);
}
