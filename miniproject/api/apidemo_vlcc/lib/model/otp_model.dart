class OTPModel {
  int? status;
  String? message;
  LoginInfo? loginInfo;

  OTPModel({this.status, this.message, this.loginInfo});

  OTPModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    loginInfo = json['LoginInfo'] != null
        ? new LoginInfo.fromJson(json['LoginInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.loginInfo != null) {
      data['LoginInfo'] = this.loginInfo!.toJson();
    }
    return data;
  }
}

class LoginInfo {
  String? oTP;
  String? deviceId;
  String? startDateTime;
  String? expiryDateTime;

  LoginInfo({this.oTP, this.deviceId, this.startDateTime, this.expiryDateTime});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    oTP = json['OTP'];
    deviceId = json['deviceId'];
    startDateTime = json['startDateTime'];
    expiryDateTime = json['expiryDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OTP'] = this.oTP;
    data['deviceId'] = this.deviceId;
    data['startDateTime'] = this.startDateTime;
    data['expiryDateTime'] = this.expiryDateTime;
    return data;
  }
}