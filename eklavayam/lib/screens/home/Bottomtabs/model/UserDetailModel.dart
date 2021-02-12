class UserDetailModel {
  int status;
  List<UserDetailData> data;

  UserDetailModel({this.status, this.data});

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<UserDetailData>();
      json['data'].forEach((v) {
        data.add(new UserDetailData.fromJson(v));
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

class UserDetailData {
  int uniqueId;
  String mobile;
  String email;
  String fullName;
  String password;
  String profileImg;
  String coverImg;
  String aboutMe;
  String profileStatus;
  String passion;
  String description;
  int createdOn;
  int status;
  int mVerified;
  int eVerified;
  int isTrashed;
  String userType;
  int dob;
  var dod;
  String countryId;
  String stateId;
  String cityId;
  var socialFbId;
  var socialGmailId;
  var socialAppleId;
  String facebookURL;
  String twitterURL;
  String instagramURL;
  String linkedInURL;
  String youTubeURL;
  int themeMode;
  int writer;
  var language;
  var test;

  UserDetailData(
      {this.uniqueId,
        this.mobile,
        this.email,
        this.fullName,
        this.password,
        this.profileImg,
        this.coverImg,
        this.aboutMe,
        this.profileStatus,
        this.passion,
        this.description,
        this.createdOn,
        this.status,
        this.mVerified,
        this.eVerified,
        this.isTrashed,
        this.userType,
        this.dob,
        this.dod,
        this.countryId,
        this.stateId,
        this.cityId,
        this.socialFbId,
        this.socialGmailId,
        this.socialAppleId,
        this.facebookURL,
        this.twitterURL,
        this.instagramURL,
        this.linkedInURL,
        this.youTubeURL,
        this.themeMode,
        this.writer,
        this.language,
        this.test});

  UserDetailData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    mobile = json['mobile'];
    email = json['email'];
    fullName = json['fullName'];
    password = json['password'];
    profileImg = json['profileImg'];
    coverImg = json['coverImg'];
    aboutMe = json['aboutMe'];
    profileStatus = json['profileStatus'];
    passion = json['passion'];
    description = json['description'];
    createdOn = json['createdOn'];
    status = json['status'];
    mVerified = json['mVerified'];
    eVerified = json['eVerified'];
    isTrashed = json['isTrashed'];
    userType = json['userType'];
    dob = json['dob'];
    dod = json['dod'];
    countryId = json['countryId'];
    stateId = json['stateId'];
    cityId = json['cityId'];
    socialFbId = json['socialFbId'];
    socialGmailId = json['socialGmailId'];
    socialAppleId = json['socialAppleId'];
    facebookURL = json['facebookURL'];
    twitterURL = json['twitterURL'];
    instagramURL = json['instagramURL'];
    linkedInURL = json['linkedInURL'];
    youTubeURL = json['youTubeURL'];
    themeMode = json['themeMode'];
    writer = json['writer'];
    language = json['language'];
    test = json['test'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['password'] = this.password;
    data['profileImg'] = this.profileImg;
    data['coverImg'] = this.coverImg;
    data['aboutMe'] = this.aboutMe;
    data['profileStatus'] = this.profileStatus;
    data['passion'] = this.passion;
    data['description'] = this.description;
    data['createdOn'] = this.createdOn;
    data['status'] = this.status;
    data['mVerified'] = this.mVerified;
    data['eVerified'] = this.eVerified;
    data['isTrashed'] = this.isTrashed;
    data['userType'] = this.userType;
    data['dob'] = this.dob;
    data['dod'] = this.dod;
    data['countryId'] = this.countryId;
    data['stateId'] = this.stateId;
    data['cityId'] = this.cityId;
    data['socialFbId'] = this.socialFbId;
    data['socialGmailId'] = this.socialGmailId;
    data['socialAppleId'] = this.socialAppleId;
    data['facebookURL'] = this.facebookURL;
    data['twitterURL'] = this.twitterURL;
    data['instagramURL'] = this.instagramURL;
    data['linkedInURL'] = this.linkedInURL;
    data['youTubeURL'] = this.youTubeURL;
    data['themeMode'] = this.themeMode;
    data['writer'] = this.writer;
    data['language'] = this.language;
    data['test'] = this.test;
    return data;
  }
}
