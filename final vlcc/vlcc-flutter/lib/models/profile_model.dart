import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.status = 200,
    this.message = '',
    required this.clientProfileDetails,
  });

  int status;
  String message;
  ClientProfileDetails clientProfileDetails;

  factory ProfileModel.fromJson(Map<String, dynamic>? json) => ProfileModel(
        status: json?["Status"],
        message: json?["Message"],
        clientProfileDetails:
            ClientProfileDetails.fromJson(json!["ClientProfileDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "ClientProfileDetails": clientProfileDetails.toJson(),
      };
}

class ClientProfileDetails {
  ClientProfileDetails({
    this.clientInfoId = '',
    this.centerName = '',
    this.centerCode = '',
    this.clientId = '',
    this.clientTitle = '',
    this.clientName = '',
    this.clientGender = '',
    required this.clientDateofBirth,
    this.clientMobileNo = '',
    this.clientEmailid = '',
    this.clientAddress = '',
    this.clientCity = '',
    this.clientState = '',
    this.clientPin = '',
    this.clientPan = '',
    this.clientMaritalStatus = '',
    this.clientProfilePic = '',
  });

  String clientInfoId;
  String centerName;
  String centerCode;
  String clientId;
  String clientTitle;
  String clientName;
  String clientGender;
  DateTime clientDateofBirth;
  String clientMobileNo;
  String clientEmailid;
  String clientAddress;
  String clientCity;
  String clientState;
  String clientPin;
  String clientPan;
  String clientMaritalStatus;
  String clientProfilePic;

  factory ClientProfileDetails.fromJson(Map<String, dynamic> json) =>
      ClientProfileDetails(
        clientInfoId: json["ClientInfoId"] ?? '',
        centerName: json["CenterName"] ?? '',
        centerCode: json["CenterCode"] ?? '',
        clientId: json["ClientId"] ?? '',
        clientTitle: json["ClientTitle"] ?? '',
        clientName: json["ClientName"] ?? '',
        clientGender: json["ClientGender"] ?? '',
        clientDateofBirth: DateTime.parse(json["ClientDateofBirth"]),
        clientMobileNo: json["ClientMobileNo"] ?? '',
        clientEmailid: json["ClientEmailid"] ?? '',
        clientAddress: json["ClientAddress"] ?? '',
        clientCity: json["ClientCity"] ?? '',
        clientState: json["ClientState"] ?? '',
        clientPin: json["ClientPin"] ?? '',
        clientPan: json["ClientPAN"] ?? '',
        clientMaritalStatus: json["ClientMaritalStatus"] ?? '',
        clientProfilePic: json["ClientProfilePic"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ClientInfoId": clientInfoId,
        "CenterName": centerName,
        "CenterCode": centerCode,
        "ClientId": clientId,
        "ClientTitle": clientTitle,
        "ClientName": clientName,
        "ClientGender": clientGender,
        "ClientDateofBirth":
            "${clientDateofBirth.year.toString().padLeft(4, '0')}-${clientDateofBirth.month.toString().padLeft(2, '0')}-${clientDateofBirth.day.toString().padLeft(2, '0')}",
        "ClientMobileNo": clientMobileNo,
        "ClientEmailid": clientEmailid,
        "ClientAddress": clientAddress,
        "ClientCity": clientCity,
        "ClientState": clientState,
        "ClientPin": clientPin,
        "ClientPAN": clientPan,
        "ClientMaritalStatus": clientMaritalStatus,
        "ClientProfilePic": clientProfilePic,
      };
}
