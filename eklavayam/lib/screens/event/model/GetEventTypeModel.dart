class GetEventTypeModel {
  int status;
  List<EventTypeData> data;
  String message;

  GetEventTypeModel({this.status, this.data, this.message});

  GetEventTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<EventTypeData>();
      json['data'].forEach((v) {
        data.add(new EventTypeData.fromJson(v));
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

class EventTypeData {
  int termTypeId;
  int priority;
  String termText;

  EventTypeData({this.termTypeId, this.priority, this.termText});

  EventTypeData.fromJson(Map<String, dynamic> json) {
    termTypeId = json['termTypeId'];
    priority = json['priority'];
    termText = json['termText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['termTypeId'] = this.termTypeId;
    data['priority'] = this.priority;
    data['termText'] = this.termText;
    return data;
  }
}
