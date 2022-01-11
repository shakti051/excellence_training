import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/expert/expert_bottom_nav.dart';
import 'package:vlcc/main.dart';
import 'package:vlcc/models/center_master_model.dart';
import 'package:vlcc/models/expert_profile_model.dart';
import 'package:vlcc/models/login_exp_model.dart';
import 'package:vlcc/models/loginexp_token_model.dart';
import 'package:vlcc/models/resend_otp.dart';
import 'package:vlcc/models/service_master_model.dart';
import 'package:vlcc/models/verify_otp_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/bottom_bar/bottom_bar.dart';
import 'package:vlcc/screens/sign_up/profile_screen.dart';
import 'package:vlcc/widgets/database_loading.dart';

class ExpertOtpScreen extends StatefulWidget {
  String? enterOtp, mobileNum, name;
  bool registerd;
  ExpertOtpScreen(
      {Key? key,
      this.enterOtp = '123456',
      this.mobileNum = '1234567890',
      this.name = 'vikas',
      this.registerd = false})
      : super(key: key);

  @override
  _ExpertOtpScreenState createState() => _ExpertOtpScreenState();
}

class _ExpertOtpScreenState extends State<ExpertOtpScreen> {
  late OTPTextEditController _pinPutController;
  final _pinPutFocusNode = FocusNode();
  String otp = '';
  final Services _services = Services();
  LoginExpModel? loginExpModel;
  ResendOtpModel? _resendotpModel;
  //VerifyOtpModel? _verifyOtpModel;
  final VlccShared _vlccSharedPrefs = VlccShared();
  bool updateMobile = true;
  LoginExpTokenExp? loginExpTokenExp;
  ExertProfileModel? _exertProfileModel;
  String empCode = '';
  String empName = '';
  void expertProfileAPI() {
    var body = {
      'auth_token': VlccShared().authToken,
      'staff_mobile': VlccShared().mobileNum,
      'device_id': Provider.of<VlccShared>(context, listen: false).deviceId,
    };
    _services
        .callApi(body, '/api/api_staff_list.php?request=staff_list',
            apiName: 'Get Expert Profile')
        .then((value) {
      _exertProfileModel = exertProfileModelFromJson(value);
      if (_exertProfileModel!.status == 2000) {
        empCode = _exertProfileModel!.staffDetails!.staffcode!;
        empName = _exertProfileModel!.staffDetails!.staffname!;
        Provider.of<VlccShared>(context, listen: false)
            .setEmployeeCode(empCode);
        Provider.of<VlccShared>(context, listen: false).setName(empName);
      }
    });
  }

  Future<void> verifyOtp() async {
    var body = {
      'login_mobile': _vlccSharedPrefs.mobileNum,
      'device_id': _vlccSharedPrefs.deviceId,
      'firebase_token': _vlccSharedPrefs.fcmToken,
      'expert_otp': widget.enterOtp,
    };
    _services
        .callApi(body, '/api/api_expert_token.php?request=login_token',
            apiName: 'expert LoginToken')
        .then((value) {
      log(value.toString(), name: 'otp');
      var testVal = value;
      loginExpTokenExp = loginExpTokenExpFromJson(testVal);
      if (loginExpTokenExp!.status == 2000) {
        String token = loginExpTokenExp!.tokenInfo!.authToken!;
        _vlccSharedPrefs.setAuthToken(token);
        _vlccSharedPrefs.name = loginExpTokenExp?.tokenInfo?.expertName ?? '';
        _vlccSharedPrefs.email = loginExpTokenExp?.tokenInfo?.expertName ?? '';
        expertProfileAPI();
      }
    });
  }

