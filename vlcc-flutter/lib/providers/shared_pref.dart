import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlcc/database/db_helper.dart';

class VlccShared extends ChangeNotifier {
  static final VlccShared _singleton = VlccShared._internal();

  factory VlccShared() {
    return _singleton;
  }

  VlccShared._internal();

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late SharedPreferences prefs;
  String _fcmToken = '';
  String _deviceId = '';
  bool _isSignupProfileComplete = false;
  bool _isExpert = false;
  String _mobileNum = '';
  String _authToken = '';
  String _name = '';
  String _email = '';
  String _profileImage = '';
  int _serviceApiCount = 0;
  int _centerApiCount = 0;
  String _empCode = '';
  bool? isFirstTimeLogin;
  String localityString = '...';
  String subLocalityString = '';

  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    _isSignupProfileComplete =
        prefs.getBool('isSignupProfileComplete') ?? false;
    _isExpert = prefs.getBool('isExpert') ?? false;
    _fcmToken = prefs.getString('fcmToken') ?? '';
    _deviceId = prefs.getString('_deviceId') ?? '';
    _mobileNum = prefs.getString('_mobileNum') ?? '';
    _authToken = prefs.getString('_authToken') ?? '';
    _name = prefs.getString('_name') ?? '';
    _serviceApiCount = prefs.getInt('_serviceApiCount') ?? 0;
    _centerApiCount = prefs.getInt('_centerApiCount') ?? 0;
    _empCode = prefs.getString('_empCode') ?? '';
    notifyListeners();
  }

  isFirstTimeLoginOnDevice({required bool withValue}) async {
    prefs.setBool(SharedPreferencesKey.isFirstTimeLogin, withValue);
    isFirstTimeLogin =
        prefs.getBool(SharedPreferencesKey.isFirstTimeLogin) ?? true;
  }

  locality({required String withValue}) async {
    prefs.setString(SharedPreferencesKey.locality, withValue);
    localityString = prefs.getString(SharedPreferencesKey.locality) ?? '';
  }

  subLocality({required String withValue}) async {
    prefs.setString(SharedPreferencesKey.subLocality, withValue);
    subLocalityString = prefs.getString(SharedPreferencesKey.subLocality) ?? '';
  }

  bool get isSignupProfileComplete => _isSignupProfileComplete;
  bool get isExpert => _isExpert;
  String get fcmToken => _fcmToken;
  String get deviceId => _deviceId;
  String get mobileNum => _mobileNum;
  String get authToken => _authToken;
  String get name => _name;
  String get email => _email;
  String get profileImage => _profileImage;
  int get serviceApiCount => _serviceApiCount;
  int get centerApiCount => _centerApiCount;
  String get employeCode => _empCode;

  set serviceApiCount(int value) {
    _serviceApiCount = value;
    prefs.setInt('_serviceApiCount', value);
    notifyListeners();
  }

  set centerApiCount(int value) {
    _centerApiCount = value;
    prefs.setInt('_centerApiCount', value);
    notifyListeners();
  }

  set isSignupProfileComplete(bool val) {
    _isSignupProfileComplete = val;
    prefs.setBool('isSignupProfileComplete', val);
    notifyListeners();
  }

  set isExpert(bool val) {
    _isExpert = val;
    prefs.setBool('isExpert', val);
    notifyListeners();
  }

  set name(String val) {
    _name = val;
    notifyListeners();
  }

  

  set email(String val) {
    _email = val;
    notifyListeners();
  }

  set profileImage(String val) {
    _profileImage = val;
    notifyListeners();
  }

  static String get testToken =>
      '5f77eccdd6fe5dd3969963f1e1e3199efd98ea16dd860982d91a44497fca6a22';
  static String get testDeviceId => 'c15c10fc9aa65615';
  static String get testMobileNo => '9717393656';

  set fcmToken(String token) {
    _fcmToken = token;
    prefs.setString('fcmToken', token);
    notifyListeners();
  }

  void setdeviceId(String id) async {
    _deviceId = id;
    log(id, name: 'Device Id');
    prefs.setString('_deviceId', id);
    notifyListeners();
  }

  void setMobileNum(String phone) async {
    _mobileNum = phone;
    prefs.setString('_mobileNum', phone);
    notifyListeners();
  }

  void setEmployeeCode(String empCode) async {
    _empCode = empCode;
    prefs.setString('_empCode', empCode);
    notifyListeners();
  }

  void setName(String name) async {
    _name = name;
    prefs.setString('_name', name);
    notifyListeners();
  }
  
  void setAuthToken(String token) async {
    _authToken = token;
    prefs.setString('_authToken', token);
    log(_authToken, name: 'Auth token');
    notifyListeners();
  }

  Future<bool> signOut() async {
    var clear = await prefs.clear();
    _databaseHelper.removeDatabase();
    Get.deleteAll(force: true);
    notifyListeners();
    return clear;
  }
}

class SharedPreferencesKey {
  static String isFirstTimeLogin = 'isFirstTimeLogin';
  static String locality = 'locality';
  static String subLocality = 'subLocality';
}
