import 'package:finance_tracking/features/notifications/data/models/local_notification_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationHistoryLocalDataSource {
  static const String boxName = 'notifications_box';
  static const String key = 'items';

  final HiveInterface hive;

  NotificationHistoryLocalDataSource(this.hive);

  Future<List<LocalNotificationModel>> getNotifications() async {
    final box = hive.box(boxName);
    final dynamic raw = box.get(key, defaultValue: <dynamic>[]);
    final List<dynamic> list = raw is List ? raw : <dynamic>[];

    return list
        .whereType<Map>()
        .map((item) => LocalNotificationModel.fromMap(item))
        .toList();
  }

  Future<void> addNotification(LocalNotificationModel notification) async {
    final box = hive.box(boxName);
    final dynamic raw = box.get(key, defaultValue: <dynamic>[]);
    final List<dynamic> list = raw is List ? List<dynamic>.from(raw) : <dynamic>[];
    list.insert(0, notification.toMap());
    await box.put(key, list);
  }
}
