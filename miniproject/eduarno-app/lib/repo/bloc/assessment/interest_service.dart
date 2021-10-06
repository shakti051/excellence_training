import 'dart:convert';
import 'package:eduarno/post.dart';
import 'package:eduarno/repo/bloc/assessment/model/interest_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterestService {
  Post _post = Post();
  Future<InterestModel> getInterest() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String _userId = prefs.getString('userId');
    final apiUrl =
        'https://eduarno1.herokuapp.com/user/interest_get_profile_user_by_id';
    Map data = {'user_id': _userId};

    return _post
        .post(Uri.parse(apiUrl),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(data))
        .then((dynamic res) async {
      //   print("User_id:" + _userId);
      return InterestModel.fromJson(res);
    });
  }
}
