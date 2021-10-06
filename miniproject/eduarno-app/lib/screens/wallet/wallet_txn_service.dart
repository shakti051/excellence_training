import 'dart:convert';
import 'package:eduarno/post.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/screens/wallet/wallet_transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletTxnService {
  Post _post = Post();
  Future<WalletTrasanctionModel> getWalletTxn({String txnAmount}) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    final apiUrl = 'https://eduarno1.herokuapp.com/wallet/wallet_transaction';
    Map data = {
      'user_id': User().userId,
      'transaction_type': 'withdraw',
      'transaction_amount': '500'
    };
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    return _post
        .post(Uri.parse(apiUrl), headers: header, body: json.encode(data))
        .then((dynamic res) async {
      return WalletTrasanctionModel.fromJson(res);
    });
  }
}