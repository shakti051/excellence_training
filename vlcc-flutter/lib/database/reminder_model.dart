// To parse this JSON data, do
//
//     final reminderModel = reminderModelFromJson(jsonString);

import 'dart:convert';

ReminderModel reminderModelFromJson(String str) =>
    ReminderModel.fromJson(json.decode(str));

String reminderModelToJson(ReminderModel data) => json.encode(data.toJson());

class ReminderModel {
  ReminderModel({
    this.id,
    required this.title,
    required this.reminderDateTime,
  });

  int? id;
  String title;
  String reminderDateTime;

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
        id: json["id"],
        title: json["title"],
        reminderDateTime: json["reminderDateTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "reminderDateTime": reminderDateTime,
      };
}
