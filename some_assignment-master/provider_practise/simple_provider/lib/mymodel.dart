import 'package:flutter/material.dart';

class MyModel  extends ChangeNotifier{ //                                               <--- MyModel
  String _someValue = 'Hello';

  String get  getSomeValue => _someValue;
  void doSomething() {
    _someValue = 'Goodbye';
    notifyListeners();
  }
  
  String data = 'Some Data';
  void changeString(String newString) {
    data = newString;
    notifyListeners();
  }
}