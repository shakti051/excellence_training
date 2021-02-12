class WritersListModel {
  int status;
  List<WritersListData> data;

  WritersListModel({this.status, this.data});

  WritersListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<WritersListData>();
      json['data'].forEach((v) {
        data.add(new WritersListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WritersListData {
  int termTypeId;
  int objectId;
  int userUniqueId;
  String fullName;
  String email;
  String profileImg;
  String coverImg;
  String mobile;
  String followType;

  WritersListData(
      {this.termTypeId,
        this.objectId,
        this.userUniqueId,
        this.fullName,
        this.email,
        this.profileImg,
        this.coverImg,
        this.mobile,
        this.followType});

  WritersListData.fromJson(Map<String, dynamic> json) {
    termTypeId = json['termTypeId'];
    objectId = json['objectId'];
    userUniqueId = json['userUniqueId'];
    fullName = json['fullName'];
    email = json['email'];
    profileImg = json['profileImg'];
    coverImg = json['coverImg'];
    mobile = json['mobile'];
    followType = json['followType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['termTypeId'] = this.termTypeId;
    data['objectId'] = this.objectId;
    data['userUniqueId'] = this.userUniqueId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['profileImg'] = this.profileImg;
    data['coverImg'] = this.coverImg;
    data['mobile'] = this.mobile;
    data['followType'] = this.followType;
    return data;
  }
}