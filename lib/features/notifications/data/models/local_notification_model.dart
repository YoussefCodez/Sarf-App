import 'package:finance_tracking/features/notifications/domain/entities/notification_entity.dart';

class LocalNotificationModel {
  final String title;
  final String body;
  final DateTime sentAt;

  LocalNotificationModel({
    required this.title,
    required this.body,
    required this.sentAt,
  });

  factory LocalNotificationModel.fromMap(Map<dynamic, dynamic> map) {
    return LocalNotificationModel(
      title: map['title']?.toString() ?? '',
      body: map['body']?.toString() ?? '',
      sentAt:
          DateTime.tryParse(map['sentAt']?.toString() ?? '')?.toUtc() ??
          DateTime.now().toUtc(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'sentAt': sentAt.toUtc().toIso8601String(),
    };
  }

  NotificationEntity toEntity() {
    return NotificationEntity(title: title, body: body, sentAt: sentAt);
  }
}
