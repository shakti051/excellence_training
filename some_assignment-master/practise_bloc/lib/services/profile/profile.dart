import 'dart:convert';
import 'package:practise_bloc/model/profile/profileDetails.dart';
import 'package:practise_bloc/services/post.dart';
import 'package:practise_bloc/services/sstorageutil.dart';

class Profile {
  Post _post = Post();
  Future<ProfileDetails> getprofile() async {
    final prodUrl =
        "https://apistaginghr.excellencetechnologies.in/attendance/sal_info/api.php";
    var token = StorageUtil.getUserToken();
    print("Token in profile");
    print(token.toString());
    final apiUrl = prodUrl;
    Map data = {"action": "get_user_profile_detail", "token": token};
    return _post
        .post(apiUrl, body: json.encode(data))
        .then((dynamic res) async {
      if (res["error"] >= 1) throw new Exception(res["data"]["message"]);
      return ProfileDetails.fromJson(res);
    });
  }
}