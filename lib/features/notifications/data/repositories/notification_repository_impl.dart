import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/services/notifications_service.dart';
import 'package:finance_tracking/features/notifications/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _notificationService;

  NotificationRepositoryImpl(this._notificationService);

  @override
  Future<Either<String, void>> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    try {
      await _notificationService.scheduleDailyNotification(
        id: id,
        title: title,
        body: body,
        hour: hour,
        minute: minute,
      );
      return const Right(null);
    } catch (e) {
      return Left('Failed to schedule daily notification: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      await _notificationService.showNotification(
        id: id,
        title: title,
        body: body,
      );
      return const Right(null);
    } catch (e) {
      return Left('Failed to show instant notification: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> cancelNotification(int id) async {
    try {
      await _notificationService.cancelNotification(id);
      return const Right(null);
    } catch (e) {
      return Left('Failed to cancel notification: ${e.toString()}');
    }
  }
}
