// To parse this JSON data, do
//
//     final resendOtpModel = resendOtpModelFromJson(jsonString);

import 'dart:convert';

ResendOtpModel resendOtpModelFromJson(String str) =>
    ResendOtpModel.fromJson(json.decode(str));

String resendOtpModelToJson(ResendOtpModel data) => json.encode(data.toJson());

class ResendOtpModel {
  ResendOtpModel({
    required this.status,
    required this.message,
    required this.mobileChangeInfo,
  });

  int status;
  String message;
  MobileChangeInfo mobileChangeInfo;

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) => ResendOtpModel(
        status: json["Status"],
        message: json["Message"],
        mobileChangeInfo: MobileChangeInfo.fromJson(json["MobileChangeInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "MobileChangeInfo": mobileChangeInfo.toJson(),
      };
}

class MobileChangeInfo {
  MobileChangeInfo({
    required this.otp,
    required this.deviceId,
    required this.startDateTime,
    required this.expiryDateTime,
  });

  String otp;
  String deviceId;
  DateTime startDateTime;
  DateTime expiryDateTime;

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
        "startDateTime": startDateTime.toIso8601String(),
        "expiryDateTime": expiryDateTime.toIso8601String(),
      };
}