  void recendOTPCall() {
    var body = {
      'login_mobile': VlccShared().mobileNum,
      'device_id': Provider.of<VlccShared>(context, listen: false).deviceId,
      'firebase_token':
          Provider.of<VlccShared>(context, listen: false).fcmToken,
    };
    _services
        .callApi(body, '/api/api_expert_signin.php?request=login_otp',
            apiName: 'Resend OTP')
        .then((value) {
      var testVal = value;
      try {
        loginExpModel = loginExpModelFromJson(testVal);
        if (loginExpModel!.status == 2001) {
          Fluttertoast.showToast(
              msg: "Not an expert",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        log(e.toString(), name: 'error');
      }

      if (loginExpModel!.status == 2000) {
        widget.enterOtp = loginExpModel!.loginInfo!.otp;

        Timer(Duration(seconds: 3), () {});
        verifyOtp();
        Fluttertoast.showToast(
            msg: "OTP ${loginExpModel!.loginInfo!.otp} ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  @override
  void initState() {
    widget.enterOtp;
    super.initState();
    // OTPInteractor.getAppSignature()
    //     //ignore: avoid_print
    //     .then((value) => print('signature - $value'));
    _pinPutController = OTPTextEditController(
      codeLength: 5,
      //ignore: avoid_print
      onCodeReceive: (code) => print('Your Application receive code - $code'),
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [
          // SampleStrategy(),
        ],
      );
  }

  @override
  void dispose() {
    _pinPutController.autoStop;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sharedPrefs = context.watch<VlccShared>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: MarginSize.small),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: PaddingSize.normal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(PaddingSize.small),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.keyboard_backspace,
                          size: 24,
                        )),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Verify your number",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.heading),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Request you to add one time password you have",
                    style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        fontSize: FontSize.normal),
                  ),
                  Row(
                    children: [
                      Text(
                        "received over your ",
                        style: TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal),
                      ),
                      Text(
                        widget.mobileNum ?? '123456789',
                        style: TextStyle(
                            height: 1.5,
                            color: AppColors.orangeDark,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.normal),
                      )
                    ],
                  ),
                  SizedBox(height: 26),
                  Row(
                    children: [
                      Expanded(
                          child: Opacity(opacity: 0, child: Icon(Icons.close))),
                      Expanded(
                        flex: 6,
                        child: PinPut(
                          fieldsAlignment: MainAxisAlignment.spaceBetween,
                          fieldsCount: 6,
                          withCursor: true,
                          eachFieldWidth:
                              MediaQuery.of(context).size.width * .10,
                          eachFieldHeight:
                              MediaQuery.of(context).size.width * .12,
                          textStyle: const TextStyle(
                              fontSize: FontSize.heading,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusNode: _pinPutFocusNode,
                          controller: _pinPutController,
                          followingFieldDecoration: BoxDecoration(
                            color: const Color.fromRGBO(235, 236, 237, 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          selectedFieldDecoration: BoxDecoration(
                            color: const Color.fromRGBO(235, 236, 237, 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ).copyWith(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: AppColors.orangeProfile,
                            ),
                          ),
                          submittedFieldDecoration: BoxDecoration(
                            color: const Color.fromRGBO(235, 236, 237, 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ).copyWith(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                          pinAnimationType: PinAnimationType.scale,
                          onChanged: (pin) {
                            setState(() {
                              otp = pin;
                              otp == widget.enterOtp
                                  ? log("valid")
                                  : log("invalid");
                            });
                          },
                          onSubmit: (pin) {
                            if (pin == widget.enterOtp) {
                              verifyOtp().then((value) {
                                Timer(Duration(seconds: 1), () {
                                  sharedPrefs.isExpert = true;
                                  // sharedPrefs.name = _profileModel
                                  // .clientProfileDetails.clientName;
                                  // sharedPrefs.email = _profileModel
                                  // .clientProfileDetails.clientEmailid;
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ExpertBottomBar(),
                                    ),
                                    (route) => false,
                                  );
                                });
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "OTP Incorrect",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: Icon(
                            otp == "12345" ? Icons.check_circle_outline : null,
                            color: otp == "12345" ? Colors.green : null),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't get a code? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.normal),
                      ),
                      InkWell(
                        onTap: recendOTPCall,
                        child: Text(
                          "Resend",
                          style: TextStyle(
                              color: AppColors.orangeDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
