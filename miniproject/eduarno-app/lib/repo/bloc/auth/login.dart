import 'dart:developer';

import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/repo/utils/network/callApi.dart';
import 'package:eduarno/widgets/toast.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider {
  /// signUp
  static Future<bool> signUp(
      String name, String email, String password, BuildContext context) async {
    final data = await callApi({
      "name": name,
      "email": email,
      "password": password,
    }, 'user-signup');

    //print('SignUp data = $data');

    if (data['code'] == 200) {
      User().userId = data['id'];
      User().name = name;
      User().email = email;
      User().isNewUser = true;
      ShowToast.show('OTP - ${data['otp']}', isError: false, isLong: true);

      return true;
    }

    ShowToast.show(data['message'] ?? 'Something Went wrong');

    return false;
  }

  /// signIn
  static Future<int> signIn(
      String email, String password, BuildContext context) async {
    var values = {"email": email, 'password': password};
    final data = await callApi(values, 'user-signin');

    // if (data['code'] == 200 && data['id'] != null) {
    //   User().userId = data['id'];
    //   User().name = data['name'];
    //   User().interestAdded = data['user_interst_status'];
    //   User().isVerifiedOtp = data['otp_status'];
    //   User().isAssessment = true;
    //   // User().isNewUser = false;
    //   // ShowToast.show('${data['message']}', isError: false, isLong: true);
    //   print(
    //       'User Interest after signin api ------------------------->${User().interestAdded}');
    //   print(
    //       'User verified after signin api ------------------------->${User().isVerifiedOtp}');

    //   if (User().isVerifiedOtp == true && User().interestAdded == true) {
    //     return 201;
    //   } else if (User().isVerifiedOtp == true &&
    //       User().interestAdded == false) {
    //     return 202;
    //   } else if (User().isVerifiedOtp == false) {
    //     return 203;
    //   }

    //   // return true;
    // }
    // ShowToast.show(data['message'] ?? 'Something Went wrong');
    // return 400;

    if (data['id'] != null) {
      switch (data['code']) {
        case 200:
          User().userId = data['id'];
          User().name = data['name'];
          User().isNewUser = true;
          User().interestAdded = data['user_interst_status'];
          User().isVerifiedOtp = data['otp_status'];
          User().isAssessment = data['assessment_given'];
          return 200;
          break;
        case 201:
          User().userId = data['id'];
          User().name = data['name'];
          User().isNewUser = true;
          User().interestAdded = data['user_interst_status'];
          User().isVerifiedOtp = data['otp_status'];
          User().isAssessment = data['assessment_given'];
          return 201;
          break;
        case 202:
          User().userId = data['id'];
          User().name = data['name'];
          User().isNewUser = true;
          User().interestAdded = data['user_interst_status'];
          User().isVerifiedOtp = data['otp_status'];
          User().isAssessment = data['assessment_given'];
          return 202;
          break;
        case 203:
          User().userId = data['id'];
          User().name = data['name'];
          User().isNewUser = true;
          User().interestAdded = data['user_interst_status'];
          User().isVerifiedOtp = data['otp_status'];
          User().isAssessment = data['assessment_given'];
          return 203;
          break;
        default:
          ShowToast.show(data['message'] ?? 'Something Went wrong');
          return 400;
      }
    }
  }

//200 : Sign in : true || otp : true || interest: true
//201 : OTP not verified
//202 : Otp verified true Interest status : false

  /// verifyOtp
  static Future<bool> verifyOtp(String otp, String userId) async {
    final data = await callApi({
      "otp": otp,
      "id": User().userId,
    }, 'user-check_otp');

    if (data['code'] == 200) {
      // if (User().name == null) {
      //   User().name = data['data'][0]['name'];
      // }

      return true;
    }
    ShowToast.show(data['message'] ?? 'Invalid OTP!');
    return false;
  }

  static Future<bool> forgotPassword(String email) async {
    final data = await callApi({
      "email": email,
    }, 'user-forgot_password');

    if (data['code'] == 200) {
      User().userId = data['id'];
      ShowToast.show(data['otp'] ?? 'Something Went wrong', isError: false);
      return true;
    }
    ShowToast.show(data['message'] ?? 'Something Went wrong');
    return false;
  }

  static Future<bool> createPassword(String id, String password) async {
    final data = await callApi({
      "id": id,
      "password": password,
    }, 'user-create_password');

    if (data['code'] == 200) {
      ShowToast.show(data['message'] ?? 'Something Went wrong',
          isError: false, isLong: true);
      return true;
    }
    ShowToast.show(data['message'] ?? 'Something Went wrong');
    return false;
  }

  /// resendOTP
// static Future<bool> resendOtp() async {
//   final data = await callApi({"id": User().userId}, 'resendOtp');
//
//   if (data['code'] == 200) {
//     ShowToast.show('OTP sent!\nOTP = ${data['data'][0]['otp']}',
//         isError: false, isLong: true);
//
//     return true;
//   }
//
//   ShowToast.show(data['message'] ?? 'Something Went wrong');
//
//   return false;
// }

  /// logOut
  static Future<void> logOut() async {
    // User().userId = '';
    // User().name = '';
    // User().phone = '';
    // User().isNewNotification = false;
    // User().isAssessment = false;
    // User().isNewUser = false;
    // User().isUpdateListener = false;
    // User().interestAdded = false;
    // User().isVerifiedOtp = false;
    // User().email = '';
    User().prefs.clear();
  }
}
