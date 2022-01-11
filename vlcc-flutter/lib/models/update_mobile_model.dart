// To parse this JSON data, do
//
//     final updateMobileModel = updateMobileModelFromJson(jsonString);

import 'dart:convert';

UpdateMobileModel updateMobileModelFromJson(String str) =>
    UpdateMobileModel.fromJson(json.decode(str));

String updateMobileModelToJson(UpdateMobileModel data) =>
    json.encode(data.toJson());

class UpdateMobileModel {
  UpdateMobileModel({
    this.status,
    this.message,
    this.mobileChangeInfo,
  });

  int? status;
  String? message;
  MobileChangeInfo? mobileChangeInfo;

  factory UpdateMobileModel.fromJson(Map<String, dynamic> json) =>
      UpdateMobileModel(
        status: json["Status"],
        message: json["Message"],
        mobileChangeInfo: MobileChangeInfo.fromJson(json["MobileChangeInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "MobileChangeInfo": mobileChangeInfo?.toJson(),
      };
}

class MobileChangeInfo {
  MobileChangeInfo({
    this.otp,
    this.deviceId,
    this.startDateTime,
    this.expiryDateTime,
  });

  String? otp;
  String? deviceId;
  DateTime? startDateTime;
  DateTime? expiryDateTime;

  factory MobileChangeInfo.fromJson(Map<String, dynamic> json) =>
      MobileChangeInfo(
        otp: json["OTP"],
        deviceId: json["deviceId"],
        startDateTime: DateTime.parse(json["startDateTime"]),
        expiryDateTime: DateTime.parse(json["expiryDateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "OTP": otp,
        "deviceId": deviceId,
        "startDateTime": startDateTime!.toIso8601String(),
        "expiryDateTime": expiryDateTime!.toIso8601String(),
      };
}
