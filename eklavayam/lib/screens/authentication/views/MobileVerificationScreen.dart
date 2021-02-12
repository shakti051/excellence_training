import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/onetimeinfo/ChooseLanguageScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/StaticString.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileVerificationScreen extends StatefulWidget {
  String phoneno;

  MobileVerificationScreen(this.phoneno);

  @override
  _MobileVerificationScreenState createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  bool _autoValidate = false;
  String otp = "", password = " ", confpass = " ";

  String timestamp = new DateTime.now().millisecondsSinceEpoch.toString();

  //String plateform = getPlateform();
  String token = "";
  String token1 = "";

  bool passobsucure = true;
  bool cpassobsucure = true;
  bool otpvisible = false, verifyvisible = true;

  restore() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      token = (sharedPrefs.getString('access_token') ?? "");
      token1 = (sharedPrefs.getString('access_token1') ?? "");

      // username = (sharedPrefs.getString('username') ?? "Mr.");
      print("SFtoken> " + token);
    });
  }

  Future<void> validiateOtpCall() async {
    var jsonstring = {
      "otp": otp,
      "accessToken": token1,
      "mobile": widget.phoneno
      // "userType":userType,
      // "userName":loginEmailController.text,
      // "password":loginPasswordController.text
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(verifyOtpUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {

      // setState(() {
      //   otpvisible=false;
      //   passvisible=true;
      // });
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['message']);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString(
          "access_token", responsedata['data']['accessToken'].toString());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChooseLanguageScreen()));

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['message']);
    //print(responsedata['status']);
  }

  Future<void> validiateUser() async {
    var jsonstring={

        "mobile": widget.phoneno,
        "accessToken": token

    };
    var jsondata=jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(mobileVerfication,jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("access_token",responsedata['data']['accessToken'].toString());

      //showSnakbarWithGlobalKey(_scaffoldKey, "Validiate");
      setState(() {
        otpvisible=true;
        verifyvisible=false;
      });
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(signupMobileController.text,signupEmailController.text,signupNameController.text)));

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['message']);
    //print(responsedata['status']);
  }

  @override
  void initState() {
    super.initState();
    restore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: bluecolor,
                            size: 25,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Phone Verification",
                        style: TextStyle(
                          color: bluecolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      key: _formkey,
                      autovalidate: _autoValidate,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (verifyvisible)
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      "Do you want to verify your Phone number",style: TextStyle(fontSize: 16,color: Colors.black),),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                       validiateUser();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: orangecolor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          height:50,
                                          width: 120,
                                          child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 18),),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChooseLanguageScreen()));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          height:50,
                                          width: 120,
                                          child: Text("Skip for now",style: TextStyle(color: Colors.black87,fontSize: 18)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          if (otpvisible)
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Verification Code",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: darkgreycolor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Enter OTP Code we sent via SMS to your Register phone number +91 " +
                                        widget.phoneno +
                                        ".",
                                    style: TextStyle(
                                        color: darkgreycolor, fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 3,
                                        child: Container(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "OTP",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: bluecolor,
                                                      fontSize: 18),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    //resendOtp();
                                                  },
                                                  child: Text(
                                                    "Resend OTP code",
                                                    style: TextStyle(
                                                        color: orangecolor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
//                                            decoration: BoxDecoration(
//                                                border: Border(
//                                                    bottom: BorderSide(
//                                                        color:
//                                                            Colors.grey[200]))),
                                              child: OTPTextField(
                                                length: 6,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fieldWidth: 40,
                                                style: TextStyle(fontSize: 17),
                                                textFieldAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                fieldStyle:
                                                    FieldStyle.underline,
                                                onCompleted: (pin) {
                                                  this.otp = pin;
                                                  //print("Completed: " + pin);
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                      ),
//                                    Flexible(
//                                      flex: 2,
//                                      child: GestureDetector(
//                                        onTap: () {
//                                          resendOtp();
//                                        },
//                                        child: Text(
//                                          "Resend OTP code",
//                                          style: TextStyle(
//                                              color: redclr,
//                                              fontSize: 14,
//                                              fontWeight: FontWeight.bold),
//                                        ),
//                                      ),
//                                    )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    color: whitecolor,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (otp.length > 5)
                                          validiateOtpCall();
                                        else
                                          showSnakbarWithGlobalKey(
                                              _scaffoldKey, "Please Enter OTP");
                                      },
                                      child: Container(
                                        height: 55,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: orangecolor),
                                        child: Center(
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
//            GestureDetector(
//              onTap: () {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => HomeScreen()));
//              },
//              child:

            //),
          ],
        ),
      ),
    );
  }
}
