class SessionListModule {
  String message;
  List<Datas> datas;
  int code;

  SessionListModule({this.message, this.datas, this.code});

  SessionListModule.fromJson(Map<String, dynamic> json) {
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
  String content;
  String timeline;
  String totalAmount;
  String paymentRecieved;
  String paymentStatus;
  String duePayment;
  String requestStatus;
  int isCreated;
  String currency;
  List<TutorInfo> tutorInfo;
  String noOfLiveSessionQuestions;
  String comment;
  String timeDurationForLiveSession;
  String fileUrl;

  Datas(
      {this.sId,
      this.student,
      this.specialisation,
      this.topic,
      this.requestType,
      this.requestLevel,
      this.sessionId,
      this.rating,
      this.content,
      this.timeline,
      this.totalAmount,
      this.paymentRecieved,
      this.paymentStatus,
      this.duePayment,
      this.requestStatus,
      this.isCreated,
      this.currency,
      this.tutorInfo,
      this.noOfLiveSessionQuestions,
      this.comment,
      this.timeDurationForLiveSession,
      this.fileUrl});

  Datas.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    student = json['student'];
    specialisation = json['specialisation'];
    topic = json['topic'];
    requestType = json['request_type'];
    requestLevel = json['request_level'];
    sessionId = json['session_id'];
    rating = json['rating'];
    content = json['content'];
    timeline = json['timeline'];
    totalAmount = json['totalAmount'];
    paymentRecieved = json['paymentRecieved'];
    paymentStatus = json['payment_status'];
    duePayment = json['due_payment'];
    requestStatus = json['request_status'];
    isCreated = json['isCreated'];
    currency = json['currency'];
    if (json['tutorInfo'] != null) {
      tutorInfo = new List<TutorInfo>();
      json['tutorInfo'].forEach((v) {
        tutorInfo.add(new TutorInfo.fromJson(v));
      });
    }
    noOfLiveSessionQuestions = json['no_of_live_session_questions'];
    comment = json['comment'];
    timeDurationForLiveSession = json['time_duration_for_live_session'];
    fileUrl = json['FileUrl'];
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
    data['content'] = this.content;
    data['timeline'] = this.timeline;
    data['totalAmount'] = this.totalAmount;
    data['paymentRecieved'] = this.paymentRecieved;
    data['payment_status'] = this.paymentStatus;
    data['due_payment'] = this.duePayment;
    data['request_status'] = this.requestStatus;
    data['isCreated'] = this.isCreated;
    data['currency'] = this.currency;
    if (this.tutorInfo != null) {
      data['tutorInfo'] = this.tutorInfo.map((v) => v.toJson()).toList();
    }
    data['no_of_live_session_questions'] = this.noOfLiveSessionQuestions;
    data['comment'] = this.comment;
    data['time_duration_for_live_session'] = this.timeDurationForLiveSession;
    data['FileUrl'] = this.fileUrl;
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