class FollowersProfileModel {
  int status;
  List<FollowersData> data;
  String message;

  FollowersProfileModel({this.status, this.data, this.message});

  FollowersProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<FollowersData>();
      json['data'].forEach((v) {
        data.add(new FollowersData.fromJson(v));
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

class FollowersData {
  int uniqueId;
  int userId;
  int followerId;
  int createdOn;
  String fullName;
  Null aboutMe;
  String email;
  String mobile;
  Null language;
  String profileImg;
  String cityId;
  int writer;
  int dob;

  FollowersData(
      {this.uniqueId,
        this.userId,
        this.followerId,
        this.createdOn,
        this.fullName,
        this.aboutMe,
        this.email,
        this.mobile,
        this.language,
        this.profileImg,
        this.cityId,
        this.writer,
        this.dob});

  FollowersData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    userId = json['userId'];
    followerId = json['followerId'];
    createdOn = json['createdOn'];
    fullName = json['fullName'];
    aboutMe = json['aboutMe'];
    email = json['email'];
    mobile = json['mobile'];
    language = json['language'];
    profileImg = json['profileImg'];
    cityId = json['cityId'];
    writer = json['writer'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['userId'] = this.userId;
    data['followerId'] = this.followerId;
    data['createdOn'] = this.createdOn;
    data['fullName'] = this.fullName;
    data['aboutMe'] = this.aboutMe;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['language'] = this.language;
    data['profileImg'] = this.profileImg;
    data['cityId'] = this.cityId;
    data['writer'] = this.writer;
    data['dob'] = this.dob;
    return data;
  }
}
