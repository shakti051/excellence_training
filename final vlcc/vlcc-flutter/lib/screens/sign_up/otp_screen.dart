import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/main.dart';
import 'package:vlcc/models/center_master_model.dart';
import 'package:vlcc/models/resend_otp.dart';
import 'package:vlcc/models/service_master_model.dart';
import 'package:vlcc/models/verify_otp_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/bottom_bar/bottom_bar.dart';
import 'package:vlcc/screens/sign_up/sign_up.dart';
import 'package:vlcc/screens/welcome_screen.dart';
import 'package:vlcc/widgets/database_loading.dart';

class OtpScreen extends StatefulWidget {
  String? enterOtp, mobileNum, name;
  bool registerd;
  OtpScreen({
    Key? key,
    this.enterOtp = '',
    this.mobileNum = '',
    this.name = '',
    this.registerd = false,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late OTPTextEditController _pinPutController;
  final _pinPutFocusNode = FocusNode();
  String otp = '';
  final Services _services = Services();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  ResendOtpModel? _resendotpModel;
  VerifyOtpModel? _verifyOtpModel;
  final VlccShared _vlccSharedPrefs = VlccShared();
  bool updateMobile = true;

  Future<void> databaseLoadingDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return DatabaseLoader();
      },
    );
  }

  Future<void> verifyOtpCall() async {
    var body = {
      'login_mobile': _vlccSharedPrefs.mobileNum,
      'device_id': _vlccSharedPrefs.deviceId,
      'firebase_token': _vlccSharedPrefs.fcmToken,
      'client_otp': widget.enterOtp,
    };
    _services
        .callApi(body, '/api/api_client_token.php?request=login_token',
            apiName: 'Verify OTP')
        .then((value) async {
      var testVal = value;
      _verifyOtpModel = verifyOtpModelFromJson(testVal);
      if (_verifyOtpModel!.status == 2000) {
        String token = _verifyOtpModel!.tokenInfo.authToken;
        _vlccSharedPrefs.setAuthToken(token);

        // ---------------> Database initialize <----------------------
        var dbInit = await _databaseHelper.initializeDatabase();
        // databaseLoadingDialog();
        log('Database Initialized');
        // Get.to(DatabaseLoader());
        var serviceMasterBody = {
          'auth_token': _vlccSharedPrefs.authToken,
          'client_mobile': _vlccSharedPrefs.mobileNum,
          'device_id': _vlccSharedPrefs.deviceId
        };
        // ---------------------> Service master request <------------------------------
        _services
            .callApi(serviceMasterBody,
                '/api/api_service_master.php?request=service_master',
                apiName: 'Service Master')
            .then((value) async {
          var servicemaster = value;
          final serviceMasterMainModel =
              serviceMasterMainModelFromJson(servicemaster);
          _vlccSharedPrefs.serviceApiCount =
              serviceMasterMainModel.serviceMaster!.length;
          _databaseHelper.serviceMasterCountSet = 0;
          await Future.wait([
            Future.forEach(serviceMasterMainModel.serviceMaster!,
                (ServiceMasterDatabase serviceInfo) {
              _databaseHelper.insertService(serviceInfo);
            }),
          ]);
        });
        //---------------------> Center master request <------------------------------
        _services
            .callApi(serviceMasterBody,
                '/api/api_center_master.php?request=center_master',
                apiName: 'Center Master')
            .then((value) async {
          var centerMaster = value;
          final centerMasterMainModel =
              centerMasterMainModelFromJson(centerMaster);
          _vlccSharedPrefs.centerApiCount =
              centerMasterMainModel.centerMaster!.length;
          _databaseHelper.centerMasterCountSet = 0;
          await Future.wait([
            Future.forEach(centerMasterMainModel.centerMaster!,
                (CenterMasterDatabase centerInfo) {
              _databaseHelper.insertCenter(centerInfo);
            }),
          ]);
        });
        //---------------------> Center Master request end <--------------------------

        // ---------------> Database init successfully for Service and Center Master <----------------
        _vlccSharedPrefs.setAuthToken(token);
      }
    });
  }

  void recendOTPCall() {
    var body = {
      'login_oldmobile': _vlccSharedPrefs.mobileNum,
      'login_newmobile': _vlccSharedPrefs.mobileNum,
      'device_id': _vlccSharedPrefs.deviceId,
    };
    _services
        .callApi(body,
            '/api/api_client_mobile_update.php?request=client_mobile_update',
            apiName: 'Resend OTP')
        .then((value) {
      var testVal = value;
      _resendotpModel = resendOtpModelFromJson(testVal);
      if (_resendotpModel!.status == 2000) {
        widget.enterOtp = _resendotpModel!.mobileChangeInfo.otp;
        Timer(Duration(seconds: 3), () {});
        verifyOtpCall();
        Fluttertoast.showToast(
            msg: "OTP ${_resendotpModel!.mobileChangeInfo.otp} ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      log(_resendotpModel!.mobileChangeInfo.otp, name: 'otp');
    });
  }

  @override
  void initState() {
    widget.enterOtp;
    super.initState();
    OTPInteractor()
        .getAppSignature()
        .then((value) => log('signature - $value'));
    _pinPutController = OTPTextEditController(
      codeLength: 5,
      onCodeReceive: (code) => log('Your Application receive code - $code'),
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
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "Wrong number? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WelComeScreen(updateMobile: updateMobile)),
                          );
                        },
                        child: Text(
                          "Change",
                          style: TextStyle(
                              color: AppColors.orangeDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal),
                        ),
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
                              verifyOtpCall().then((value) {
                                Timer(Duration(seconds: 1), () {
                                  sharedPrefs.isSignupProfileComplete =
                                      widget.registerd;
                                  widget.registerd
                                      ? Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ConsumerBottomBar(
                                              selectedPage: 0,
                                            ),
                                          ),
                                          (route) => false,
                                        )
                                      : Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ProfileScreen(),
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
