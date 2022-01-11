// To parse this JSON data, do
//
//     final vlccReminderModel = vlccReminderModelFromJson(jsonString);

import 'dart:convert';

VlccReminderModel vlccReminderModelFromJson(String str) =>
    VlccReminderModel.fromJson(json.decode(str));

String vlccReminderModelToJson(VlccReminderModel data) =>
    json.encode(data.toJson());

class VlccReminderModel {
  VlccReminderModel({
    this.id,
    this.appointmentIndex,
    this.timeSchedule = 10,
    this.reminderTitle = 'Vlcc',
    this.reminderDescription = 'Beauty is of the essence',
    this.isSet = 0,
    this.insertTime = 0,
    this.reminderTriggerTime = 0,
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.appointmentDateSecond = 0,
    this.appointmentType = 0,
    this.appointmentId = 0,
  });

  int? id;
  int? appointmentIndex;
  int timeSchedule;
  String reminderTitle;
  String reminderDescription;
  String addressLine1;
  String addressLine2;
  int appointmentDateSecond;
  int isSet;
  int insertTime;
  int reminderTriggerTime;
  int appointmentType;
  int appointmentId;

  factory VlccReminderModel.fromJson(Map<String, dynamic> json) =>
      VlccReminderModel(
        id: json["id"],
        appointmentIndex: json['appointment_index'],
        timeSchedule: json["time_schedule"],
        reminderTitle: json["reminder_title"],
        reminderDescription: json["reminder_description"],
        isSet: json["is_set"],
        insertTime: json["insert_time"],
        reminderTriggerTime: json["reminder_trigger_time"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        appointmentDateSecond: json["appointment_date_second"],
        appointmentType: json["appointment_type"],
        appointmentId: json["appointment_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appointment_index": appointmentIndex,
        "time_schedule": timeSchedule,
        "reminder_title": reminderTitle,
        "reminder_description": reminderDescription,
        "is_set": isSet,
        "insert_time": insertTime,
        "reminder_trigger_time": reminderTriggerTime,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "appointment_date_second": appointmentDateSecond,
        "appointment_type": appointmentType,
        "appointment_id": appointmentId,
      };
}
