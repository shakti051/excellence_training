import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  static final User _singleton = User._internal();

  factory User() {
    return _singleton;
  }

  User._internal();

  SharedPreferences prefs;
  String _userId;
  String _tempUserId;
  String _name;
  String _email;
  String _phone;
  bool _isNewUSer = false;
  bool _interestAdded = false;
  bool _isVerifiedOtp;
  bool _isAssessment = false;
  bool _isUpdateListener = false;
  bool _liveSessionTrigger = false;
  // String _whatsappNumber;
  // String _location;
  // String _pin;
  // String _state;
  // String _city;
  // String _accountNumber;
  // String _ifscCode;
  bool _isNewNotification;

  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _liveSessionTrigger = prefs.getBool('liveSessionTrigger');
    _tempUserId = prefs.getString('temp_userId');
    _isNewUSer = prefs.getBool('is_new_user');
    _name = prefs.getString('name');
    _email = prefs.getString('email');
    _phone = prefs.getString('phone');
    _interestAdded = prefs.getBool('isAssessmentTakeBynewUser');
    _isAssessment = prefs.getBool('isAssessment');
    _isUpdateListener = prefs.getBool('isUpdateListener');
    // _whatsappNumber = prefs.getString("whatsapp");
    // _location = prefs.getString("location");
    // _pin = prefs.getString("pin");
    // _state = prefs.getString("state");
    // _city = prefs.getString("city");
    // _accountNumber = prefs.getString("accountNumber");
    // _ifscCode = prefs.getString("ifscCode");
    _isNewNotification = prefs.getBool('is_notification');
    // _isNewUSer = false;
    // _interestAdded = false;
    notifyListeners();
  }

  bool get liveSessionTrigger => _liveSessionTrigger;
  // set liveSessionTrigger(bool value) {
  //   _liveSessionTrigger = value;
  //   prefs.setBool('liveSessionTrigger', value);
  //   notifyListeners();
  // }
  void setTrigger(bool value) {
    _liveSessionTrigger = value;
    prefs.setBool('liveSessionTrigger', value);
    notifyListeners();
  }

  bool get isUpdateListener => _isUpdateListener;
  set isUpdateListener(bool value) {
    _isUpdateListener = value;
    // notifyListeners();
  }

  bool get isAssessment => _isAssessment;
  set isAssessment(bool value) {
    _isAssessment = value;
    prefs.setBool('isAssessment', value);
    notifyListeners();
  }

  bool get isVerifiedOtp => _isVerifiedOtp;

  set isVerifiedOtp(bool value) {
    _isVerifiedOtp = value;
    notifyListeners();
  }

  /// isNewNotification
  bool get isNewNotification => _isNewNotification;

  set isNewNotification(bool value) {
    _isNewNotification = value;
    // Data.boolBox.put('isNewNotification', value);
    prefs.setBool('is_notification', value);
    notifyListeners();
  }

  bool get interestAdded => _interestAdded;

  set interestAdded(bool value) {
    _interestAdded = value;
    prefs.setBool('isAssessmentTakeBynewUser', value);
    notifyListeners();
  }

  bool get isNewUser => _isNewUSer;

  set isNewUser(bool value) {
    _isNewUSer = value;
    prefs.setBool('is_new_user', value);
    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    _updateString('email', value);
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
    _updateString('phone', value);
  }

  String get name => _name;

  set name(String value) {
    _name = value;
    _updateString('name', value);
  }

  String get userId => _userId;

  String get tempUserId => _tempUserId;

  set userId(String value) {
    _userId = value;
    _updateString('userId', value);
  }

  set tempUserId(String value) {
    _tempUserId = value;
    _updateString('temp_userId', value);
  }

  void _updateString(String key, String value) async {
    // Data.stringBox.put(key, value);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value).then((value) => {
          //print('user id isSave======> $value')
        });
    notifyListeners();
  }

// Future<bool> deleteFCMToken() async {
//   try {
//     final data = await callApi({"id": User().userId}, 'deleteTokenByUserId');
//
//     if (data['code'] == 200) {
//       return true;
//     }
//
//     return false;
//   } catch (e) {
//     ShowToast.show('Something went wrong!');
//     return false;
//   }
// }
}
