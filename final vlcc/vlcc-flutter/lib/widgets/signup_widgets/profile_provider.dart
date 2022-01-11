import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/assets_path.dart';

class ProfileProvider extends ChangeNotifier {
  static final ProfileProvider _singleton = ProfileProvider._internal();

  factory ProfileProvider() {
    return _singleton;
  }
  ProfileProvider._internal();

  bool maleColored = false;
  bool femaleColored = false;
  bool commonColored = false;
  bool _showDates = false;
  DateTime _currentDate = DateTime.now();
  String _profileImage = '';
  File _image = File(PNGAsset.avatar);
  String _gender = '';
  List<bool> _renewPackagePass = [];
  File _bookAppointmentAttachment = File('');
  File get bookAppointmentAttachment => _bookAppointmentAttachment;
  List<bool> get renewPackagePass => _renewPackagePass;
  File get image => _image;
  String get gender => _gender;
  String get profileImage => _profileImage;
  get getmaleColored => maleColored;
  get getfemaleColored => femaleColored;
  get getcommonColored => commonColored;
  get getShowDates => _showDates;
  final VlccShared sharedPrefs = VlccShared();
  final Services _services = Services();

  DateTime get getCurrentDate => _currentDate;

  bool _isUpdateChanged = false;
  bool get isUpdateChanged => _isUpdateChanged;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set isUpdateChanged(bool val) {
    _isUpdateChanged = val;
    notifyListeners();
  }

  String _servicePrice = '';
  String get servicePrice => _servicePrice;
  set servicePrice(String val) {
    _servicePrice = val;
    notifyListeners();
  }

  Future<void> setServicePriceApi(
      {required String centerCode,
      required String serviceCode,
      required String serviceType}) async {
    var body = {
      'client_mobile': sharedPrefs.mobileNum,
      'device_id': sharedPrefs.deviceId,
      'auth_token': sharedPrefs.authToken,
      'service_code': serviceCode,
      'service_type': serviceType,
      'center_code': centerCode,
    };
    _services
        .callApi(body, '/api/api_price_list.php?request=price_list')
        .then((value) {
      var jsonTest = json.decode(value);
      if (jsonTest['Status'] == 2000) {
        if (jsonTest['ServicePrice'] == null ||
            jsonTest['ServicePrice'].toString().toLowerCase() == 'null') {
          _servicePrice = '';
        } else {
          _servicePrice = jsonTest['ServicePrice'][0]['ServicePrice'];
          notifyListeners();
        }
      }
    });
  }

  set bookAppointmentAttachment(File file) {
    _bookAppointmentAttachment = file;
    notifyListeners();
  }

  set image(File image) {
    _image = image;
    notifyListeners();
  }

  void setPackageFinalRenewStatus({required int index, required bool value}) {
    _renewPackagePass[index] = value;
    notifyListeners();
  }

  void setPackageRenewStatus({required List<bool> renewList}) {
    _renewPackagePass = renewList;
    notifyListeners();
  }

  // set renewPackagePass(bool value) {
  //   _renewPackagePass = value;
  //   notifyListeners();
  // }

  set profileImage(String imagePath) {
    _profileImage = imagePath;
    notifyListeners();
  }

  void selectMale() {
    _gender = 'Male';
    maleColored = true;
    femaleColored = false;
    commonColored = false;
    notifyListeners();
  }

  void selectFemale() {
    _gender = 'Female';
    maleColored = false;
    femaleColored = true;
    commonColored = false;
    notifyListeners();
  }

  void selectCommon() {
    _gender = 'Common';
    maleColored = false;
    femaleColored = false;
    commonColored = true;
    notifyListeners();
  }

  void updateDate(DateTime selDate) {
    _currentDate = selDate;
    _showDates = true;
    notifyListeners();
  }
}
