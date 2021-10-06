import 'dart:convert';
import 'package:eduarno/post.dart';
import 'package:eduarno/screens/session/details_model/session_details_model.dart';
import 'package:eduarno/screens/session/session_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionDetailService {
  Post _post = Post();
  Future<SessionDetailModel> getSessionDetails({String request_id}) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String _userId = prefs.getString('userId');
    final apiUrl = 'https://eduarno1.herokuapp.com/session/session_details';
    Map data = {'user_id': _userId,
     "request_id": request_id};
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    return _post
        .post(Uri.parse(apiUrl), headers: header, body: json.encode(data))
        .then((dynamic res) async {
      print('userid>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + _userId);
      return SessionDetailModel.fromJson(res);
    });
  }
}
