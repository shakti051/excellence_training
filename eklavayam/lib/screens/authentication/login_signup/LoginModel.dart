class LoginModel {
  int status;
  LoginData data;
  String token;
  String message;

  LoginModel({this.status, this.data, this.token, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}

class LoginData {
  int uniqueId;
  String mobile;
  String email;
  String fullName;
  String password;
  String profileImg;
  String coverImg;
  String aboutMe;
  int createdOn;
  int status;
  int mVerified;
  int eVerified;
  int isTrashed;
  String userType;
  var dob;
  String dod;
  String countryId;
  String stateId;
  String cityId;
  String socialFbId;
  String socialGmailId;
  String socialAppleId;
  int themeMode;
  int writer;
  String language;
  String test;

  LoginData(
      {this.uniqueId,
        this.mobile,
        this.email,
        this.fullName,
        this.password,
        this.profileImg,
        this.coverImg,
        this.aboutMe,
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
        this.themeMode,
        this.writer,
        this.language,
        this.test});

  LoginData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    mobile = json['mobile'];
    email = json['email'];
    fullName = json['fullName'];
    password = json['password'];
    profileImg = json['profileImg'];
    coverImg = json['coverImg'];
    aboutMe = json['aboutMe'];
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
    data['themeMode'] = this.themeMode;
    data['writer'] = this.writer;
    data['language'] = this.language;
    data['test'] = this.test;
    return data;
  }
}











// class LoginModel {
//   int status;
//   List<LoginData> data;
//   String token;
//
//   LoginModel({this.status, this.data, this.token});
//
//   LoginModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = new List<LoginData>();
//       json['data'].forEach((v) {
//         data.add(new LoginData.fromJson(v));
//       });
//     }
//     token = json['token'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     data['token'] = this.token;
//     return data;
//   }
// }
//
// class LoginData {
//   int uniqueId;
//   String mobile;
//   String email;
//   String fullName;
//   String password;
//   Null profileImg;
//   Null coverImg;
//   Null aboutMe;
//   int createdOn;
//   int status;
//   int mVerified;
//   int eVerified;
//   int isTrashed;
//   String userType;
//   Null dob;
//   Null dod;
//   String countryId;
//   String stateId;
//   String cityId;
//   Null socialFbId;
//   Null socialGmailId;
//   int themeMode;
//   int writer;
//   Null language;
//   Null test;
//
//   LoginData(
//       {this.uniqueId,
//         this.mobile,
//         this.email,
//         this.fullName,
//         this.password,
//         this.profileImg,
//         this.coverImg,
//         this.aboutMe,
//         this.createdOn,
//         this.status,
//         this.mVerified,
//         this.eVerified,
//         this.isTrashed,
//         this.userType,
//         this.dob,
//         this.dod,
//         this.countryId,
//         this.stateId,
//         this.cityId,
//         this.socialFbId,
//         this.socialGmailId,
//         this.themeMode,
//         this.writer,
//         this.language,
//         this.test});
//
//   LoginData.fromJson(Map<String, dynamic> json) {
//     uniqueId = json['uniqueId'];
//     mobile = json['mobile'];
//     email = json['email'];
//     fullName = json['fullName'];
//     password = json['password'];
//     profileImg = json['profileImg'];
//     coverImg = json['coverImg'];
//     aboutMe = json['aboutMe'];
//     createdOn = json['createdOn'];
//     status = json['status'];
//     mVerified = json['mVerified'];
//     eVerified = json['eVerified'];
//     isTrashed = json['isTrashed'];
//     userType = json['userType'];
//     dob = json['dob'];
//     dod = json['dod'];
//     countryId = json['countryId'];
//     stateId = json['stateId'];
//     cityId = json['cityId'];
//     socialFbId = json['socialFbId'];
//     socialGmailId = json['socialGmailId'];
//     themeMode = json['themeMode'];
//     writer = json['writer'];
//     language = json['language'];
//     test = json['test'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['uniqueId'] = this.uniqueId;
//     data['mobile'] = this.mobile;
//     data['email'] = this.email;
//     data['fullName'] = this.fullName;
//     data['password'] = this.password;
//     data['profileImg'] = this.profileImg;
//     data['coverImg'] = this.coverImg;
//     data['aboutMe'] = this.aboutMe;
//     data['createdOn'] = this.createdOn;
//     data['status'] = this.status;
//     data['mVerified'] = this.mVerified;
//     data['eVerified'] = this.eVerified;
//     data['isTrashed'] = this.isTrashed;
//     data['userType'] = this.userType;
//     data['dob'] = this.dob;
//     data['dod'] = this.dod;
//     data['countryId'] = this.countryId;
//     data['stateId'] = this.stateId;
//     data['cityId'] = this.cityId;
//     data['socialFbId'] = this.socialFbId;
//     data['socialGmailId'] = this.socialGmailId;
//     data['themeMode'] = this.themeMode;
//     data['writer'] = this.writer;
//     data['language'] = this.language;
//     data['test'] = this.test;
//     return data;
//   }
// }
