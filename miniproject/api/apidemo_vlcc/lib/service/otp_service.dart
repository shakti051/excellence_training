import 'dart:convert';
import 'package:apidemo_vlcc/model/otp_model.dart';
import 'package:apidemo_vlcc/post.dart';

class OTPService {
  Post _post = Post();
  Future<OTPModel> getOTPMobile() async {
    const apiUrl =
        "http://lms.vlccwellness.com/api/api_client_signin.php?request=login_otp";
    Map<String,dynamic> data = {"login_mobile": "9811641705",
    "device_id": "00000000-89ABCDEF-01234567-89ABCDEF"
    };
    Map<String,String> header = {'Content-Type': 'multipart/form-data'};
    return _post
        .post(Uri.parse(apiUrl),
           // headers: header,
            body: data)
        .then((dynamic res) async {
          print(res);
      return OTPModel.fromJson(res);
    });
  }
}