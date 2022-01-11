import 'package:flutter/material.dart';

class ReminderProvider extends ChangeNotifier {
  static final ReminderProvider _singleton = ReminderProvider._internal();

  factory ReminderProvider() {
    return _singleton;
  }

  ReminderProvider._internal();
  bool  _remind = false;
  bool _onTime = false;
  bool _fifteenMin = false;
  bool _oneHour = false;
  bool _oneDay = false;
  String  _reminderId  = '';
  List<String> _reminderAddedAt  = [];
  get reminderId => _reminderId;
  List<String> get reminderAddedAt => _reminderAddedAt;
  get getRemind => _remind;
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

  void setReminderIndex(String appointId) {
    _reminderId = appointId;
    _reminderAddedAt.add(appointId);
    notifyListeners();
 }

  void cancelReminderIndex(String appointId) {
    _reminderId = appointId;
    _reminderAddedAt.remove(appointId);
    notifyListeners();
 }

  void cancelRemind() {
    _remind = false;
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
