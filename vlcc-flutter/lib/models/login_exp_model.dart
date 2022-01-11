// To parse this JSON data, do
//
//     final loginExpModel = loginExpModelFromJson(jsonString);

import 'dart:convert';

LoginExpModel loginExpModelFromJson(String str) =>
    LoginExpModel?.fromJson(json.decode(str));

String loginExpModelToJson(LoginExpModel data) => json.encode(data.toJson());

class LoginExpModel {
  LoginExpModel({
    this.status,
    this.message,
    this.loginInfo,
  });

  int? status;
  String? message;
  LoginInfo? loginInfo;

  factory LoginExpModel.fromJson(Map<String, dynamic> json) => LoginExpModel(
        status: json["Status"],
        message: json["Message"],
        loginInfo: LoginInfo?.fromJson(json["LoginInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "LoginInfo": loginInfo!.toJson(),
      };
}

class LoginInfo {
  LoginInfo({
    this.otp = '',
    this.deviceId = "",
    this.startDateTime,
    this.expiryDateTime,
  });

  dynamic otp;
  String? deviceId;
  DateTime? startDateTime = DateTime.now();
  DateTime? expiryDateTime = DateTime.now();

  factory LoginInfo.fromJson(Map<String, dynamic> json) => LoginInfo(
        otp: json["OTP"] ?? "",
        deviceId: json["deviceId"] ?? "",
        startDateTime: DateTime.parse(
            json["startDateTime"] ?? DateTime.now().toIso8601String()),
        expiryDateTime: DateTime.parse(
            json["expiryDateTime"] ?? DateTime.now().toIso8601String()),
      );

  Map<String, dynamic> toJson() => {
        "OTP": otp,
        "deviceId": deviceId,
        "startDateTime": startDateTime?.toIso8601String(),
        "expiryDateTime": expiryDateTime?.toIso8601String(),
      };
}
