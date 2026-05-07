import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/notifications/data/datasources/notification_history_local_data_source.dart';
import 'package:finance_tracking/features/notifications/domain/entities/notification_entity.dart';
import 'package:finance_tracking/features/notifications/domain/repositories/notification_history_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationHistoryRepository)
class NotificationHistoryRepositoryImpl implements NotificationHistoryRepository {
  final NotificationHistoryLocalDataSource localDataSource;

  NotificationHistoryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<String, List<NotificationEntity>>> getNotifications() async {
    try {
      final items = await localDataSource.getNotifications();
      return Right(items.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left('Failed to load notifications: ${e.toString()}');
    }
  }

  @override
  Stream<List<NotificationEntity>> watchNotifications() {
    return localDataSource.watchNotifications().map(
          (items) => items.map((e) => e.toEntity()).toList(),
        );
  }
}
