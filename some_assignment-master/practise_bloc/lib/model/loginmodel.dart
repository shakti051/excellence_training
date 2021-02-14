class LoginModel {
  int error;
  Data data;

  LoginModel({this.error, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String token;
  String userid;
  String message;

  Data({this.token, this.userid, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userid = json['userid'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userid'] = this.userid;
    data['message'] = this.message;
    return data;
  }
}
