class NotificationModel {
  int status;
  List<NotificationData> data;
  String message;

  NotificationModel({this.status, this.data, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<NotificationData>();
      json['data'].forEach((v) {
        data.add(new NotificationData.fromJson(v));
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

class NotificationData {
  int uniqueId;
  int contentUserId;
  int userId;
  String contentText;
  Null targetObject;
  int targetObjectId;
  int type;
  int readOn;
  int notified;
  String fullName;
  String profileImg;

  NotificationData(
      {this.uniqueId,
        this.contentUserId,
        this.userId,
        this.contentText,
        this.targetObject,
        this.targetObjectId,
        this.type,
        this.readOn,
        this.notified,
        this.fullName,
        this.profileImg});

  NotificationData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    contentUserId = json['contentUserId'];
    userId = json['userId'];
    contentText = json['contentText'];
    targetObject = json['targetObject'];
    targetObjectId = json['targetObjectId'];
    type = json['type'];
    readOn = json['readOn'];
    notified = json['notified'];
    fullName = json['fullName'];
    profileImg = json['profileImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['contentUserId'] = this.contentUserId;
    data['userId'] = this.userId;
    data['contentText'] = this.contentText;
    data['targetObject'] = this.targetObject;
    data['targetObjectId'] = this.targetObjectId;
    data['type'] = this.type;
    data['readOn'] = this.readOn;
    data['notified'] = this.notified;
    data['fullName'] = this.fullName;
    data['profileImg'] = this.profileImg;
    return data;
  }
}
