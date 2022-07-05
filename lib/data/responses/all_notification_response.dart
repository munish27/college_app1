import 'package:clg_app/data/entities/notification_entity.dart';

class AllNotificationResponse {
  late int responseCode;
  late List<NotificationEntity> data;

  AllNotificationResponse({required this.responseCode, required this.data});

  AllNotificationResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <NotificationEntity>[];
      json['data'].forEach((v) {
        data.add(NotificationEntity.fromJson(v));
      });
    }
  }
}
