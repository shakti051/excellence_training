import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';

enum appSatte { initSatte, buildSatte, disposeStatte }

class AppointmentsProvider extends ChangeNotifier {
  final Services _services = Services();
  AppointmentListModel? _appointmentListModel;

  bool _apiHit = false;
  bool get apiHit => _apiHit;
  appSatte _appState = appSatte.initSatte;
  appSatte get getAppState => _appState;
  AppointmentListModel get appointmentListModel => _appointmentListModel!;

  void appointListApi() {
    var body = {
      'client_mobile': VlccShared().mobileNum,
      'auth_token': VlccShared().authToken,
      'device_id': VlccShared().deviceId,
    };
    _services
        .callApi(body,
            '/api/api_client_appointment_list.php?request=client_appointment_list',
            apiName: 'appointment list')
        .then((value) {
      var testVal = value;
      _appointmentListModel = appointmentListModelFromJson(testVal);
      // log(_appointmentListModel.toString(), name: 'appointment list');
      _appState = appSatte.buildSatte;
      notifyListeners();
    });
  }

  delete(int index) {
    _appointmentListModel!.appointmentDetails!.removeAt(index);
    log("deleted at $index");
    notifyListeners();
  }
}
