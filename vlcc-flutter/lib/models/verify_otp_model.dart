// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) =>
    VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  VerifyOtpModel({
    required this.status,
    required this.message,
    required this.tokenInfo,
  });

  int status;
  String message;
  TokenInfo tokenInfo;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        status: json["Status"],
        message: json["Message"],
        tokenInfo: TokenInfo.fromJson(json["TokenInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "TokenInfo": tokenInfo.toJson(),
      };
}

class TokenInfo {
  TokenInfo({
    required this.authToken,
    required this.deviceId,
    required this.clientMobile,
  });

  String authToken;
  String deviceId;
  String clientMobile;

  factory TokenInfo.fromJson(Map<String, dynamic> json) => TokenInfo(
        authToken: json["auth_token"],
        deviceId: json["deviceId"],
        clientMobile: json["clientMobile"],
      );

  Map<String, dynamic> toJson() => {
        "auth_token": authToken,
        "deviceId": deviceId,
        "clientMobile": clientMobile,
      };
}
