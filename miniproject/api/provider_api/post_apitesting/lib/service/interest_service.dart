import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:post_apitesting/model/interest_model.dart';
import 'package:post_apitesting/post.dart';

class InterestService extends ChangeNotifier{
  static InterestService _instance;
  InterestService._();

  static InterestService get instance {
    if (_instance == null) {
      _instance = InterestService._();
    }
    return _instance;
  }
  
  Post _post = Post();
  Future<InterestModel> getInterest() async {
    final apiUrl =
        "https://eduarno1.herokuapp.com/user/interest_get_profile_user_by_id";
    Map<String,dynamic> data = {"user_id": "x9qR5kc4Q9vGyse7K"};
    Map<String,String> header = {'Content-Type': 'application/json; charset=UTF-8'};
    return _post
        .post(Uri.parse(apiUrl),
            headers: header,
            body: json.encode(data))
        .then((dynamic res) async {
      return InterestModel.fromJson(res);
    });
  }
}
