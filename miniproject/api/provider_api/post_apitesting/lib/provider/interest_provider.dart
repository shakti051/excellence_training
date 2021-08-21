import 'package:flutter/material.dart';

class InterestProvider extends ChangeNotifier {
  bool apiHit = false;
  bool get getAPiHit => apiHit;

  toggleDone() {
    apiHit = true;
    notifyListeners();
  }

// void deleteTask(Task task){
//         _tasks.remove(task);
//         notifyListeners();
//    }

}
