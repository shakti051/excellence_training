// To parse this JSON data, do
//
//     final appointServiceCodeModel = appointServiceCodeModelFromJson(jsonString);
import 'dart:convert';

AppointServiceCodeModel appointServiceCodeModelFromJson(String str) =>
    AppointServiceCodeModel.fromJson(json.decode(str));

String appointServiceCodeModelToJson(AppointServiceCodeModel data) =>
    json.encode(data.toJson());

class AppointServiceCodeModel {
  AppointServiceCodeModel({
    this.status,
    this.message,
    this.appointmentDetails,
  });

  int? status;
  String? message;
  AppointmentDetails? appointmentDetails;

  factory AppointServiceCodeModel.fromJson(Map<String, dynamic> json) =>
      AppointServiceCodeModel(
        status: json["Status"],
        message: json["Message"],
        appointmentDetails:
            AppointmentDetails.fromJson(json["AppointmentDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "AppointmentDetails": appointmentDetails?.toJson(),
      };
}

class AppointmentDetails {
  AppointmentDetails({
    this.appointmentRefNo,
  });

  String? appointmentRefNo;

  factory AppointmentDetails.fromJson(Map<String, dynamic> json) =>
      AppointmentDetails(
        appointmentRefNo: json["AppointmentRefNo"],
      );

  Map<String, dynamic> toJson() => {
        "AppointmentRefNo": appointmentRefNo,
      };
}
