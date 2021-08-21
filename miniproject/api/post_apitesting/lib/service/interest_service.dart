import 'dart:convert';
import 'package:post_apitesting/model/interest_model.dart';
import 'package:post_apitesting/post.dart';

class InterestService {
  Post _post = Post();
  Future<InterestModel> getInterest() async {
    final apiUrl =
        "https://eduarno1.herokuapp.com/user/interest_get_profile_user_by_id";
    Map<String,dynamic> data = {"user_id": "B8hhjxATrqCvYzk6g"};
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
