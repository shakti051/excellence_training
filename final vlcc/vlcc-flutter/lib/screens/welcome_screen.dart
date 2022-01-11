import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/mixins/validation_mixin.dart';
import 'package:vlcc/models/login_exp_model.dart';
import 'package:vlcc/models/update_mobile_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/apiHandler/otp_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/sign_up/expert_otp_screen.dart';
import 'package:vlcc/screens/sign_up/otp_screen.dart';
import 'package:vlcc/screens/sign_up/sign_up_form.dart';
import 'package:vlcc/widgets/custom_loader.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class WelComeScreen extends StatefulWidget {
  final bool updateMobile;
  const WelComeScreen({Key? key, this.updateMobile = false}) : super(key: key);

  @override
  _WelComeScreenState createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> with ValidationMixin {
  int? phoneNumberLength;
  String? phoneNumber;
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final Services _services = Services();
  OtpModel? _otpModel;
  String? _deviceId;
  bool loading = false;
  bool isChecked = false;
  bool _loginSuccess = false;
  String? _sendOtp = '';
  final bool _userRegistered = true;
  UpdateMobileModel? _updateMobileModel;
  LoginExpModel? loginExpModel;
  final VlccShared _sharedPreferences = VlccShared();

  void updateMobile() {
    var body = {
      'login_oldmobile': _sharedPreferences.mobileNum,
      'login_newmobile': phoneNumber,
      'device_id': _sharedPreferences.deviceId,
    };
    _services
        .callApi(body,
            '/api/api_client_mobile_update.php?request=client_mobile_update',
            apiName: 'update mobile')
        .then((value) {
      var testVal = value;
      var jsonTest = json.decode(value);
      if (jsonTest['Status'] == 2000) {
        _updateMobileModel = updateMobileModelFromJson(testVal);
        setState(() {
          _loginSuccess = true;
          _sendOtp = _updateMobileModel?.mobileChangeInfo!.otp;
          Fluttertoast.showToast(
              msg: "OTP ${_updateMobileModel?.mobileChangeInfo!.otp} ",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                    enterOtp: _sendOtp,
                    mobileNum: phoneNumber!,
                    registerd: _userRegistered)),
          );
        });
      }

      if (jsonTest['Status'] == 2001) {
        setState(() {
          loading = false;
        });
        Fluttertoast.showToast(
            msg: "mobile not updated",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void postCall() {
    var body = {
      'login_mobile': phoneNumber,
      'device_id': Provider.of<VlccShared>(context, listen: false).deviceId,
      'firebase_token':
          Provider.of<VlccShared>(context, listen: false).fcmToken,
    };
    _services
        .callApi(body, '/api/api_client_signin.php?request=login_otp')
        .then((value) {
      var testVal = value;
      _otpModel = otpModelFromJson(testVal);
      if (_otpModel!.status == 2000) {
        setState(() {
          _loginSuccess = true;
          _sendOtp = _otpModel!.loginInfo.otp;
          Fluttertoast.showToast(
              msg: "OTP ${_otpModel!.loginInfo.otp} ",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          loading = false;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                    enterOtp: _sendOtp,
                    mobileNum: phoneNumber!,
                    registerd: _userRegistered)),
          );
        });
      }
      if (_otpModel!.status == 2001) {
        setState(() {
          loading = false;
          FocusScope.of(context).unfocus();
        });
        Fluttertoast.showToast(
            msg: "User not found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void expertLogin() {
    var body = {
      'login_mobile': phoneNumber,
      'device_id': Provider.of<VlccShared>(context, listen: false).deviceId,
      'firebase_token':
          Provider.of<VlccShared>(context, listen: false).fcmToken,
    };
    _services
        .callApi(body, '/api/api_expert_signin.php?request=login_otp',
            apiName: 'expert Login')
        .then((value) {
      var testVal = value;

      try {
        loginExpModel = loginExpModelFromJson(testVal);
        if (loginExpModel!.status == 2001) {
          setState(() {
            loading = false;
            FocusScope.of(context).unfocus();
          });
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
        setState(() {
          _loginSuccess = true;
          _sendOtp = loginExpModel!.loginInfo!.otp;
          Fluttertoast.showToast(
              msg: "OTP ${loginExpModel!.loginInfo!.otp} ",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          loading = false;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExpertOtpScreen(
                    enterOtp: _sendOtp,
                    mobileNum: phoneNumber!,
                    registerd: _userRegistered)),
          );
        });
      }
    });
  }

  Future<void> initPlatformState() async {
    String? deviceId;
    _sharedPreferences.isFirstTimeLoginOnDevice(withValue: true);
    log(_sharedPreferences.isFirstTimeLogin.toString(), name: 'islogin');
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    if (!mounted) return;
    setState(() {
      _deviceId = deviceId;
      Provider.of<VlccShared>(context, listen: false).setdeviceId(_deviceId!);
      log("$_deviceId", name: 'Device id');
    });
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Opacity(
            opacity: 0,
            child: Transform.scale(
              scale: 1.4,
              child: Container(
                margin: EdgeInsets.only(left: 24, top: 12, bottom: 12),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.backBorder),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: !isChecked
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Text(
                        "New to VLCC ? ",
                        style: TextStyle(
                          color: Color(0xff9393AA),
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.defaultFont,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpForm()),
                        );
                      },
                      child: SizedBox(
                        height: 20,
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: AppColors.orange,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.defaultFont),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Text(""),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MarginSize.small),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 44),
                  Align(
                    child: SvgPicture.asset(
                      SVGAsset.logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 44),
                  Text(
                    widget.updateMobile
                        ? "Change number"
                        : AppStrings.customerLogin,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.heading,
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Text(
                      widget.updateMobile
                          ? 'Add the correct number to access your account'
                          : "Let's get you into your account",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: FontSize.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Phone number",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    textAlignVertical: TextAlignVertical.center,
                    validator: (String? mobNum) {
                      if (validateMobile(mobNum!)) {
                        return null;
                      } else {
                        return 'Enter valid mobile number';
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 10.0),
                      counterText: '',
                      suffixIcon: Icon(
                          phoneNumberLength == 10
                              ? Icons.check_circle_outline
                              : null,
                          color: phoneNumberLength == 10 ? Colors.green : null),
                      hintText: 'Enter phone number',
                      focusedBorder: OutlineInputBorder(
                          borderSide: phoneNumberLength == 10
                              ? BorderSide(color: Colors.green)
                              : BorderSide(color: AppColors.orange),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onChanged: (text) {
                      setState(() {
                        phoneNumberLength = text.length;
                      });
                    },
                    onSaved: (text) {
                      phoneNumber = text;
                      Provider.of<VlccShared>(context, listen: false)
                          .setMobileNum(phoneNumber!);
                    },
                  ),
                  SizedBox(height: 16),
                  loading
                      ? CustomLoader(
                          customLoaderType: CustomLoaderType.defaultCupertino)
                      : GradientButton(
                          child: Text(
                            "Get OTP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.large,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              log("phone number is ${phoneNumber!}");
                              if (widget.updateMobile) {
                                setState(() {
                                  updateMobile();
                                  loading = true;
                                });
                              } else {
                                setState(() {
                                  !isChecked ? postCall() : expertLogin();
                                  loading = true;
                                });
                              }
                            }
                          },
                        ),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      log('hello');
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: SizedBox(
                      height: 40,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          !isChecked
                              ? "Sign in as an Expert"
                              : "Sign in as a Customer",
                          style: TextStyle(
                              color: AppColors.orangeDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.defaultFont),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
