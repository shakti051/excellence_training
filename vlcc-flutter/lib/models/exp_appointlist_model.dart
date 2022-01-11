// To parse this JSON data, do
//
//     final expAppointListModel = expAppointListModelFromJson(jsonString);

import 'dart:convert';

ExpAppointListModel expAppointListModelFromJson(String str) =>
    ExpAppointListModel.fromJson(json.decode(str));

String expAppointListModelToJson(ExpAppointListModel data) =>
    json.encode(data.toJson());

class ExpAppointListModel {
  ExpAppointListModel({
    this.status,
    this.message,
    this.appointmentexpertDetails,
  });

  int? status;
  String? message;
  List<AppointmentexpertDetail>? appointmentexpertDetails;

  factory ExpAppointListModel.fromJson(Map<String, dynamic> json) =>
      ExpAppointListModel(
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
    this.appointmentBookingType,
    this.appointmentServiceexpertDtl,
  });

  String? appointmentId;
  String? bookingId;
  String? centerName;
  String? centerCode;
  String? clientId;
  String? bookingNumber;
  DateTime? appointmentDate;
  String? appointmentStartTime;
  int? appointmentStartDateTime;
  String? appointmentEndTime;
  int? appointmentEndDateTime;
  String? appointmentRemark;
  String? appointmentAttDoc;
  String? appointmentStatus;
  String? appointmentType;
  String? appointmentBookingType;
  List<AppointmentServiceexpertDtl>? appointmentServiceexpertDtl;

  factory AppointmentexpertDetail.fromJson(Map<String, dynamic> json) =>
      AppointmentexpertDetail(
        appointmentId: json["AppointmentId"],
        bookingId: json["BookingId"],
        centerName: json["CenterName"],
        centerCode: json["CenterCode"],
        clientId: json["ClientId"],
        bookingNumber: json["BookingNumber"],
        appointmentDate: DateTime.parse(json["AppointmentDate"]),
        appointmentStartTime: json["AppointmentStartTime"],
        appointmentStartDateTime: json["AppointmentStartDateTime"],
        appointmentEndTime: json["AppointmentEndTime"],
        appointmentEndDateTime: json["AppointmentEndDateTime"],
        appointmentRemark: json["AppointmentRemark"],
        appointmentAttDoc: json["AppointmentAttDoc"],
        appointmentStatus: json["AppointmentStatus"],
        appointmentType: json["AppointmentType"],
        appointmentBookingType: json["AppointmentBookingType"],
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
        "BookingNumber": bookingNumber,
        "AppointmentDate":
            "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
        "AppointmentStartTime": appointmentStartTime,
        "AppointmentStartDateTime": appointmentStartDateTime,
        "AppointmentEndTime": appointmentEndTime,
        "AppointmentEndDateTime": appointmentEndDateTime,
        "AppointmentRemark": appointmentRemark,
        "AppointmentAttDoc": appointmentAttDoc,
        "AppointmentStatus": appointmentStatus,
        "AppointmentType": appointmentType,
        "AppointmentBookingType": appointmentBookingType,
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
