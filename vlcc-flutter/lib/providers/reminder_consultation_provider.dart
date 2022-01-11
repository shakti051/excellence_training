import 'package:flutter/material.dart';

class ReminderConsultationProvider extends ChangeNotifier {
  bool _onTime = false;
  bool _fifteenMin = false;
  bool _oneHour = false;
  bool _oneDay = false;
  get getOnTime => _onTime;
  get getFifteen => _fifteenMin;
  get getOneHour => _oneHour;
  get getOneDay => _oneDay;

  void selectOnTime() {
    _onTime = true;
    _fifteenMin = false;
    _oneHour = false;
    _oneDay = false;
    notifyListeners();
  }

  void selectFifteenMin() {
    _onTime = false;
    _fifteenMin = true;
    _oneHour = false;
    _oneDay = false;
    notifyListeners();
  }

  void selectOneHour() {
    _onTime = false;
    _fifteenMin = false;
    _oneHour = true;
    _oneDay = false;
    notifyListeners();
  }

  void selectOneDay() {
    _onTime = false;
    _fifteenMin = false;
    _oneHour = false;
    _oneDay = true;
    notifyListeners();
  }
}
