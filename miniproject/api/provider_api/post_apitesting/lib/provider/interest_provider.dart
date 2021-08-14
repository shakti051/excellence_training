import 'package:flutter/material.dart';
import 'package:post_apitesting/model/interest_model.dart';

class InterestProvider extends ChangeNotifier{

  bool  apiHit = false;
  bool get getAPiHit => apiHit;
  InterestModel _interestModel;
  InterestModel get getInterestList => _interestModel;
  String skill = "";

     toggleDone() {
    apiHit = true;
    notifyListeners();
  }
    setInterestList(InterestModel interestModel, {bool notify = true}) {
    _interestModel = interestModel;
    if (notify) notifyListeners();
  }


   RemoveSkill(int index) {
     _interestModel.data.removeAt(index);
    notifyListeners();
  }
  


// void deleteTask(Task task){
//         _tasks.remove(task);
//         notifyListeners();
//    }

}