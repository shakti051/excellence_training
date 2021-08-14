import 'package:flutter/foundation.dart';

class StateProvider with ChangeNotifier {
  int count = 0;
  int get getCount => count;
  incrementCount() {
    count++;
    notifyListeners();
  }
}
