import 'dart:convert';
import 'package:eduarno/post.dart';
import 'package:eduarno/repo/bloc/assessment/model/assessment_item.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AssessmentListService {
  // ignore: unused_field
  final Post _post = Post();
  Future<AssessmentItem> getTest() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String _userId = prefs.getString('userId');
    // String _userId = User().userId;
    final apiUrl =
        'https://eduarno1.herokuapp.com/user/post_assessment_list_new';
    Map data = {'user_id': _userId};
    var response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'}, body: json.encode(data));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return AssessmentItem.fromJson(body);
    }
    return AssessmentItem();
  }

  // Future<AssessmentItem> getTest() async {
  //   SharedPreferences prefs;
  //   prefs = await SharedPreferences.getInstance();
  //   String _userId = prefs.getString("userId");
  //   // String _userId = User().userId;
  //   Map data = {"user_id": _userId};
  //   final apiUrl = "https://eduarno1.herokuapp.com/user/post_assessment_list";
  //   final http.Response response = await http.post(Uri.parse(apiUrl),
  //       headers: {'Content-Type': 'application/json'}, body: json.encode(data));
  //   if(response.statusCode ==200){
  //     return AssessmentItem.fromJson(response.);
  //   }
  // }
}
