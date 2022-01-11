// To parse this JSON data, do
//
//     final cancelAppointmentModel = cancelAppointmentModelFromJson(jsonString);

import 'dart:convert';

CancelAppointmentModel cancelAppointmentModelFromJson(String str) =>
    CancelAppointmentModel.fromJson(json.decode(str));

String cancelAppointmentModelToJson(CancelAppointmentModel data) =>
    json.encode(data.toJson());

class CancelAppointmentModel {
  CancelAppointmentModel({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory CancelAppointmentModel.fromJson(Map<String, dynamic> json) =>
      CancelAppointmentModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
