import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sampleprovider/coin_base.dart';
import 'package:sampleprovider/data.dart';

class DataModel extends ChangeNotifier {
  static final DataModel _singleton = DataModel._internal();

  factory DataModel() {
    return _singleton;
  }

  DataModel._internal();

  List<Coin> _newCoin = [];

  List<Coin> get newCoin => _newCoin;

  void removeCoin(int data) {
    _newCoin.removeAt(data);
    // _newCoin.clear();
    notifyListeners();
  }

  Future<List<Coin>> basicCall() async {
    final http.Response response =
        await http.get(Uri.parse("https://api.coinlore.net/api/tickers/"));
    if (response.statusCode == 200) {
      print(response.body);
      final coinBase = CoinBase.fromJson(json.decode(response.body));
      // coinBaseFromJson(response.body);
      coinBase.data!.forEach((element) {
        _newCoin.add(element);
        notifyListeners();
      });
      return newCoin;
    }
    return newCoin;
  }
}
