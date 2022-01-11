import 'package:flutter/material.dart';

class ExploreClinicsProvider extends ChangeNotifier {
  bool _fiveKm = false;
  bool _thirtyKm = false;
  bool _fiftyKm = false;
  bool _hundredKm = false;

  get fiveKm => _fiveKm;
  get thirtyKm => _thirtyKm;
  get fiftyKm => _fiftyKm;
  get hundredKm => _hundredKm;

  void selectFive() {
    _fiveKm = true;
    _thirtyKm = false;
    _fiftyKm = false;
    _hundredKm = false;
    notifyListeners();
  }

  void selectThirty() {
    _fiveKm = false;
    _thirtyKm = true;
    _fiftyKm = false;
    _hundredKm = false;
    notifyListeners();
  }

  void selectFifty() {
    _fiveKm = false;
    _thirtyKm = false;
    _fiftyKm = true;
    _hundredKm = false;
    notifyListeners();
  }

  void selectHundred() {
    _fiveKm = false;
    _thirtyKm = false;
    _fiftyKm = false;
    _hundredKm = true;
    notifyListeners();
  }
}
