import 'dart:convert';
import 'package:eduarno/post.dart';
import 'package:eduarno/screens/session/session_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  Post _post = Post();
    Future<SessionListModule> getSessionlist() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String _userId = prefs.getString('userId');
    final apiUrl =
        'https://eduarno1.herokuapp.com/session/session_listing';
    Map data = {'user_id': _userId};
    Map<String,String> header = {'Content-Type': 'application/json; charset=UTF-8'};
    return _post
        .post(Uri.parse(apiUrl),
            headers:header,
            body: json.encode(data))
        .then((dynamic res) async {  
          print('userid>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+_userId);
      return SessionListModule.fromJson(res);
    });
  }
}
