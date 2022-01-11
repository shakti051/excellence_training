import 'dart:developer';
import 'package:vlcc/models/signup_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import '../post.dart';

class SignupService {
  final Post _post = Post();
  String token = VlccShared().fcmToken;
  Future<SignupModel> getUserRegistered({
    String name = "",
    String mobile = "",
    String email = "",
    String deviceID = "",
  }) async {
    const apiUrl =
        "${Services.baseUrl}/api/api_client_signup.php?request=client_signup";
    Map<String, dynamic> data = {
      "client_name": name,
      "client_mobile": mobile,
      "client_email": email,
      "device_id": deviceID,
      "firebase_token": token
    };
    Map<String, String> _ = {'Content-Type': 'multipart/form-data'};
    return _post
        .post(Uri.parse(apiUrl),
            // headers: header,
            body: data)
        .then((dynamic res) async {
      log(res.toString(), name: "Response");
      return SignupModel.fromJson(res);
    });
  }
}
