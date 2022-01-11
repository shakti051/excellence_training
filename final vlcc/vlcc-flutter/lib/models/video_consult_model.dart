// To parse this JSON data, do
//
//     final videoConsultModel = videoConsultModelFromJson(jsonString);

import 'dart:convert';

VideoConsultModel videoConsultModelFromJson(String str) =>
    VideoConsultModel.fromJson(json.decode(str));

String videoConsultModelToJson(VideoConsultModel data) =>
    json.encode(data.toJson());

class VideoConsultModel {
  VideoConsultModel({
    this.status = 2000,
    this.message = '',
    this.appointmentDetails,
  });

  int status;
  String message;
  List<VideoAppointmentDetail>? appointmentDetails;

  factory VideoConsultModel.fromJson(Map<String, dynamic> json) =>
      VideoConsultModel(
        status: json["Status"],
        message: json["Message"],
        appointmentDetails: List<VideoAppointmentDetail>.from(
            json["AppointmentDetails"]
                .map((x) => VideoAppointmentDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "AppointmentDetails":
            List<dynamic>.from(appointmentDetails!.map((x) => x.toJson())),
      };
}

class VideoAppointmentDetail {
  VideoAppointmentDetail({
    this.appointmentId = '',
    this.bookingId = '',
    this.centerName = '',
    this.centerCode = '',
    this.clientId = '',
    this.bookingNumber = '',
    this.appointmentDate,
    this.appointmentStartTime = '',
    this.appointmentEndTime = '',
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
    this.appointmentServiceDtl,
  });

  String appointmentId;
  String bookingId;
  String centerName;
  String centerCode;
  String clientId;
  String bookingNumber;
  DateTime? appointmentDate;
  String appointmentStartTime;
  String appointmentEndTime;
  String appointmentRemark;
  String appointmentAttDoc;
  String appointmentStatus;
  String appointmentType;
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
  List<AppointmentServiceDtl>? appointmentServiceDtl;

  factory VideoAppointmentDetail.fromJson(Map<String, dynamic> json) =>
      VideoAppointmentDetail(
        appointmentId: json["AppointmentId"],
        bookingId: json["BookingId"],
        centerName: json["CenterName"],
        centerCode: json["CenterCode"],
        clientId: json["ClientId"],
        bookingNumber: json["BookingNumber"],
        appointmentDate: DateTime.parse(json["AppointmentDate"]),
        appointmentStartTime: json["AppointmentStartTime"],
        appointmentEndTime: json["AppointmentEndTime"],
        appointmentRemark: json["AppointmentRemark"],
        appointmentAttDoc: json["AppointmentAttDoc"],
        appointmentStatus: json["AppointmentStatus"],
        appointmentType: json["AppointmentType"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        addressLine3: json["address_line3"],
        areaName: json["area_name"],
        cityName: json["city_name"],
        stateName: json["state_name"],
        countryName: json["country_name"],
        phoneNumber: json["phone_number"],
        centerMap: json["center_map"],
        centerLatitude: json["center_latitude"],
        centerLongitude: json["center_longitude"],
        appointmentServiceDtl: List<AppointmentServiceDtl>.from(
            json["AppointmentServiceDtl"]
                .map((x) => AppointmentServiceDtl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "AppointmentId": appointmentId,
        "BookingId": bookingId,
        "CenterName": centerName,
        "CenterCode": centerCode,
        "ClientId": clientId,
        "BookingNumber": bookingNumber,
        "AppointmentDate":
            "${appointmentDate?.year.toString().padLeft(4, '0')}-${appointmentDate?.month.toString().padLeft(2, '0')}-${appointmentDate?.day.toString().padLeft(2, '0')}",
        "AppointmentStartTime": appointmentStartTime,
        "AppointmentEndTime": appointmentEndTime,
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
        "AppointmentServiceDtl":
            List<dynamic>.from(appointmentServiceDtl!.map((x) => x.toJson())),
      };
}

class AppointmentServiceDtl {
  AppointmentServiceDtl({
    this.appointmentServiceId = '',
    this.serviceName = '',
    this.serviceCode = '',
  });

  String appointmentServiceId;
  String serviceName;
  String serviceCode;

  factory AppointmentServiceDtl.fromJson(Map<String, dynamic> json) =>
      AppointmentServiceDtl(
        appointmentServiceId: json["AppointmentServiceId"],
        serviceName: json["ServiceName"],
        serviceCode: json["ServiceCode"],
      );

  Map<String, dynamic> toJson() => {
        "AppointmentServiceId": appointmentServiceId,
        "ServiceName": serviceName,
        "ServiceCode": serviceCode,
      };
}
