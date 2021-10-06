import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  static show(String msg, {bool isError = true, bool isLong = false}) {
    Fluttertoast.showToast(
        toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        msg: msg,
        backgroundColor: isError ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
