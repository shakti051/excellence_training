import 'dart:convert';

AssessmentResultResponse assessmentResultResponseFromJson(String str) =>
    AssessmentResultResponse.fromJson(json.decode(str));

String assessmentResultResponseToJson(AssessmentResultResponse data) =>
    json.encode(data.toJson());

class AssessmentResultResponse {
  AssessmentResultResponse({
    this.message,
    this.code,
    this.data,
  });

  String message;
  int code;
  List<Datum> data;

  factory AssessmentResultResponse.fromJson(Map<String, dynamic> json) =>
      AssessmentResultResponse(
        message: json['message'],
        code: json['code'],
        data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.userId,
    this.assessmentId,
    this.totalQuestions,
    this.correctQuestions,
    this.totalNotAnswered,
    this.incorrectQuestions,
    // this.percentage,
    this.result,
    this.notificationId,
  });

  String userId;
  String assessmentId;
  String totalQuestions;
  int correctQuestions;
  int totalNotAnswered;
  int incorrectQuestions;
  // double percentage;
  String result;
  String notificationId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json['user_id'],
        assessmentId: json['assessment_id'],
        totalQuestions: json['total_questions'],
        correctQuestions: json['correct_questions'],
        totalNotAnswered: json['total_not_answered'],
        incorrectQuestions: json['incorrect_questions'],
        // percentage: json['percentage'],
        result: json['result'],
        notificationId: json['notification_id'],
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'assessment_id': assessmentId,
        'total_questions': totalQuestions,
        'correct_questions': correctQuestions,
        'total_not_answered': totalNotAnswered,
        'incorrect_questions': incorrectQuestions,
        // 'percentage': percentage,
        'result': result,
        'notification_id': notificationId,
      };
}
