import 'package:finance_tracking/core/app_strings/notification_strings.dart';
import 'package:finance_tracking/features/notifications/data/datasources/notification_history_local_data_source.dart';
import 'package:finance_tracking/features/notifications/data/models/local_notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

@lazySingleton
class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final HiveInterface _hive;
  final NotificationHistoryLocalDataSource _historyDataSource;

  NotificationService(this._hive, this._historyDataSource);

  Future<void> init() async {
    // Initialize timezone data
    tz_data.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // Android initialization settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    // iOS initialization settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
      },
    );

    await requestPermissions();
    await _runNotificationHistoryMigration();
  }

  Future<void> requestPermissions() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      NotificationStrings.generalChannelId,
      NotificationStrings.generalChannelName,
      channelDescription: NotificationStrings.generalChannelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: payload,
    );

    await _saveNotificationToHistory(title: title, body: body);
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: _nextInstanceOfTime(hour, minute),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationStrings.dailyChannelId,
          NotificationStrings.dailyChannelName,
          channelDescription: NotificationStrings.dailyChannelDesc,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _saveNotificationToHistory({
    required String title,
    required String body,
  }) async {
    await _historyDataSource.addNotification(
      LocalNotificationModel(
        title: title,
        body: body,
        sentAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<void> _runNotificationHistoryMigration() async {
    final settingsBox = _hive.box('settings_box');
    const migrationKey = 'notifications_history_migration_v1';
    final alreadyMigrated = settingsBox.get(migrationKey, defaultValue: false) == true;
    if (alreadyMigrated) return;

    final notificationsBox = _hive.box(NotificationHistoryLocalDataSource.boxName);
    await notificationsBox.put(NotificationHistoryLocalDataSource.key, <dynamic>[]);
    await settingsBox.put(migrationKey, true);
  }
}
