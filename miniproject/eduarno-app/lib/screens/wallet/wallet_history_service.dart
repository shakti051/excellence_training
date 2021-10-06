import 'dart:convert';
import 'package:eduarno/post.dart';
import 'package:eduarno/screens/wallet/wallet_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletHistoryService {
  Post _post = Post();
  Future<WalletHistoryModel> getWithdrawlist() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String _userId = prefs.getString("userId");
    final apiUrl = "https://api.razorpay.com/v1/orders";
    Map<String, dynamic> data = {
      "amount": 5000,
      "currency": "INR",
      "receipt": "receipt_001"
    };
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    return _post
        .post(Uri.parse(apiUrl), headers: header, body: json.encode(data))
        .then((dynamic res) async {
      return WalletHistoryModel.fromJson(res);
    });
  }
}
