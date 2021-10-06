// // To parse this JSON data, do
// //
// //     final academicDetailGetResponse = academicDetailGetResponseFromJson(jsonString);

// import 'dart:convert';

// AcademicDetailGetResponse academicDetailGetResponseFromJson(String str) =>
//     AcademicDetailGetResponse.fromJson(json.decode(str));

// String academicDetailGetResponseToJson(AcademicDetailGetResponse data) =>
//     json.encode(data.toJson());

// class AcademicDetailGetResponse {
//   AcademicDetailGetResponse({
//     this.message,
//     this.data,
//     this.code,
//   });

//   String message;
//   List<Datum> data;
//   int code;

//   factory AcademicDetailGetResponse.fromJson(Map<String, dynamic> json) =>
//       AcademicDetailGetResponse(
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         code: json["code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "code": code,
//       };
// }

// class Datum {
//   Datum({
//     this.id,
//     this.userId,
//     this.academic,
//     this.createdAt,
//   });

//   String id;
//   String userId;
//   List<Academic> academic;
//   int createdAt;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["_id"],
//         userId: json["user_id"],
//         academic: List<Academic>.from(
//             json["academic"].map((x) => Academic.fromJson(x))),
//         createdAt: json["created_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "user_id": userId,
//         "academic": List<dynamic>.from(academic.map((x) => x.toJson())),
//         "created_at": createdAt,
//       };
// }

// class Academic {
//   Academic({
//     this.userUniversity,
//     this.userDegree,
//     this.userFrom,
//     this.userTo,
//   });

//   String userUniversity;
//   String userDegree;
//   String userFrom;
//   String userTo;

//   factory Academic.fromJson(Map<String, dynamic> json) => Academic(
//         userUniversity: json["user_university"],
//         userDegree: json["user_degree"],
//         userFrom: json["user_from"],
//         userTo: json["user_to"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_university": userUniversity,
//         "user_degree": userDegree,
//         "user_from": userFrom,
//         "user_to": userTo,
//       };
// }
