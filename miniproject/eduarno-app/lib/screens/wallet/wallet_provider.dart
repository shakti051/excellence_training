import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier{
  String txnAmount = '';

  WalletProvider({this.txnAmount});

  String get getTxnAmount {
    return txnAmount;
  }

  set setTxnAmount(String utxnAmountrl) {
    this.txnAmount = txnAmount;
    notifyListeners();
  }

  String updateTxnAmount(String newTxnAmount) {
    txnAmount = newTxnAmount;
    print("txnAmount :  " + txnAmount);
    notifyListeners();
  }

}