import 'dart:convert';
import 'package:practise_bloc/model/loginmodel.dart';
import 'package:practise_bloc/services/post.dart';
import 'package:practise_bloc/services/sstorageutil.dart';

final apikey = null;
Post _post = Post();
Future<LoginModel> fetchData(String username, String password) async {
  final url =
      'https://apistaginghr.excellencetechnologies.in/attendance/API_HR/api.php';
  Map data = {
    "token": apikey,
    "action": "login",
    "username": username,
    "password": password
  };
  return _post
      .post(url, body: json.encode(data))
      .then((dynamic response) async {
    if (response["error"] >= 1)
      throw new Exception(response["data"]["message"]);
    if (response["error"] == 0) {
      StorageUtil.setUserName(username);
      StorageUtil.setPassword(password);
      StorageUtil.setUserToken(response["data"]["token"]);
      StorageUtil.setUserId(response["data"]["userid"]);
      StorageUtil.setLoggedIn(true);
    }
    return LoginModel.fromJson(response);
  });
}
