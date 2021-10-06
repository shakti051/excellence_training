import 'package:flutter/material.dart';
import 'constants.dart';

class AppSettings extends ChangeNotifier {
  Color _appColor = Colors.teal;

  Color get appColor => _appColor;

  void updateColor(int index) {
    _appColor = Constants.colors[index];
    notifyListeners();
  }
}
