import 'dart:convert';
import 'package:eduarno/post.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/screens/wallet/wallet_listing_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletListService {
  Post _post = Post();
  Future<WalletListingModel> getWalletList() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    final apiUrl = 'https://eduarno1.herokuapp.com/wallet/wallet_listing';
    Map data = {
      'user_id': User().userId,
    };
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };
    return _post
        .post(Uri.parse(apiUrl), headers: header, body: json.encode(data))
        .then((dynamic res) async {
      return WalletListingModel.fromJson(res);
    });
  }
}
