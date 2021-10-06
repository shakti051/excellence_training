import 'dart:convert';

AcademicDetailResponse academicDetailResponseFromJson(String str) =>
    AcademicDetailResponse.fromJson(json.decode(str));

String academicDetailResponseToJson(AcademicDetailResponse data) =>
    json.encode(data.toJson());

class AcademicDetailResponse {
  AcademicDetailResponse({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<Datum> data;
  int code;

  factory AcademicDetailResponse.fromJson(Map<String, dynamic> json) =>
      AcademicDetailResponse(
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
    this.academic,
    this.createdAt,
  });

  String id;
  String userId;
  List<Academic> academic;
  int createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userId: json["user_id"],
        academic: List<Academic>.from(
            json["academic"].map((x) => Academic.fromJson(x))),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "academic": List<dynamic>.from(academic.map((x) => x.toJson())),
        "created_at": createdAt,
      };
}

class Academic {
  Academic({
    this.institutionName,
    this.degree,
    this.specialisation,
    this.fromMonth,
    this.fromYear,
    this.toMonth,
    this.toYear,
    this.isCurrentlyHere,
    this.academicRecord,
    this.bio,
  });

  String institutionName;
  String degree;
  String specialisation;
  String fromMonth;
  String fromYear;
  String toMonth;
  String toYear;
  bool isCurrentlyHere;
  String academicRecord;
  String bio;

  factory Academic.fromJson(Map<String, dynamic> json) => Academic(
        institutionName: json["institutionName"],
        degree: json["degree"],
        specialisation: json["specialisation"],
        fromMonth: json["fromMonth"],
        fromYear: json["fromYear"],
        toMonth: json["toMonth"],
        toYear: json["toYear"],
        isCurrentlyHere: json["isCurrentlyHere"],
        academicRecord: json["academicRecord"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "institutionName": institutionName,
        "degree": degree,
        "specialisation": specialisation,
        "fromMonth": fromMonth,
        "fromYear": fromYear,
        "toMonth": toMonth,
        "toYear": toYear,
        "isCurrentlyHere": isCurrentlyHere,
        "academicRecord": academicRecord,
        "bio": bio,
      };
}
