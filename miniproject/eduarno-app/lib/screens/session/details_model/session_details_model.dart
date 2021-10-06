class SessionDetailModel {
  String message;
  List<Datas> datas;
  int code;

  SessionDetailModel({this.message, this.datas, this.code});

  SessionDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['datas'] != null) {
      datas = new List<Datas>();
      json['datas'].forEach((v) {
        datas.add(new Datas.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Datas {
  String sId;
  String student;
  String specialisation;
  String topic;
  String requestType;
  String requestLevel;
  String sessionId;
  String rating;
  String noOfLiveSessionQuestions;
  String timeDurationForLiveSession;
  String content;
  String timeline;
  String fileUrl;
  String currency;
  String totalAmount;
  String paymentRecieved;
  String paymentStatus;
  String duePayment;
  String comment;
  List<TutorInfo> tutorInfo;
  String requestStatus;
  int isCreated;
  List<Reply> reply;

  Datas(
      {this.sId,
      this.student,
      this.specialisation,
      this.topic,
      this.requestType,
      this.requestLevel,
      this.sessionId,
      this.rating,
      this.noOfLiveSessionQuestions,
      this.timeDurationForLiveSession,
      this.content,
      this.timeline,
      this.fileUrl,
      this.currency,
      this.totalAmount,
      this.paymentRecieved,
      this.paymentStatus,
      this.duePayment,
      this.comment,
      this.tutorInfo,
      this.requestStatus,
      this.isCreated,
      this.reply});

  Datas.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    student = json['student'];
    specialisation = json['specialisation'];
    topic = json['topic'];
    requestType = json['request_type'];
    requestLevel = json['request_level'];
    sessionId = json['session_id'];
    rating = json['rating'];
    noOfLiveSessionQuestions = json['no_of_live_session_questions'];
    timeDurationForLiveSession = json['time_duration_for_live_session'];
    content = json['content'];
    timeline = json['timeline'];
    fileUrl = json['FileUrl'];
    currency = json['currency'];
    totalAmount = json['totalAmount'];
    paymentRecieved = json['paymentRecieved'];
    paymentStatus = json['payment_status'];
    duePayment = json['due_payment'];
    comment = json['comment'];
    if (json['tutorInfo'] != null) {
      tutorInfo = new List<TutorInfo>();
      json['tutorInfo'].forEach((v) {
        tutorInfo.add(new TutorInfo.fromJson(v));
      });
    }
    requestStatus = json['request_status'];
    isCreated = json['isCreated'];
    if (json['reply'] != null) {
      reply = new List<Reply>();
      json['reply'].forEach((v) {
        reply.add(new Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['student'] = this.student;
    data['specialisation'] = this.specialisation;
    data['topic'] = this.topic;
    data['request_type'] = this.requestType;
    data['request_level'] = this.requestLevel;
    data['session_id'] = this.sessionId;
    data['rating'] = this.rating;
    data['no_of_live_session_questions'] = this.noOfLiveSessionQuestions;
    data['time_duration_for_live_session'] = this.timeDurationForLiveSession;
    data['content'] = this.content;
    data['timeline'] = this.timeline;
    data['FileUrl'] = this.fileUrl;
    data['currency'] = this.currency;
    data['totalAmount'] = this.totalAmount;
    data['paymentRecieved'] = this.paymentRecieved;
    data['payment_status'] = this.paymentStatus;
    data['due_payment'] = this.duePayment;
    data['comment'] = this.comment;
    if (this.tutorInfo != null) {
      data['tutorInfo'] = this.tutorInfo.map((v) => v.toJson()).toList();
    }
    data['request_status'] = this.requestStatus;
    data['isCreated'] = this.isCreated;
    if (this.reply != null) {
      data['reply'] = this.reply.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TutorInfo {
  String tutorName;
  String tutorId;
  List<String> tutorSpecialisation;
  bool tutorChecked;

  TutorInfo(
      {this.tutorName,
      this.tutorId,
      this.tutorSpecialisation,
      this.tutorChecked});

  TutorInfo.fromJson(Map<String, dynamic> json) {
    tutorName = json['tutor_name'];
    tutorId = json['tutor_id'];
    tutorSpecialisation = json['tutor_specialisation'].cast<String>();
    tutorChecked = json['tutor_checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tutor_name'] = this.tutorName;
    data['tutor_id'] = this.tutorId;
    data['tutor_specialisation'] = this.tutorSpecialisation;
    data['tutor_checked'] = this.tutorChecked;
    return data;
  }
}

class Reply {
  String userId;
  String tutorComments;
  String answerFile;

  Reply({this.userId, this.tutorComments, this.answerFile});

  Reply.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    tutorComments = json['tutor_comments'];
    answerFile = json['answerFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['tutor_comments'] = this.tutorComments;
    data['answerFile'] = this.answerFile;
    return data;
  }
}