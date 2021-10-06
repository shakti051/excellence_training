class AllSpecialisation {
  String message;
  List<Data> data;
  int code;

  AllSpecialisation({this.message, this.data, this.code});

  AllSpecialisation.fromJson(Map<String, dynamic> json) {
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
  String sId;
  String specialisationId;
  String specialisation;
  int createdAt;
  bool isActive;
  int updatedAt;

  Data(
      {this.sId,
      this.specialisationId,
      this.specialisation,
      this.createdAt,
      this.isActive,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    specialisationId = json['specialisation_id'];
    specialisation = json['specialisation'];
    createdAt = json['created_at'];
    isActive = json['is_active'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['specialisation_id'] = this.specialisationId;
    data['specialisation'] = this.specialisation;
    data['created_at'] = this.createdAt;
    data['is_active'] = this.isActive;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}