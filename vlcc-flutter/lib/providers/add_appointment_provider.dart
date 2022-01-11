import 'package:flutter/material.dart';

class AddAppointmentProvider extends ChangeNotifier {
  static final AddAppointmentProvider _singleton =
      AddAppointmentProvider._internal();

  factory AddAppointmentProvider() {
    return _singleton;
  }
  AddAppointmentProvider._internal();

  bool _onTime = false;
  bool _fifteenMin = false;
  bool _oneHour = false;
  bool _oneDay = false;
  get getOnTime => _onTime;
  get getFifteen => _fifteenMin;
  get getOneHour => _oneHour;
  get getOneDay => _oneDay;

  int _timerDuration = 0;
  int get timerDuration => _timerDuration;

  void selectOnTime() {
    _onTime = true;
    _fifteenMin = false;
    _oneHour = false;
    _oneDay = false;
    _timerDuration = 0;
    notifyListeners();
  }

  void selectFifteenMin() {
    _onTime = false;
    _fifteenMin = true;
    _oneHour = false;
    _oneDay = false;
    _timerDuration = 900;
    notifyListeners();
  }

  void selectOneHour() {
    _onTime = false;
    _fifteenMin = false;
    _oneHour = true;
    _oneDay = false;
    _timerDuration = 3600;
    notifyListeners();
  }

  void selectOneDay() {
    _onTime = false;
    _fifteenMin = false;
    _oneHour = false;
    _oneDay = true;
    _timerDuration = 24 * 60 * 60;
    notifyListeners();
  }
}
