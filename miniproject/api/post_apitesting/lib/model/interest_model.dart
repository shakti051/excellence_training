class InterestModel {
  String message;
  List<Data> data;
  int code;

  InterestModel({this.message, this.data, this.code});

  InterestModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String specialiation;
  List<String> topic;

  Data({this.specialiation, this.topic});

  Data.fromJson(Map<String, dynamic> json) {
    specialiation = json['specialiation'];
    topic = json['topic'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specialiation'] = this.specialiation;
    data['topic'] = this.topic;
    return data;
  }
}