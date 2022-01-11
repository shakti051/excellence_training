// To parse this JSON data, do
//
//     final appointmentExpertModel = appointmentExpertModelFromJson(jsonString);

import 'dart:convert';

AppointmentExpertModel appointmentExpertModelFromJson(String str) =>
    AppointmentExpertModel.fromJson(json.decode(str));

String appointmentExpertModelToJson(AppointmentExpertModel data) =>
    json.encode(data.toJson());

class AppointmentExpertModel {
  AppointmentExpertModel({
    this.status,
    this.message,
    this.appointmentexpertDetails,
  });

  int? status;
  String? message;
  List<AppointmentexpertDetail>? appointmentexpertDetails;

  factory AppointmentExpertModel.fromJson(Map<String, dynamic> json) =>
      AppointmentExpertModel(
        status: json["Status"],
        message: json["Message"],
        appointmentexpertDetails: List<AppointmentexpertDetail>.from(
            json["AppointmentexpertDetails"]
                .map((x) => AppointmentexpertDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "AppointmentexpertDetails": List<dynamic>.from(
            appointmentexpertDetails!.map((x) => x.toJson())),
      };
}

class AppointmentexpertDetail {
  AppointmentexpertDetail({
    this.appointmentId,
    this.bookingId,
    this.centerName,
    this.centerCode,
    this.clientId,
    this.clientname,
    this.bookingNumber,
    this.appointmentDate,
    this.appointmentStartTime,
    this.appointmentStartDateTime,
    this.appointmentEndTime,
    this.appointmentEndDateTime,
    this.appointmentRemark,
    this.appointmentAttDoc,
    this.appointmentStatus,
    this.appointmentType,
    this.appointmentServiceexpertDtl,
  });

  String? appointmentId;
  String? bookingId;
  String? centerName;
  String? centerCode;
  String? clientId;
  String? clientname;
  String? bookingNumber;
  String? appointmentDate;
  String? appointmentStartTime;
  int? appointmentStartDateTime;
  String? appointmentEndTime;
  int? appointmentEndDateTime;
  String? appointmentRemark;
  String? appointmentAttDoc;
  String? appointmentStatus;
  String? appointmentType;
  List<AppointmentServiceexpertDtl>? appointmentServiceexpertDtl;

  factory AppointmentexpertDetail.fromJson(Map<String, dynamic> json) =>
      AppointmentexpertDetail(
        appointmentId: json["AppointmentId"],
        bookingId: json["BookingId"],
        centerName: json["CenterName"],
        centerCode: json["CenterCode"],
        clientId: json["ClientId"],
        clientname: json["clientname"],
        bookingNumber: json["BookingNumber"],
        appointmentDate: json["AppointmentDate"],
        appointmentStartTime: json["AppointmentStartTime"],
        appointmentStartDateTime: json["AppointmentStartDateTime"],
        appointmentEndTime: json["AppointmentEndTime"],
        appointmentEndDateTime: json["AppointmentEndDateTime"],
        appointmentRemark: json["AppointmentRemark"],
        appointmentAttDoc: json["AppointmentAttDoc"],
        appointmentStatus: json["AppointmentStatus"],
        appointmentType: json["AppointmentType"],
        appointmentServiceexpertDtl: List<AppointmentServiceexpertDtl>.from(
            json["AppointmentServiceexpertDtl"]
                .map((x) => AppointmentServiceexpertDtl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "AppointmentId": appointmentId,
        "BookingId": bookingId,
        "CenterName": centerName,
        "CenterCode": centerCode,
        "ClientId": clientId,
        "clientname": clientname,
        "BookingNumber": bookingNumber,
        "AppointmentDate": appointmentDate,
        "AppointmentStartTime": appointmentStartTime,
        "AppointmentStartDateTime": appointmentStartDateTime,
        "AppointmentEndTime": appointmentEndTime,
        "AppointmentEndDateTime": appointmentEndDateTime,
        "AppointmentRemark": appointmentRemark,
        "AppointmentAttDoc": appointmentAttDoc,
        "AppointmentStatus": appointmentStatus,
        "AppointmentType": appointmentType,
        "AppointmentServiceexpertDtl": List<dynamic>.from(
            appointmentServiceexpertDtl!.map((x) => x.toJson())),
      };
}

class AppointmentServiceexpertDtl {
  AppointmentServiceexpertDtl({
    this.appointmentServiceId,
    this.serviceName,
    this.serviceCode,
    this.staffname,
  });

  String? appointmentServiceId;
  String? serviceName;
  String? serviceCode;
  String? staffname;

  factory AppointmentServiceexpertDtl.fromJson(Map<String, dynamic> json) =>
      AppointmentServiceexpertDtl(
        appointmentServiceId: json["AppointmentServiceId"],
        serviceName: json["ServiceName"],
        serviceCode: json["ServiceCode"],
        staffname: json["Staffname"],
      );

  Map<String, dynamic> toJson() => {
        "AppointmentServiceId": appointmentServiceId,
        "ServiceName": serviceName,
        "ServiceCode": serviceCode,
        "Staffname": staffname,
      };
}
