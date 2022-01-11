import 'package:flutter/material.dart';

class ConsultationProvider with ChangeNotifier {
  bool _videoCall = true;
  bool _audioCall = false;
  get getVideo => _videoCall;
  get getAudio => _audioCall;

  void selectAudio() {
    _audioCall = true;
    _videoCall = false;
    notifyListeners();
  }

  void selectVideo() {
    _audioCall = false;
    _videoCall = true;
    notifyListeners();
  }
}
