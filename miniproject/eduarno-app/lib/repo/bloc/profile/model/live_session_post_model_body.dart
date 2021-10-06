// To parse this JSON data, do
//
//     final liveSessionPostBodyResponse = liveSessionPostBodyResponseFromJson(jsonString);

import 'dart:convert';

LiveSessionPostBodyResponse liveSessionPostBodyResponseFromJson(String str) =>
    LiveSessionPostBodyResponse.fromJson(json.decode(str));

String liveSessionPostBodyResponseToJson(LiveSessionPostBodyResponse data) =>
    json.encode(data.toJson());

class LiveSessionPostBodyResponse {
  LiveSessionPostBodyResponse({
    this.userId,
    this.userAvailableDay,
    this.isAvailable,
  });

  String userId;
  List<UserAvailableDays> userAvailableDay;
  bool isAvailable;

  factory LiveSessionPostBodyResponse.fromJson(Map<String, dynamic> json) =>
      LiveSessionPostBodyResponse(
        userId: json['user_id'],
        userAvailableDay: List<UserAvailableDays>.from(
            json['user_available_day']
                .map((x) => UserAvailableDays.fromJson(x))),
        isAvailable: json['is_available'],
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'user_available_day':
            List<dynamic>.from(userAvailableDay.map((x) => x.toJson())),
        'is_available': isAvailable,
      };
}

class UserAvailableDays {
  UserAvailableDays({
    this.day,
    this.userStartTime,
    this.userEndTime,
  });

  String day;
  String userStartTime;
  String userEndTime;

  factory UserAvailableDays.fromJson(Map<String, dynamic> json) =>
      UserAvailableDays(
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
