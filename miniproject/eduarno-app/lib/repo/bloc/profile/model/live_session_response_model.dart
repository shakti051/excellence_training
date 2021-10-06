// To parse this JSON data, do
//
//     final liveSessionResponse = liveSessionResponseFromJson(jsonString);

import 'dart:convert';

liveSessionResponseFromJson(String str) =>
    LiveSessionResponse.fromJson(json.decode(str));

String liveSessionResponseToJson(LiveSessionResponse data) =>
    json.encode(data.toJson());

class LiveSessionResponse {
  LiveSessionResponse({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<Datum> data;
  int code;

  factory LiveSessionResponse.fromJson(Map<String, dynamic> json) =>
      LiveSessionResponse(
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
    this.userAvailableDay,
    this.isAvailable,
    this.createdAt,
  });

  String id;
  String userId;
  List<UserAvailableDay> userAvailableDay;
  bool isAvailable;
  int createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['_id'],
        userId: json['user_id'],
        userAvailableDay: List<UserAvailableDay>.from(json['user_available_day']
            .map((x) => UserAvailableDay.fromJson(x))),
        isAvailable: json['is_available'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user_id': userId,
        'user_available_day':
            List<dynamic>.from(userAvailableDay.map((x) => x.toJson())),
        'is_available': isAvailable,
        'created_at': createdAt,
      };
}

class UserAvailableDay {
  UserAvailableDay({
    this.day,
    this.userStartTime,
    this.userEndTime,
  });

  String day;
  String userStartTime;
  String userEndTime;

  factory UserAvailableDay.fromJson(Map<String, dynamic> json) =>
      UserAvailableDay(
        day: json['day'],
        userStartTime: json['user_start_time'],
        userEndTime: json['user_end_time'],
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'user_start_time': userStartTime,
        'user_end_time': userEndTime,
      };
}
