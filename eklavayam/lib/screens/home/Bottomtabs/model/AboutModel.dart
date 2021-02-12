class AboutModel {
  int status;
  AboutData data;
  String message;

  AboutModel({this.status, this.data, this.message});

  AboutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new AboutData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class AboutData {
  List<BookData> bookData;
  List<AchievementData> achievementData;
  List<AwardData> awardData;
  List<VideoData> videoData;

  AboutData({this.bookData, this.achievementData, this.awardData, this.videoData});

  AboutData.fromJson(Map<String, dynamic> json) {
    if (json['bookData'] != null) {
      bookData = new List<BookData>();
      json['bookData'].forEach((v) { bookData.add(new BookData.fromJson(v)); });
    }
    if (json['achievementData'] != null) {
      achievementData = new List<AchievementData>();
      json['achievementData'].forEach((v) { achievementData.add(new AchievementData.fromJson(v)); });
    }
    if (json['awardData'] != null) {
      awardData = new List<AwardData>();
      json['awardData'].forEach((v) { awardData.add(new AwardData.fromJson(v)); });
    }
    if (json['videoData'] != null) {
      videoData = new List<VideoData>();
      json['videoData'].forEach((v) { videoData.add(new VideoData.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookData != null) {
      data['bookData'] = this.bookData.map((v) => v.toJson()).toList();
    }
    if (this.achievementData != null) {
      data['achievementData'] = this.achievementData.map((v) => v.toJson()).toList();
    }
    if (this.awardData != null) {
      data['awardData'] = this.awardData.map((v) => v.toJson()).toList();
    }
    if (this.videoData != null) {
      data['videoData'] = this.videoData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookData {
  int uniqueId;
  String title;
  String description;
  String images;
  String link;
  int createdOn;

  BookData({this.uniqueId, this.title, this.description, this.images, this.link, this.createdOn});

  BookData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    title = json['title'];
    description = json['description'];
    images = json['images'];
    link = json['link'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['images'] = this.images;
    data['link'] = this.link;
    data['createdOn'] = this.createdOn;
    return data;
  }
}

class AchievementData {
  int uniqueId;
  String title;
  String description;
  String images;
  String link;
  int createdOn;
  List<OtherInfo> otherInfo;

  AchievementData({this.uniqueId, this.title, this.description, this.images, this.link, this.createdOn, this.otherInfo});

  AchievementData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    title = json['title'];
    description = json['description'];
    images = json['images'];
    link = json['link'];
    createdOn = json['createdOn'];
    if (json['otherInfo'] != null) {
      otherInfo = new List<OtherInfo>();
      json['otherInfo'].forEach((v) { otherInfo.add(new OtherInfo.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['images'] = this.images;
    data['link'] = this.link;
    data['createdOn'] = this.createdOn;
    if (this.otherInfo != null) {
      data['otherInfo'] = this.otherInfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AwardData {
  int uniqueId;
  String title;
  String description;
  String images;
  String link;
  int createdOn;
  List<OtherInfo> otherInfo;

  AwardData({this.uniqueId, this.title, this.description, this.images, this.link, this.createdOn, this.otherInfo});

  AwardData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    title = json['title'];
    description = json['description'];
    images = json['images'];
    link = json['link'];
    createdOn = json['createdOn'];
    if (json['otherInfo'] != null) {
      otherInfo = new List<OtherInfo>();
      json['otherInfo'].forEach((v) { otherInfo.add(new OtherInfo.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['images'] = this.images;
    data['link'] = this.link;
    data['createdOn'] = this.createdOn;
    if (this.otherInfo != null) {
      data['otherInfo'] = this.otherInfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OtherInfo {
  String other_class;
  int value;

  OtherInfo({this.other_class, this.value});

  OtherInfo.fromJson(Map<String, dynamic> json) {
    other_class = json['class'];
  value = json['value'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['class'] = this.other_class;
  data['value'] = this.value;
  return data;
  }
}

class VideoData {
  int uniqueId;
  String title;
  String description;
  String images;
  String link;
  int createdOn;
  String html;
  List<OtherInfo> otherInfo;

  VideoData({this.uniqueId, this.title, this.description, this.images, this.link, this.createdOn, this.html, this.otherInfo});

  VideoData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    title = json['title'];
    description = json['description'];
    images = json['images'];
    link = json['link'];
    createdOn = json['createdOn'];
    html = json['html'];
    if (json['otherInfo'] != null) {
      otherInfo = new List<OtherInfo>();
      json['otherInfo'].forEach((v) { otherInfo.add(new OtherInfo.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['images'] = this.images;
    data['link'] = this.link;
    data['createdOn'] = this.createdOn;
    data['html'] = this.html;
    if (this.otherInfo != null) {
      data['otherInfo'] = this.otherInfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
