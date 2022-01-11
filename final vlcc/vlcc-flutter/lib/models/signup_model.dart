class SignupModel {
  int? status;
  String? message;
  ClientSignupInfo? clientSignupInfo;

  SignupModel({this.status, this.message, this.clientSignupInfo});

  SignupModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    clientSignupInfo = json['ClientSignupInfo'] != null
        ? ClientSignupInfo.fromJson(json['ClientSignupInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    if (clientSignupInfo != null) {
      data['ClientSignupInfo'] = clientSignupInfo?.toJson();
    }
    return data;
  }
}

class ClientSignupInfo {
  String? clientName;
  String? clientID;
  String? clientMobile;
  String? clientEmail;
  String? oTP;
  String? deviceId;
  String? startDateTime;
  String? expiryDateTime;

  ClientSignupInfo(
      {this.clientName,
      this.clientID,
      this.clientMobile,
      this.clientEmail,
      this.oTP,
      this.deviceId,
      this.startDateTime,
      this.expiryDateTime});

  ClientSignupInfo.fromJson(Map<String, dynamic> json) {
    clientName = json['clientName'];
    clientID = json['clientID'];
    clientMobile = json['clientMobile'];
    clientEmail = json['clientEmail'];
    oTP = json['OTP'];
    deviceId = json['deviceId'];
    startDateTime = json['startDateTime'];
    expiryDateTime = json['expiryDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientName'] = clientName;
    data['clientID'] = clientID;
    data['clientMobile'] = clientMobile;
    data['clientEmail'] = clientEmail;
    data['OTP'] = oTP;
    data['deviceId'] = deviceId;
    data['startDateTime'] = startDateTime;
    data['expiryDateTime'] = expiryDateTime;
    return data;
  }
}
