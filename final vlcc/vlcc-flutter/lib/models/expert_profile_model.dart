// To parse this JSON data, do
//
//     final exertProfileModel = exertProfileModelFromJson(jsonString);

import 'dart:convert';

ExertProfileModel exertProfileModelFromJson(String str) =>
    ExertProfileModel.fromJson(json.decode(str));

String exertProfileModelToJson(ExertProfileModel data) =>
    json.encode(data.toJson());

class ExertProfileModel {
  ExertProfileModel({
    this.status,
    this.message,
    this.staffDetails,
  });

  int? status;
  String? message;
  StaffDetails? staffDetails;

  factory ExertProfileModel.fromJson(Map<String, dynamic> json) =>
      ExertProfileModel(
        status: json["Status"],
        message: json["Message"],
        staffDetails: StaffDetails.fromJson(
          json["StaffDetails"] ??
              StaffDetails(
                staffname: '',
                staffDateofBirth: DateTime.now().subtract(
                  Duration(days: 4749),
                ),
                staffGender: '',
                staffInfoId: '',
                staffMobileNo: '',
                staffcode: '',
              ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "StaffDetails": staffDetails?.toJson(),
      };
}

class StaffDetails {
  StaffDetails({
    this.staffInfoId,
    this.staffname,
    this.staffcode,
    this.centerName,
    this.centerCode,
    this.staffGender,
    this.staffDateofBirth,
    this.staffMobileNo,
  });

  String? staffInfoId;
  String? staffname;
  String? staffcode;
  String? centerName;
  String? centerCode;
  String? staffGender;
  DateTime? staffDateofBirth;
  String? staffMobileNo;

  factory StaffDetails.fromJson(Map<String, dynamic> json) => StaffDetails(
        staffInfoId: json["StaffInfoId"],
        staffname: json["Staffname"],
        staffcode: json["Staffcode"],
        centerName: json["CenterName"],
        centerCode: json["CenterCode"],
        staffGender: json["StaffGender"],
        staffDateofBirth: DateTime.parse(json["StaffDateofBirth"]),
        staffMobileNo: json["StaffMobileNo"],
      );

  Map<String, dynamic> toJson() => {
        "StaffInfoId": staffInfoId,
        "Staffname": staffname,
        "Staffcode": staffcode,
        "CenterName": centerName,
        "CenterCode": centerCode,
        "StaffGender": staffGender,
        "StaffDateofBirth":
            "${staffDateofBirth!.year.toString().padLeft(4, '0')}-${staffDateofBirth!.month.toString().padLeft(2, '0')}-${staffDateofBirth!.day.toString().padLeft(2, '0')}",
        "StaffMobileNo": staffMobileNo,
      };
}
