import 'dart:convert';
import 'package:practise_bloc/model/profile/profileDetails.dart';
import 'package:practise_bloc/services/post.dart';
import 'package:practise_bloc/services/sstorageutil.dart';

class UpdateBankDetails {
  Post _post = Post();
  Future<ProfileDetails> updateBankDetails(String accountNo, String bankAddress,
      String bankName, String ifsc) async {
    final prodUrl = "https://apistaginghr.excellencetechnologies.in/attendance/sal_info/api.php";
    var token = StorageUtil.getUserToken();
    final apiUrl = prodUrl;
    Map data = {
      "action": "update_user_bank_detail",
      "token": token,
      "bank_account_no": accountNo,
      "bank_address": bankAddress,
      "bank_name": bankName,
      "ifsc": ifsc
    };
    return _post
        .post(apiUrl, body: json.encode(data))
        .then((dynamic res) async {
      if (res["error"] >= 1) throw new Exception(res["data"]["message"]);

      return ProfileDetails.fromJson(res);
    });
  }
}
