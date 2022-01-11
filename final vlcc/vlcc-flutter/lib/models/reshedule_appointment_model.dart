// To parse this JSON data, do
//
//     final resheduleAppointmentModel = resheduleAppointmentModelFromJson(jsonString);

import 'dart:convert';

ResheduleAppointmentModel resheduleAppointmentModelFromJson(String str) =>
    ResheduleAppointmentModel.fromJson(json.decode(str));

String resheduleAppointmentModelToJson(ResheduleAppointmentModel data) =>
    json.encode(data.toJson());

class ResheduleAppointmentModel {
  ResheduleAppointmentModel({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory ResheduleAppointmentModel.fromJson(Map<String, dynamic> json) =>
      ResheduleAppointmentModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
