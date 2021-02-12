import 'package:eklavayam/screens/home/Bottomtabs/model/StoryfeedModel.dart';

class MyPostModel {
  int status;
  List<MyPostData> data;
  int count;
  String message;

  MyPostModel({this.status, this.data, this.count, this.message});

  MyPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<MyPostData>();
      json['data'].forEach((v) {
        data.add(new MyPostData.fromJson(v));
      });
    }
    count = json['count'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['message'] = this.message;
    return data;
  }
}

class  MyPostData {
  String image;
  List<Images> images;
  int contentType;
  String description;
  String id;
  int likes;
  String time;
  bool isFollow;
  bool isLiked;
  bool isCommentLike;
  MyPostUser user;
  //List<Null> comments;

  MyPostData(
      {this.image,
        this.images,
        this.contentType,
        this.description,
        this.id,
        this.likes,
        this.time,
        this.isFollow,
        this.isLiked,
        this.isCommentLike,
        this.user,
       // this.comments
      });

  MyPostData.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null && json['images'] != "") {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    image = json['image'];
    contentType = json['contentType'];
    description = json['description'];
    id = json['id'];
    likes = json['likes'];
    time = json['time'];
    isFollow = json['is_follow'];
    isLiked = json['is_liked'];
    isCommentLike = json['is_commentLike'];
    user = json['user'] != null ? new MyPostUser.fromJson(json['user']) : null;
    // if (json['comments'] != null) {
    //   comments = new List<Null>();
    //   json['comments'].forEach((v) {
    //     comments.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['images'] = this.images;
    data['contentType'] = this.contentType;
    data['description'] = this.description;
    data['id'] = this.id;
    data['likes'] = this.likes;
    data['time'] = this.time;
    data['is_follow'] = this.isFollow;
    data['is_liked'] = this.isLiked;
    data['is_commentLike'] = this.isCommentLike;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    // if (this.comments != null) {
    //   data['comments'] = this.comments.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class  MyPostUser {
  String profile;
  String name;

  MyPostUser({this.profile, this.name});

  MyPostUser.fromJson(Map<String, dynamic> json) {
    profile = json['profile'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile'] = this.profile;
    data['name'] = this.name;
    return data;
  }
}
