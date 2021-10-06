// To parse this JSON data, do
//
//     final experienceDetailGetResponse = experienceDetailGetResponseFromJson(jsonString);

import 'dart:convert';

ExperienceDetailGetResponse experienceDetailGetResponseFromJson(String str) =>
    ExperienceDetailGetResponse.fromJson(json.decode(str));

String experienceDetailGetResponseToJson(ExperienceDetailGetResponse data) =>
    json.encode(data.toJson());

class ExperienceDetailGetResponse {
  ExperienceDetailGetResponse({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<Datum> data;
  int code;

  factory ExperienceDetailGetResponse.fromJson(Map<String, dynamic> json) =>
      ExperienceDetailGetResponse(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.experience,
    this.createdAt,
  });

  String id;
  String userId;
  List<Experience> experience;
  int createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userId: json["user_id"],
        experience: List<Experience>.from(
            json["experience"].map((x) => Experience.fromJson(x))),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "experience": List<dynamic>.from(experience.map((x) => x.toJson())),
        "created_at": createdAt,
      };
}

class Experience {
  Experience({
    this.institutionName,
    this.subject,
    this.fromMonth,
    this.fromYear,
    this.toMonth,
    this.toYear,
    this.isCurrentlyHere,
  });

  String institutionName;
  String subject;
  String fromMonth;
  String fromYear;
  String toMonth;
  String toYear;
  bool isCurrentlyHere;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        institutionName: json["institutionName"],
        subject: json["subject"],
        fromMonth: json["fromMonth"],
        fromYear: json["fromYear"],
        toMonth: json["toMonth"],
        toYear: json["toYear"],
        isCurrentlyHere: json["isCurrentlyHere"],
      );

  Map<String, dynamic> toJson() => {
        "institutionName": institutionName,
        "subject": subject,
        "fromMonth": fromMonth,
        "fromYear": fromYear,
        "toMonth": toMonth,
        "toYear": toYear,
        "isCurrentlyHere": isCurrentlyHere,
      };
}
