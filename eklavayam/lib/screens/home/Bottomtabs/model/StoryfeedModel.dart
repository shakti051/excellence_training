class StoryfeedModel {
  int status;
  List<StoryfeedData> data;
  int count;

  StoryfeedModel({this.status, this.data, this.count});

  StoryfeedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<StoryfeedData>();
      json['data'].forEach((v) {
        data.add(new StoryfeedData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class StoryfeedData {
  List<Images> images;
  String description;
  int contentType;

  String title;
  bool likeShow;
  bool commentShow;
  bool shareShow ;
  String timeSince;

  String id;
  int contentUniqueId;
  int likes;
  String time;
  int postTime;
  bool isFollow;
  bool isLiked;
  var isLikedType;
  bool isCommentLike;
  StoryfeedDataUser user;
  List<StoryfeedComments> comments;

  StoryfeedData(
      {this.images,
        this.description,
        this.contentType,

        this.title,
        this.likeShow,
        this.commentShow,
        this.shareShow,
        this.timeSince,

        this.id,
        this.contentUniqueId,
        this.likes,
        this.time,
        this.postTime,
        this.isFollow,
        this.isLiked,
        this.isLikedType,
        this.isCommentLike,
        this.user,
        this.comments});

  StoryfeedData.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null && json['images'] != "") {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    description = json['description'];
    contentType = json['contentType'];

    title=        json['title'];
    likeShow=json['likeShow'];
    commentShow=json['commentShow'];
    shareShow=json['shareShow'];
    timeSince=json['timeSince'];

    id = json['id'];
    contentUniqueId = json['contentUniqueId'];
    likes = json['likes'];
    time = json['time'];
    postTime = json['postTime'];
    isFollow = json['is_follow'];
    isLiked = json['is_liked'];
    isLikedType = json['is_liked_Type'];
    isCommentLike = json['is_commentLike'];
    user = json['user'] != null ? new StoryfeedDataUser.fromJson(json['user']) : null;
    if (json['comments'] != null) {
      comments = new List<StoryfeedComments>();
      json['comments'].forEach((v) {
        comments.add(new StoryfeedComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['description'] = this.description;
    data['contentType'] = this.contentType;

   data['title']= title;
   data['likeShow']= likeShow;
   data['commentShow']= commentShow;
   data['shareShow']= shareShow;
   data['timeSince']= timeSince;

    data['id'] = this.id;
    data['contentUniqueId'] = this.contentUniqueId;
    data['likes'] = this.likes;
    data['time'] = this.time;
    data['postTime'] = this.postTime;
    data['is_follow'] = this.isFollow;
    data['is_liked'] = this.isLiked;
    data['is_liked_Type'] = this.isLikedType;
    data['is_commentLike'] = this.isCommentLike;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Images {
  String imgUrl;

  Images({this.imgUrl});

  Images.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}

class StoryfeedDataUser {
  String profile;
  String name;

  StoryfeedDataUser({this.profile, this.name});

  StoryfeedDataUser.fromJson(Map<String, dynamic> json) {
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

class StoryfeedComments {
  String image;
  int commentId;
  bool commentBox;
  bool isCommentLike;
  int isCommentLikes;
  CommentsUser user;
  List<ReplyCommentData> replyCommentData;

  StoryfeedComments(
      {this.image,
        this.commentId,
        this.commentBox,
        this.isCommentLike,
        this.isCommentLikes,
        this.user,
        this.replyCommentData});

  StoryfeedComments.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    commentId = json['commentId'];
    commentBox = json['commentBox'];
    isCommentLike = json['is_commentLike'];
    isCommentLikes = json['is_commentLikes'];
    user = json['user'] != null ? new CommentsUser.fromJson(json['user']) : null;
    if (json['replyCommentData'] != null) {
      replyCommentData = new List<ReplyCommentData>();
      json['replyCommentData'].forEach((v) {
        replyCommentData.add(new ReplyCommentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['commentId'] = this.commentId;
    data['commentBox'] = this.commentBox;
    data['is_commentLike'] = this.isCommentLike;
    data['is_commentLikes'] = this.isCommentLikes;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.replyCommentData != null) {
      data['replyCommentData'] =
          this.replyCommentData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentsUser {
  String name;
  String msg;
  String id;
  String time;

  CommentsUser({this.name, this.msg, this.id, this.time});

  CommentsUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    msg = json['msg'];
    id = json['id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['msg'] = this.msg;
    data['id'] = this.id;
    data['time'] = this.time;
    return data;
  }
}

class ReplyCommentData {
  String image;
  int commentId;
  bool isCommentLike;
  int isCommentLikes;
  CommentsUser user;

  ReplyCommentData(
      {this.image,
        this.commentId,
        this.isCommentLike,
        this.isCommentLikes,
        this.user});

  ReplyCommentData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    commentId = json['commentId'];
    isCommentLike = json['is_commentLike'];
    isCommentLikes = json['is_commentLikes'];
    user = json['user'] != null ? new CommentsUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['commentId'] = this.commentId;
    data['is_commentLike'] = this.isCommentLike;
    data['is_commentLikes'] = this.isCommentLikes;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}







////////////////////////////////////////////

// class StoryfeedModel {
//   int status;
//   List<StoryfeedData> data;
//   int count;
//
//   StoryfeedModel({this.status, this.data, this.count});
//
//   StoryfeedModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = new List<StoryfeedData>();
//       json['data'].forEach((v) {
//         data.add(new StoryfeedData.fromJson(v));
//       });
//     }
//     count = json['count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     data['count'] = this.count;
//     return data;
//   }
// }
//
// class StoryfeedData {
//   List<String> images;
//   String image;
//   String description;
//   String id;
//   int contentUniqueId;
//   int likes;
//   String time;
//   bool isFollow;
//   bool isLiked;
//   bool isCommentLike;
//   StoryfeedDataUser user;
//   List<StoryfeedComments> comments;
//
//   StoryfeedData(
//       {this.images,
//         this.image,
//         this.description,
//         this.id,
//         this.contentUniqueId,
//         this.likes,
//         this.time,
//         this.isFollow,
//         this.isLiked,
//         this.isCommentLike,
//         this.user,
//         this.comments});
//
//   StoryfeedData.fromJson(Map<String, dynamic> json) {
//     images = json['images'];
//     image = json['image'];
//     description = json['description'];
//     id = json['id'];
//     contentUniqueId = json['contentUniqueId'];
//     likes = json['likes'];
//     time = json['time'];
//     isFollow = json['is_follow'];
//     isLiked = json['is_liked'];
//     isCommentLike = json['is_commentLike'];
//     user = json['user'] != null ? new StoryfeedDataUser.fromJson(json['user']) : null;
//     if (json['comments'] != null) {
//       comments = new List<StoryfeedComments>();
//       json['comments'].forEach((v) {
//         comments.add(new StoryfeedComments.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['images'] = this.images;
//     data['image'] = this.image;
//     data['description'] = this.description;
//     data['id'] = this.id;
//     data['contentUniqueId'] = this.contentUniqueId;
//     data['likes'] = this.likes;
//     data['time'] = this.time;
//     data['is_follow'] = this.isFollow;
//     data['is_liked'] = this.isLiked;
//     data['is_commentLike'] = this.isCommentLike;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     if (this.comments != null) {
//       data['comments'] = this.comments.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class StoryfeedDataUser {
//   String profile;
//   String name;
//
//   StoryfeedDataUser({this.profile, this.name});
//
//   StoryfeedDataUser.fromJson(Map<String, dynamic> json) {
//     profile = json['profile'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['profile'] = this.profile;
//     data['name'] = this.name;
//     return data;
//   }
// }
//
// class StoryfeedComments {
//   String image;
//   bool isCommentLike;
//   CommentsUser user;
//
//   StoryfeedComments({this.image, this.isCommentLike, this.user});
//
//   StoryfeedComments.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//     isCommentLike = json['is_commentLike'];
//     user = json['user'] != null ? new CommentsUser.fromJson(json['user']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image'] = this.image;
//     data['is_commentLike'] = this.isCommentLike;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     return data;
//   }
// }
//
// class CommentsUser {
//   String name;
//   String msg;
//   String time;
//
//   CommentsUser({this.name, this.msg, this.time});
//
//   CommentsUser.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     msg = json['msg'];
//     time = json['time'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['msg'] = this.msg;
//     data['time'] = this.time;
//     return data;
//   }
// }
