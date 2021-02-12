class LikesModel {
  int status;
  List<LikesData> data;
  String message;

  LikesModel({this.status, this.data, this.message});

  LikesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<LikesData>();
      json['data'].forEach((v) {
        data.add(new LikesData.fromJson(v));
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

class  LikesData {
  int uniqueId;
  int contentId;
  int contentType;
  int likeType;
  int userId;
  int createdOn;
  String fullName;
  bool writer;
  int userUniqueId;
  String profileImg;
  String profileStatus;
  String isFollow;

  LikesData(
      {this.uniqueId,
        this.contentId,
        this.contentType,
        this.likeType,
        this.userId,
        this.createdOn,
        this.fullName,
        this.writer,
        this.userUniqueId,
        this.profileImg,
        this.profileStatus,
        this.isFollow});

  LikesData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    contentId = json['contentId'];
    contentType = json['contentType'];
    likeType = json['likeType'];
    userId = json['userId'];
    createdOn = json['createdOn'];
    fullName = json['fullName'];
    writer = json['writer'];
    userUniqueId = json['userUniqueId'];
    profileImg = json['profileImg'];
    profileStatus = json['profileStatus'];
    isFollow = json['isFollow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['contentId'] = this.contentId;
    data['contentType'] = this.contentType;
    data['likeType'] = this.likeType;
    data['userId'] = this.userId;
    data['createdOn'] = this.createdOn;
    data['fullName'] = this.fullName;
    data['writer'] = this.writer;
    data['userUniqueId'] = this.userUniqueId;
    data['profileImg'] = this.profileImg;
    data['profileStatus'] = this.profileStatus;
    data['isFollow'] = this.isFollow;
    return data;
  }
}
