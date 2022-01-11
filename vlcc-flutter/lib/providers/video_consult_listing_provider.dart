import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:vlcc/models/video_consult_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';

enum appSate { initSatte, buildSatte, disposeStatte }

class VideoConsultListingProvider extends ChangeNotifier {
  final Services _services = Services();
  VideoConsultModel? _videoConsultModel;
  bool _apiHit = false;
  bool get apiHit => _apiHit;
  appSate _appState = appSate.initSatte;
  appSate get getAppState => _appState;
  VideoConsultModel get videoConsultModel => _videoConsultModel!;

  void videoConsultApi() {
    // ignore: lines_longer_than_80_chars
    var body = {
      'client_mobile': VlccShared().mobileNum,
      'auth_token': VlccShared().authToken,
      'device_id': VlccShared().deviceId,
    };
    _services
        .callApi(body,
            '/api_client_appointment_video_consultations_list.php?request=client_appointment_list',
            apiName: 'video consult list')
        .then((value) {
      var testVal = value;
      _videoConsultModel = videoConsultModelFromJson(testVal);
      log(_videoConsultModel.toString(), name: 'video consult');
      _appState = appSate.buildSatte;
      notifyListeners();
    });
  }
}
