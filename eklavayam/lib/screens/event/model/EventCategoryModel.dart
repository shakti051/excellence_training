class EventCategoryModel {
  int status;
  List<EventCategoryData> data;
  String message;

  EventCategoryModel({this.status, this.data, this.message});

  EventCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<EventCategoryData>();
      json['data'].forEach((v) {
        data.add(new EventCategoryData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class EventCategoryData {
  String termText;
  int termTypeId;
  bool value;

  EventCategoryData({this.termText, this.termTypeId, this.value});

  EventCategoryData.fromJson(Map<String, dynamic> json) {
    termText = json['termText'];
    termTypeId = json['termTypeId'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['termText'] = this.termText;
    data['termTypeId'] = this.termTypeId;
    data['value'] = this.value;
    return data;
  }
}
