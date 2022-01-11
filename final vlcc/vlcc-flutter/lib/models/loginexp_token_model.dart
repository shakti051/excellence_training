// To parse this JSON data, do
//
//     final loginExpTokenExp = loginExpTokenExpFromJson(jsonString);

import 'dart:convert';

LoginExpTokenExp loginExpTokenExpFromJson(String str) => LoginExpTokenExp.fromJson(json.decode(str));

String loginExpTokenExpToJson(LoginExpTokenExp data) => json.encode(data.toJson());

class LoginExpTokenExp {
    LoginExpTokenExp({
        this.status,
        this.message,
        this.tokenInfo,
    });

    int? status;
    String? message;
    TokenInfo? tokenInfo;

    factory LoginExpTokenExp.fromJson(Map<String, dynamic> json) => LoginExpTokenExp(
        status: json["Status"],
        message: json["Message"],
        tokenInfo: TokenInfo.fromJson(json["TokenInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "TokenInfo": tokenInfo!.toJson(),
    };
}

class TokenInfo {
    TokenInfo({
        this.authToken,
        this.deviceId,
        this.expertName,
        this.expertMobile,
        this.expertEmail,
    });

    String? authToken;
    String? deviceId;
    String? expertName;
    String? expertMobile;
    String? expertEmail;

    factory TokenInfo.fromJson(Map<String, dynamic> json) => TokenInfo(
        authToken: json["auth_token"],
        deviceId: json["deviceId"],
        expertName: json["expertName"],
        expertMobile: json["expertMobile"],
        expertEmail: json["expertEmail"],
    );

    Map<String, dynamic> toJson() => {
        "auth_token": authToken,
        "deviceId": deviceId,
        "expertName": expertName,
        "expertMobile": expertMobile,
        "expertEmail": expertEmail,
    };
}
