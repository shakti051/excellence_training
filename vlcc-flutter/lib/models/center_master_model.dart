// To parse this JSON data, do
//
//     final centerMasterMainModel = centerMasterMainModelFromJson(jsonString);

import 'dart:convert';

CenterMasterMainModel centerMasterMainModelFromJson(String str) =>
    CenterMasterMainModel.fromJson(json.decode(str));

String centerMasterMainModelToJson(CenterMasterMainModel data) =>
    json.encode(data.toJson());

class CenterMasterMainModel {
  CenterMasterMainModel({
    this.status = 2000,
    this.message = '',
    this.centerMaster,
  });

  int status;
  String message;
  List<CenterMasterDatabase>? centerMaster;

  factory CenterMasterMainModel.fromJson(Map<String, dynamic> json) =>
      CenterMasterMainModel(
        status: json["Status"],
        message: json["Message"],
        centerMaster: List<CenterMasterDatabase>.from(
            json["CenterMaster"].map((x) => CenterMasterDatabase.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "CenterMaster":
            List<dynamic>.from(centerMaster!.map((x) => x.toJson())),
      };
}

class CenterMasterDatabase {
  CenterMasterDatabase({
    this.centerCode = '',
    this.centerName = '',
    this.centerType = '',
    this.centerRatelist = '',
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
    this.centerPic = '',
    this.centerStatus = '',
  });

  String centerCode;
  String centerName;
  String centerType;
  String centerRatelist;
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
  String centerPic;
  String centerStatus;

  factory CenterMasterDatabase.fromJson(Map<String, dynamic> json) =>
      CenterMasterDatabase(
        centerCode: json["center_code"] ?? '',
        centerName: json["center_name"] ?? '',
        centerType: json["center_type"] ?? '',
        centerRatelist: json["center_ratelist"] ?? '',
        addressLine1: json["address_line1"] ?? '',
        addressLine2: json["address_line2"] ?? '',
        addressLine3: json["address_line3"] ?? '',
        areaName: json["area_name"] ?? '',
        cityName: json["city_name"] ?? '',
        stateName: json["state_name"] ?? '',
        countryName: json["country_name"] ?? '',
        phoneNumber: json["phone_number"] ?? '',
        centerMap: json["center_map"] ?? '',
        centerLatitude: json["center_latitude"] ?? '',
        centerLongitude: json["center_longitude"] ?? '',
        centerPic: json["center_pic"] ?? '',
        centerStatus: json["center_status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "center_code": centerCode,
        "center_name": centerName,
        "center_type": centerType,
        "center_ratelist": centerRatelist,
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
        "center_pic": centerPic,
        "center_status": centerStatus,
      };
}
