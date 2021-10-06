import 'dart:convert';
import 'package:eduarno/post.dart';
import 'package:eduarno/screens/session/comment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentService {
  Post _post = Post();
    Future<CommentModel> getComment({String requestId,String comment,String imageUrl}) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String _userId = prefs.getString("userId");
    final apiUrl =
        "https://eduarno1.herokuapp.com/session/session_details/answers";
    Map data = {"user_id": _userId,
                "request_id": requestId,
                "tutor_comments":comment,
                "imgUrl":imageUrl
    };
    Map<String,String> header = {'Content-Type': 'application/json; charset=UTF-8'};
    return _post
        .post(Uri.parse(apiUrl),
            headers:header,
            body: json.encode(data))
        .then((dynamic res) async {            
        //  print("userid>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+_userId);
      return CommentModel.fromJson(res);
    });
  }
}
