// To parse this JSON data, do
//
//     final appointmentListModel = appointmentListModelFromJson(jsonString);

import 'dart:convert';

import 'package:vlcc/resources/string_extensions.dart';

AppointmentListModel appointmentListModelFromJson(String str) =>
    AppointmentListModel.fromJson(json.decode(str));

String appointmentListModelToJson(AppointmentListModel data) =>
    json.encode(data.toJson());

class AppointmentListModel {
  AppointmentListModel({
    this.status = 2000,
    this.message = '',
    this.appointmentDetails,
  });

  int status;
  String message;
  List<AppointmentDetail>? appointmentDetails;

  factory AppointmentListModel.fromJson(Map<String, dynamic> json) =>
      AppointmentListModel(
        status: json["Status"],
        message: json["Message"],
        appointmentDetails: List<AppointmentDetail>.from(
            json["AppointmentRBSDetails"]
                .map((x) => AppointmentDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "AppointmentDetails":
            List<dynamic>.from(appointmentDetails!.map((x) => x.toJson())),
      };
}

class AppointmentDetail {
  AppointmentDetail({
    this.appointmentId = '',
    this.centerName = '',
    this.centerCode = '',
    this.clientId = '',
    this.bookingNumber = '',
    this.serviceName = '',
    this.appointmentDate,
    this.appointmentTime = '',
    this.appointmentRemark = '',
    this.appointmentAttDoc = '',
    this.appointmentStatus = '',
    this.appointmentType = '',
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.addressLine3 = '',
    this.areaName = '',
    this.cityName = '',
    this.stateName = '',
    this.countryName = '',
    this.phoneNumber = '',
    this.centerMap = '',
    this.centerLatitude = '',
    this.centerLongitude = '',
    this.appointmentStartDateTime = 0,
    required this.appointmentRoom,
    required this.appointmentToken,
  });

  String appointmentId;
  String centerName;
  String centerCode;
  String clientId;
  String bookingNumber;
  String serviceName;
  DateTime? appointmentDate;
  String appointmentTime;
  String appointmentRemark;
  String appointmentAttDoc;
  String appointmentStatus;
  String appointmentType;
  String appointmentToken;
  String appointmentRoom;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String areaName;
  String cityName;
  String stateName;
  String countryName;
  String phoneNumber;
  String centerMap;
  String centerLatitude;

  String centerLongitude;
  int appointmentStartDateTime;

  factory AppointmentDetail.fromJson(Map<String, dynamic> json) =>
      AppointmentDetail(
        appointmentId: json["AppointmentId"] ?? '',
        centerName: json["CenterName"] ?? '',
        centerCode: json["CenterCode"] ?? '',
        clientId: json["ClientId"] ?? '',
        bookingNumber: json["BookingNumber"] ?? '',
        serviceName: json["ServiceName"] ?? "VLCC",
        appointmentDate: DateTime.parse(
          json["AppointmentDate"] ?? DateTime.now(),
        ),
        appointmentTime: json["AppointmentTime"],
        appointmentRemark: json["AppointmentRemark"],
        appointmentAttDoc: json["AppointmentAttDoc"],
        appointmentStatus: json["AppointmentStatus"],
        appointmentType: json["AppointmentType"] ?? 'General',
        addressLine1:
            json["address_line1"].toString().toLowerCase().toTitleCase,
        addressLine2:
            json["address_line2"].toString().toLowerCase().toTitleCase,
        addressLine3:
            json["address_line3"].toString().toLowerCase().toTitleCase,
        areaName: json["area_name"].toString().toLowerCase().toTitleCase,
        cityName: json["city_name"].toString().toLowerCase().toTitleCase,
        stateName: json["state_name"],
        countryName: json["country_name"],
        phoneNumber: json["phone_number"],
        centerMap: json["center_map"],
        centerLatitude: json["center_latitude"],
        centerLongitude: json["center_longitude"],
        appointmentStartDateTime: json["AppointmentDateTime"] ?? 0,
        appointmentRoom: json["AppointmentRoom"] ?? '',
        appointmentToken: json["AppointmentToken"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "AppointmentId": appointmentId,
        "CenterName": centerName,
        "CenterCode": centerCode,
        "ClientId": clientId,
        "BookingNumber": bookingNumber,
        "ServiceName": serviceName,
        "AppointmentDate":
            "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
        "AppointmentTime": appointmentTime,
        "AppointmentRemark": appointmentRemark,
        "AppointmentAttDoc": appointmentAttDoc,
        "AppointmentStatus": appointmentStatus,
        "AppointmentType": appointmentType,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "address_line3": addressLine3,
        "area_name": areaName,
        "city_name": cityName,
        "state_name": stateName,
        "country_name": countryName,
        "phone_number": phoneNumber,
        "center_map": centerMap,
        "center_latitude": centerLatitude,
        "center_longitude": centerLongitude,
        "AppointmentStartDateTime": appointmentStartDateTime,
      };
}
