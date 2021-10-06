// To parse this JSON data, do
//
//     final notificationResultResponse = notificationResultResponseFromJson(jsonString);

import 'dart:convert';

NotificationResultResponse notificationResultResponseFromJson(String str) =>
    NotificationResultResponse.fromJson(json.decode(str));

String notificationResultResponseToJson(NotificationResultResponse data) =>
    json.encode(data.toJson());

class NotificationResultResponse {
  NotificationResultResponse({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<Datum> data;
  int code;

  factory NotificationResultResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResultResponse(
        message: json['message'],
        data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
        'code': code,
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.requestId,
    this.from,
    this.type,
    this.notification,
    this.isRead,
    this.createdAt,
    this.assessmentId,
  });

  String id;
  String userId;
  String requestId;
  String from;
  String type;
  String notification;
  bool isRead;
  int createdAt;
  String assessmentId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['_id'],
        userId: json['user_id'],
        requestId: json['request_id'] == null ? null : json['request_id'],
        from: json['from'],
        type: json['type'],
        notification: json['notification'],
        isRead: json['is_read'],
        createdAt: json['created_at'],
        assessmentId:
            json['assessment_id'] == null ? null : json['assessment_id'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user_id': userId,
        'request_id': requestId == null ? null : requestId,
        'from': from,
        'type': type,
        'notification': notification,
        'is_read': isRead,
        'created_at': createdAt,
        'assessment_id': assessmentId == null ? null : assessmentId,
      };
}
