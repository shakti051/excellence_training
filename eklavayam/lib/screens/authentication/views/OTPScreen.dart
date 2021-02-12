import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/authentication/views/MobileVerificationScreen.dart';
import 'package:eklavayam/screens/onetimeinfo/ChooseLanguageScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/StaticString.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';



class OTPScreen extends StatefulWidget {
  final String phoneno,name,email;

  const OTPScreen(this.phoneno,this.email,this.name);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  bool _autoValidate = false;
  String otp = "", password = " ", confpass = " ";

  String timestamp = new DateTime.now().millisecondsSinceEpoch.toString();
  //String plateform = getPlateform();
  String token = "";

  bool passobsucure = true;
  bool cpassobsucure = true;
  bool otpvisible = true, passvisible = false;


//   authenticateApi() async {
//     try {
//       showAlertDialog(context);
//       http.Response response = await http
//           .post(authenticateOtpUrl,
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': 'Bearer $token',
// //        'Authorization': 'Bearer $token',
//               },
//               body: jsonEncode({
//                 "inttelcode": inttelcode,
//                 "otp": otp,
//                 "mobile": widget.phoneno
//               }))
//           .timeout(Duration(seconds: api_timeout));
//
//       print("<<>>" + otp + " " + widget.phoneno + token);
//
//       Navigator.pop(context);
//       var jsonres = jsonDecode(response.body);
//       print("authotpyapi>>> " +
//           jsonres.toString() +
//           response.statusCode.toString());
//
//       if (response.statusCode == 200) {
//         var jsonres = jsonDecode(response.body);
//         print("otpapi>>> " + jsonres.toString());
//
//         if (jsonres['status'] == 1) {
//           showSnakbarWithGlobalKey(_scaffoldKey, jsonres['message']);
//           // showSnakbarWithGlobalKey(_scaffoldKey,jsonres['message']);
//           await saveStringSF("mobile", widget.phoneno);
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) => RegiesterScreen()));
// //    print("<<>> "+jsonres['payload']['token']);
// //    token=jsonres['payload']['token'];
// //    saveStringSF("token", jsonres['payload']['token']);
//
//         } else {
//           showSnakbarWithGlobalKey(_scaffoldKey, jsonres['message']);
//           // showSnakbarWithGlobalKey(_scaffoldKey,jsonres['message']);
//           // Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(phoneNo)));
//         }
// //  else{
// //    showSnakbarWithGlobalKey(_scaffoldKey,jsonres['message']);
// //  }
//       } else if (response.statusCode == 400) {
//       } else if (response.statusCode == 500) {
//       } else if (response.statusCode == 301) {}
//     } on TimeoutException catch (e) {
//       Navigator.pop(context);
//       showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
//       print("Timeout Exception");
//     } on SocketException catch (e) {
//       Navigator.pop(context);
//       showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
//       print("Socket Exception");
//     } on Exception catch (e) {
//       Navigator.pop(context);
//       showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
//       print("Exception");
//     }
//
// //{status: 0, message: Invalid Token...}
//     // {status: 1, message: OTP verified successfully, payload: {token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZXN1bHQiOnsidHlwZSI6IkJ1ZmZlciIsImRhdGEiOlsxMjMsMzQsMTA5LDEwMSwxMTUsMTE1LDk3LDEwMywxMDEsMzQsNTgsMzQsNzksODQsODAsMzIsMTE4LDEwMSwxMTQsMTA1LDEwMiwxMDUsMTAxLDEwMCwzMiwxMTUsMTE3LDk5LDk5LDEwMSwxMTUsMTE1LDM0LDQ0LDM0LDExNiwxMjEsMTEyLDEwMSwzNCw1OCwzNCwxMTUsMTE3LDk5LDk5LDEwMSwxMTUsMTE1LDM0LDEyNV19LCJpYXQiOjE1OTYxMjcwNzF9.hnk24TETXvBQWlVCgLLvkPf4KLedyfKJXZGLS8OJS5M}}
//   }
//
//   resendOtp() async {
//     try {
//       print(
//           "<<resend>>" + widget.phoneno + "   " + token + " " + getTimeStamp());
//       showAlertDialog(context);
//       http.Response response = await http
//           .post(resendOtpUrl,
//               headers: {
//                 'Content-Type': 'application/json',
//                 // 'Authorization': 'Bearer $token',
//               },
//               body: jsonEncode({
//                 "inttelcode": inttelcode,
//                 "mobile": widget.phoneno,
//                 "timestamp": getTimeStamp(),
//               }))
//           .timeout(Duration(seconds: api_timeout));
//
//       Navigator.pop(context);
//       var jsonres = jsonDecode(response.body);
//       print("resendapi>>> " +
//           jsonres.toString() +
//           response.statusCode.toString());
//
//       if (response.statusCode == 200) {
//         var jsonres = jsonDecode(response.body);
//         print("otpapi>>> " + jsonres.toString());
//         showSnakbarWithGlobalKey(_scaffoldKey, jsonres['message']);
//       } else if (response.statusCode == 400) {
//       } else if (response.statusCode == 500) {
//       } else if (response.statusCode == 301) {}
//     } on TimeoutException catch (e) {
//       Navigator.pop(context);
//       showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
//       print("Timeout Exception" + e.toString());
//     } on SocketException catch (e) {
//       Navigator.pop(context);
//       showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
//       print("Socket Exception" + e.toString());
//     } on Exception catch (e) {
//       Navigator.pop(context);
//       showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
//       print("Exception" + e.toString());
//     }
//
// //{status: 0, message: Invalid Token...}
//     // {status: 1, message: OTP verified successfully, payload: {token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZXN1bHQiOnsidHlwZSI6IkJ1ZmZlciIsImRhdGEiOlsxMjMsMzQsMTA5LDEwMSwxMTUsMTE1LDk3LDEwMywxMDEsMzQsNTgsMzQsNzksODQsODAsMzIsMTE4LDEwMSwxMTQsMTA1LDEwMiwxMDUsMTAxLDEwMCwzMiwxMTUsMTE3LDk5LDk5LDEwMSwxMTUsMTE1LDM0LDQ0LDM0LDExNiwxMjEsMTEyLDEwMSwzNCw1OCwzNCwxMTUsMTE3LDk5LDk5LDEwMSwxMTUsMTE1LDM0LDEyNV19LCJpYXQiOjE1OTYxMjcwNzF9.hnk24TETXvBQWlVCgLLvkPf4KLedyfKJXZGLS8OJS5M}}
//   }

  // void _sendToServer() {
  //   if (_formkey.currentState.validate()) {
  //     _formkey.currentState.save();
  //    // authenticateApi();
  //   } else {
  //     setState(() {
  //       _autoValidate = true;
  //     });
  //   }
  // }

  restore() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      token = (sharedPrefs.getString('access_token') ?? "");

      // username = (sharedPrefs.getString('username') ?? "Mr.");
      print("SFtoken> " + token);
    });
  }

  Future<void> validiateOtpCall() async {
    var jsonstring={
      "otp": otp,
      "accessToken":token,
      "mobile":widget.phoneno
      // "userType":userType,
      // "userName":loginEmailController.text,
      // "password":loginPasswordController.text
    };
    var jsondata=jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(verifyOtpUrl,jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      setState(() {
        otpvisible=false;
        passvisible=true;
      });
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['message']);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("access_token",responsedata['data']['accessToken'].toString());

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChooseLanguageScreen()));
      // CategoryModel categoryModel = new CategoryModel.fromJson(responsedata);
      //
      // setState(() {
      //   artdata=categoryModel.data[0];
      //   litreaturedata =categoryModel.data[1];
      //   culturedata=categoryModel.data[2];
      //
      //   artlist=artdata.subInterest;
      //   litreaturelist=litreaturedata.subInterest;
      //   culturelist=culturedata.subInterest;
      //
      // });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['message']);
    //print(responsedata['status']);
  }

  Future<void> signUpCall() async {
    var jsonstring={
      "email": widget.email,
      "mobile": widget.phoneno,
      "password": password,
      "fullName": widget.name,
      "userType": userType

    };
    var jsondata=jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(signUpUrl,jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['message']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MobileVerificationScreen(widget.phoneno)));
      // CategoryModel categoryModel = new CategoryModel.fromJson(responsedata);
      //
      // setState(() {
      //   artdata=categoryModel.data[0];
      //   litreaturedata =categoryModel.data[1];
      //   culturedata=categoryModel.data[2];
      //
      //   artlist=artdata.subInterest;
      //   litreaturelist=litreaturedata.subInterest;
      //   culturelist=culturedata.subInterest;
      //
      // });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey,  responsedata['message']);
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
                        "Sign Up",
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
                          if(otpvisible)
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
                                  "Enter OTP Code we sent via Email to your Register Email Id " +
                                      widget.email +
                                      ".",
                                  style: TextStyle(color: darkgreycolor, fontSize: 14),
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
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                          fontWeight: FontWeight.bold),
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
                                                  width: MediaQuery.of(context).size.width,
                                                  fieldWidth: 40,
                                                  style: TextStyle(
                                                      fontSize: 17
                                                  ),
                                                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                                                  fieldStyle: FieldStyle.underline,
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
                                      if(otp.length>5)
                                        validiateOtpCall();
                                      else
                                        showSnakbarWithGlobalKey(_scaffoldKey, "Please Enter OTP");
                                    },
                                    child: Container(
                                      height: 55,
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7), color: orangecolor),
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

                          if (passvisible)
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Password",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: bluecolor, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                  Colors.grey[200]))),
                                      child: TextField(
                                        obscureText: passobsucure,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              icon: Icon(
                                                passobsucure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: bluecolor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  passobsucure =
                                                  !passobsucure;
                                                });
                                              }),
                                          border: InputBorder.none,
                                          hintText: "Enter New Password",
                                        ),
                                        onChanged: (value) {
                                          // this.phoneNo=value;
                                          password = value;
                                          print(value);
                                        },
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Confirm Password",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: bluecolor, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                  Colors.grey[200]))),
                                      child: TextField(
                                        obscureText: cpassobsucure,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              icon: Icon(
                                                cpassobsucure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: bluecolor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  cpassobsucure =
                                                  !cpassobsucure;
                                                });
                                              }),
                                          border: InputBorder.none,
                                          hintText:
                                          "Enter Confirm Password",
                                        ),
                                        onChanged: (value) {
                                          // this.phoneNo=value;
                                          confpass = value;
                                          print(value);
                                        },
                                      )),

                                  SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // _sendToServer();
                                     if(password.length>3)
                                       signUpCall();
                                     else
                                     showSnakbarWithGlobalKey(_scaffoldKey, "Please Enter Valid Password");
                                      // onLoginBtn();
                                    },
                                    child: Container(
                                      height: 55,
                                      margin: EdgeInsets.symmetric(horizontal: 0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          color: orangecolor),
                                      child: Center(
                                        child: Text(
                                          "Continue",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
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
