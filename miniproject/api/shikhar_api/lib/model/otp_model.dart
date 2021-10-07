// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
    OtpModel({
       required this.status,
       required this.message,
       required this.loginInfo,
    });

    int status;
    String message;
    LoginInfo loginInfo;

    factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        status: json["Status"],
        message: json["Message"],
        loginInfo: LoginInfo.fromJson(json["LoginInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "LoginInfo": loginInfo.toJson(),
    };
}

class LoginInfo {
    LoginInfo({
     required   this.otp,
      required this.deviceId,
      required  this.startDateTime,
      required this.expiryDateTime,
    });

    String otp;
    String deviceId;
    DateTime startDateTime;
    DateTime expiryDateTime;

    factory LoginInfo.fromJson(Map<String, dynamic> json) => LoginInfo(
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
