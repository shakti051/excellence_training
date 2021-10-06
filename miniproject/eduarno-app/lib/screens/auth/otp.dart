import 'dart:async';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/auth/login.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/screens/auth/forgot_password.dart';
import 'package:eduarno/screens/profile/interest_screen.dart';
import 'package:eduarno/screens/profile/signup_interest.dart';
import 'package:eduarno/widgets/bottom_app_bar.dart';
import 'package:eduarno/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

import 'create_password.dart';

class Otp extends StatefulWidget {
  final String email;
  final bool isSignUp;

  const Otp({
    Key key,
    this.email,
    this.isSignUp = false,
  }) : super(key: key);

  @override
  _OtpState createState() => new _OtpState();
}

class _OtpState extends State<Otp> with SingleTickerProviderStateMixin {
  // Constants
  final int time = 30;
  bool isvisible = true;
  AnimationController _controller;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  // Variables
  Size _screenSize;
  int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  get _getTimerText {
    return Container(
      height: 32,
      child: new Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.access_time, size: 18, color: Color(0xff41C36C)),
            new SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller, 15.0, Colors.black)
          ],
        ),
      ),
    );
  }

  Future<Widget> getLoader() {
    Container(
      height: 10,
      width: 10,
      child: CircularProgressIndicator(
        strokeWidth: 1,
      ),
    );
  }

  // Returns "Resend" button
  get _getResendButton {
    return new InkWell(
      child: new Container(
        height: 32,
        // width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh,
              size: 18,
              color: Color(0xff41C36C),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Resend OTP",
                style: new TextStyle(
                    fontWeight: FontWeight.w500, color: Color(0xff41C36C)),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        getLoader();
        AuthProvider.forgotPassword(widget.email).then((value) {
          print('OTP Sent Successfully!');

          ///Need to start timer here
          setState(() {
            _startCountdown();
          });
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    resendOTP();
  }

  resendOTP() {
    totalTimeInSeconds = time;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: new Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 62,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            'assets/eduarno_logo.png',
                          ),
                          fit: BoxFit.fill,
                        )),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 32, left: 24, bottom: 8),
                      child: Text(
                        "Verify OTP",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 20, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Color(0xff303030),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(text: "Please verify that "),
                              TextSpan(
                                  text: widget.email,
                                  style: TextStyle(color: kPrimaryGreenColor)),
                              TextSpan(text: "\nbelongs to you.\n"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Not your email?",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => ForgotPassword(
                                          isUpdate: true,
                                          emailUpdate: widget.email,
                                        ))),
                            child: Text(" Change email",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff41C36C),
                                    fontFamily: "Poppins",
                                    fontSize: 16)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                darkRoundedPinPut(),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 21),
                  child: Row(
                    children: [
                      _hideResendButton ? _getTimerText : _getResendButton,
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget darkRoundedPinPut() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Color(0xffF6F7FA),
      borderRadius: BorderRadius.circular(
        8.0,
      ),
    );
    final BoxDecoration selectedPinPutDecoration = BoxDecoration(
      color: Color(0xffF6F7FA),
      border: Border.all(color: Color(0xff41C36C)),
      borderRadius: BorderRadius.circular(
        8.0,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: PinPut(
        eachFieldWidth: 65.0,
        eachFieldHeight: 65.0,
        withCursor: true,
        fieldsCount: 4,
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        onSubmit: (pin) {
          print("Completed: " + pin);
          AuthProvider.verifyOtp(
                  pin, Provider.of<User>(context, listen: false).userId)
              .then((value) {
            if (value) if (widget.isSignUp) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignupInterest()),
                  (Route<dynamic> route) => false);
            } else {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => CreatePassword()));
            }
          });
        },
        onChanged: (pin) {
          print("Changed: " + pin);
        },
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: selectedPinPutDecoration,
        followingFieldDecoration: pinPutDecoration,
        pinAnimationType: PinAnimationType.scale,
        textStyle: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontFamily: "Poppins"),
      ),
    );
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }
}

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = kTitleColor;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return new Text(
            timerString,
            style: new TextStyle(
                fontSize: fontSize,
                color: kPrimaryColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}
