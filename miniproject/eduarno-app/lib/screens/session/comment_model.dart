class CommentModel {
  String message;
  List<Datas> datas;
  int code;

  CommentModel({this.message, this.datas, this.code});

  CommentModel.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String tutorComments;
  String answerFile;

  Datas({this.userId, this.tutorComments, this.answerFile});

  Datas.fromJson(Map<String, dynamic> json) {
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