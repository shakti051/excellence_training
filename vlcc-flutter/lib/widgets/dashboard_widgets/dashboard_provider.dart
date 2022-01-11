import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/models/general_appointment_list.dart';
import 'package:vlcc/models/profile_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/apiHandler/api_url/api_url.dart';

class DashboardProvider extends ChangeNotifier {
  static final DashboardProvider _singleton = DashboardProvider._internal();

  factory DashboardProvider() {
    return _singleton;
  }

  DashboardProvider._internal();
  VlccShared sharedPrefs = VlccShared();
  final Services _services = Services();

  ProfileModel _profileModel = ProfileModel(
      clientProfileDetails:
          ClientProfileDetails(clientDateofBirth: DateTime.now()));

  ProfileModel get profileModel => _profileModel;

  AppointmentListModel _allAppointmentList = AppointmentListModel();
  AppointmentListModel get allAppointmentList => _allAppointmentList;
  set allAppointmentList(AppointmentListModel value) {
    _allAppointmentList = value;
    notifyListeners();
  }

  List<AppointmentDetail> _generalAppointmentList = [];
  List<AppointmentDetail> get generalAppointmentList => _generalAppointmentList;
  set generalAppointmentList(List<AppointmentDetail> value) {
    _generalAppointmentList = value;
    notifyListeners();
  }

  List<AppointmentDetail> _videoAppointmentList = [];
  List<AppointmentDetail> get videoAppointmentList => _videoAppointmentList;
  set videoAppointmentList(List<AppointmentDetail> value) {
    _videoAppointmentList = value;
    notifyListeners();
  }

  bool _bannerApiHit = true;
  bool get bannerApiHit => _bannerApiHit;
  set bannerApiHit(bool val) {
    _bannerApiHit = val;
    notifyListeners();
  }

  Future<GeneralAppointmentList> getGeneralAppointmentList() async {
    var body = {
      'auth_token': sharedPrefs.authToken,
      'client_mobile': sharedPrefs.mobileNum,
      'device_id': sharedPrefs.deviceId,
    };
    final response = await _services.callApi(
      body,
      ApiUrl.generalAppointmentListUrl,
      apiName: 'General appointment list',
    );
    var jsonTest = json.decode(response);
    if (jsonTest['Status'] == 2000) {
      final generalAppointmentModel =
          generalAppointmentListModelFromJson(response);
      return generalAppointmentModel;
    } else {
      return GeneralAppointmentList();
    }
  }

  Future<void> getAppointmentList() async {
    var body = {
      'auth_token': sharedPrefs.authToken,
      'client_mobile': sharedPrefs.mobileNum,
      'device_id': sharedPrefs.deviceId,
    };
    final response = await _services.callApi(
      body,
      ApiUrl.apppointmentListUrl,
      apiName: 'RBS appointment list',
    );
    var jsonTest = json.decode(response);
    if (jsonTest['Status'] == 2000) {
      final appointmentListModel = appointmentListModelFromJson(response);
      final getGeneralAppointment = await getGeneralAppointmentList();
      for (var generalAppointment
          in getGeneralAppointment.appointmentDetails!) {
        appointmentListModel.appointmentDetails!.add(
          AppointmentDetail(
            appointmentId: generalAppointment.appointmentId,
            centerName: generalAppointment.centerName,
            centerCode: generalAppointment.centerCode,
            bookingNumber: generalAppointment.bookingNumber,
            clientId: generalAppointment.clientId,
            appointmentRemark: generalAppointment.appointmentRemark,
            areaName: generalAppointment.areaName,
            cityName: generalAppointment.cityName,
            centerLatitude: generalAppointment.centerLatitude,
            centerLongitude: generalAppointment.centerLongitude,
            addressLine1: generalAppointment.addressLine1,
            addressLine2: generalAppointment.addressLine2,
            addressLine3: generalAppointment.addressLine3,
            appointmentDate: generalAppointment.appointmentDate,
            appointmentTime: generalAppointment.appointmentStartTime,
            appointmentStartDateTime:
                generalAppointment.appointmentStartDateTime,
            appointmentStatus: generalAppointment.appointmentStatus,
            appointmentAttDoc: generalAppointment.appointmentAttDoc,
            serviceName:
                generalAppointment.appointmentServiceDtl!.first.serviceName,
            stateName: generalAppointment.stateName,
            centerMap: generalAppointment.centerMap,
            appointmentType: generalAppointment.appointmentType,
            appointmentRoom: generalAppointment.appointmentRoom,
            appointmentToken: generalAppointment.appointmentToken,
          ),
        );
      }
      _allAppointmentList = appointmentListModel;
      _generalAppointmentList = appointmentListModel.appointmentDetails!
          .where((element) =>
              element.appointmentType == 'General' &&
              isAfterToday(element.appointmentDate ?? DateTime.now()))
          .toList();
      _videoAppointmentList = appointmentListModel.appointmentDetails!
          .where(
            (element) =>
                element.appointmentType != 'General' &&
                isAfterToday(
                  element.appointmentDate ?? DateTime.now(),
                ),
          )
          .toList();
      notifyListeners();
    }
  }

  bool isAfterToday(DateTime date) {
    return (DateTime.now().day == date.day) || date.isAfter(DateTime.now());
  }

  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;

  bool _isAmPm = true;
  bool get isAmPm => _isAmPm;
  set isAmPm(bool val) {
    _isAmPm = val;
    notifyListeners();
  }

  String _centerName = '';
  String get centerName => _centerName;
  set centerName(String val) {
    _centerName = val;
    notifyListeners();
  }

  set bottomNavIndex(int val) {
    _bottomNavIndex = val;
    notifyListeners();
  }

  int _sliderIndex = 0;
  int get getSliderIndex => _sliderIndex;

  void getProfileDetails() {
    var body = {
      'auth_token': sharedPrefs.authToken,
      'client_mobile': sharedPrefs.mobileNum,
      'device_id': sharedPrefs.deviceId,
    };
    _services
        .callApi(body, '/api/api_client_profile.php?request=client_profile',
            apiName: 'Profile details')
        .then((value) {
      var _profileValueTest = value;
      log(value.toString(), name: 'profile');
      var jsonTest = json.decode(value);
      if (jsonTest['Status'] == 2000) {
        _profileModel = profileModelFromJson(_profileValueTest);
        sharedPrefs.name = _profileModel.clientProfileDetails.clientName;
        sharedPrefs.email = _profileModel.clientProfileDetails.clientEmailid;
        sharedPrefs.profileImage =
            _profileModel.clientProfileDetails.clientProfilePic;
      }
      notifyListeners();
    });
  }

  void updateSliderIndex(int index) {
    _sliderIndex = index;
    notifyListeners();
  }
}
