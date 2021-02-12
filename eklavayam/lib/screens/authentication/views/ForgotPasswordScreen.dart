import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/authentication/login_signup/ui/login_page.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/StaticString.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  bool passobsucure = true;
  bool cpassobsucure = true;

  String token = "";
  String phoneno = " ", otp = " ", password = " ", confpass = " ";
  bool otpvisible = false, passvisible = false;
  bool mobilefieldenable = true;
  String apiotp = "";

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
//               body: jsonEncode(
//                   {"inttelcode": "91", "otp": otp, "mobile": phoneno}))
//           .timeout(Duration(seconds: api_timeout));
//
//       print("<<>>" + otp + " " + phoneno + token);
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
//           // token=jsonres['payload']
//           setState(() {
//             otpvisible = false;
//             passvisible = true;
//           });
//           // showSnakbarWithGlobalKey(_scaffoldKey,jsonres['message']);
//           //  await saveStringSF("mobile", widget.phoneno);
//           //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegiesterScreen()));
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
//       print("timeoutexception" + e.toString());
//       Navigator.pop(context);
//       showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
//     } on SocketException catch (e) {
//       print("sockettexception" + e.toString());
//       Navigator.pop(context);
//       showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
//     } on Exception catch (e) {
//       print("exception" + e.toString());
//       Navigator.pop(context);
//       showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
//     }
//
// //{status: 0, message: Invalid Token...}
//     // {status: 1, message: OTP verified successfully, payload: {token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZXN1bHQiOnsidHlwZSI6IkJ1ZmZlciIsImRhdGEiOlsxMjMsMzQsMTA5LDEwMSwxMTUsMTE1LDk3LDEwMywxMDEsMzQsNTgsMzQsNzksODQsODAsMzIsMTE4LDEwMSwxMTQsMTA1LDEwMiwxMDUsMTAxLDEwMCwzMiwxMTUsMTE3LDk5LDk5LDEwMSwxMTUsMTE1LDM0LDQ0LDM0LDExNiwxMjEsMTEyLDEwMSwzNCw1OCwzNCwxMTUsMTE3LDk5LDk5LDEwMSwxMTUsMTE1LDM0LDEyNV19LCJpYXQiOjE1OTYxMjcwNzF9.hnk24TETXvBQWlVCgLLvkPf4KLedyfKJXZGLS8OJS5M}}
//   }

//   resendOtp() async {
//     try {
//       // print("<<resend>>" + widget.phoneno + "   " + token+" "+getTimeStamp());
//       showAlertDialog(context);
//       http.Response response = await http
//           .post(resendOtpUrl,
//               headers: {
//                 'Content-Type': 'application/json',
//                 // 'Authorization': 'Bearer $token',
//               },
//               body: jsonEncode({
//                 "inttelcode": inttelcode,
//                 "mobile": phoneno,
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
//
// //      if(jsonres['status']==1)
// //      {
// ////        showSnakbarWithGlobalKey(_scaffoldKey,jsonres['message']);
// ////        // showSnakbarWithGlobalKey(_scaffoldKey,jsonres['message']);
// ////        await saveStringSF("mobile", widget.phoneno);
// ////        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegiesterScreen()));
// //////    print("<<>> "+jsonres['payload']['token']);
// //////    token=jsonres['payload']['token'];
// //////    saveStringSF("token", jsonres['payload']['token']);
// //
// //      }
// //      else
// //      {
// //        showSnakbarWithGlobalKey(_scaffoldKey,jsonres['message']);
// //        // showSnakbarWithGlobalKey(_scaffoldKey,jsonres['message']);
// //        // Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(phoneNo)));
// //      }
// //  else{
// //    showSnakbarWithGlobalKey(_scaffoldKey,jsonres['message']);
// //  }
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

  // forgotPassApi() async {
  //   try {
  //     print("forgotapi> " + phoneno);
  //     // print("abou>> " + mobile + " " + aboutme + " " + token);
  //     showAlertDialog(context);
  //     http.Response response = await http
  //         .post(forgototpUrl,
  //             headers: {
  //               'Content-Type': 'application/json',
  //               //'Authorization': 'Bearer $token',
  //             },
  //             body: jsonEncode({
  //               "mobile": phoneno,
  //               "inttelcode": inttelcode,
  //               "usertype": usertype,
  //               "timestamp": getTimeStamp()
  //
  //               //"otp": otp,
  //               //"mobile":widget.phoneno
  //             }))
  //         .timeout(Duration(seconds: api_timeout));
  //
  //     // print("<<>>"+otp+" "+widget.phoneno+token);
  //
  //     Navigator.pop(context);
  //     var jsonres = jsonDecode(response.body);
  //     print(
  //         "getabout>>> " + jsonres.toString() + response.statusCode.toString());
  //
  //     if (response.statusCode == 200) {
  //       var jsonres = jsonDecode(response.body);
  //       if (jsonres['status'] == 1) {
  //         //token="";
  //         // Timer(Duration(seconds: 2),()=>Navigator.pop(context));
  //
  //         showSnakbarWithGlobalKey(_scaffoldKey, jsonres['message']);
  //         token = jsonres["payload"]["token"];
  //         setState(() {
  //           otpvisible = true;
  //           mobilefieldenable = false;
  //         });
  //       } else {
  //         showSnakbarWithGlobalKey(_scaffoldKey, jsonres['message']);
  //       }
  //     } else if (response.statusCode == 400) {
  //     } else if (response.statusCode == 500) {
  //     } else if (response.statusCode == 301) {}
  //   } on TimeoutException catch (e) {
  //     Navigator.pop(context);
  //     showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
  //     print("Timeout Exception" + e.toString());
  //   } on SocketException catch (e) {
  //     Navigator.pop(context);
  //     showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
  //     print("Socket Exception" + e.toString());
  //   } on Exception catch (e) {
  //     Navigator.pop(context);
  //     showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
  //     print("Exception" + e.toString());
  //   }
  // }

  // updatePassApi() async {
  //   try {
  //     showAlertDialog(context);
  //     Map<String, String> headers = {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     };
  //
  //     Map<String, String> databody = {
  //       "mobile": phoneno,
  //       'password': password,
  //       "userType": usertype,
  //     };
  //
  //     http.Response response = await http
  //         .post(updatePasswordUrl, headers: headers, body: jsonEncode(databody))
  //         .timeout(Duration(seconds: api_timeout));
  //     // Navigator.pop(context);
  //     // {status: 0, message: Invalid login credentials, payload: null}
  //     //{status: 1, message: Login successfully, payload: {mobile: 9896690090, email: bhavnesh@bytesbrick.com, lastlogin: 1596127532, token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZXN1bHQiOnsidW5pcXVlSWQiOjExLCJtb2JpbGUiOiI5ODk2NjkwMDkwIiwiZW1haWwiOiJiaGF2bmVzaEBieXRlc2JyaWNrLmNvbSIsImZ1bGxOYW1lIjoiQmhhdm5lc2gga3VtYXIiLCJwcm9maWxlSW1nIjpudWxsLCJjcmVhdGVkT24iOjE1OTYxMjcxNywidXBkYXRlZE9uIjpudWxsLCJzdGF0dXMiOjEsIm1WZXJpZmllZCI6MSwiZVZlcmlmaWVkIjowLCJpc1RyYXNoZWQiOjAsInRyYXNoZWRPbiI6bnVsbCwidXNlclR5cGUiOiIxIn0sImlhdCI6MTU5NjEyNzUzMn0.i7cxZcncj98BS8jUXsI2Kxh9-Rn-3Bf7aC_g6Du15JM}}
  //     var jsonres = jsonDecode(response.body);
  //     print("loginapi>>> " + jsonres.toString());
  //
  //     Navigator.pop(context);
  //     if (response.statusCode == 200) {
  //       var jsonres = jsonDecode(response.body);
  //       if (jsonres['status'] == 1) {
  //         print("updatepass>>> " + jsonres.toString());
  //         showSnakbarWithGlobalKey(_scaffoldKey, jsonres['message']);
  //         await saveStringSF("token", jsonres['payload']['token']);
  //         Navigator.pop(context);
  //         //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  //       } else
  //         showSnakbarWithGlobalKey(_scaffoldKey, jsonres['message']);
  //       // print("verifyapi>>> " + jsonres.toString());
  //     } else if (response.statusCode == 400) {
  //     } else if (response.statusCode == 500) {
  //     } else if (response.statusCode == 301) {}
  //   } on TimeoutException catch (e) {
  //     Navigator.pop(context);
  //     showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
  //     print("Timeout Exception" + e.toString());
  //   } on SocketException catch (e) {
  //     Navigator.pop(context);
  //     showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
  //     print("Socket Exception" + e.toString());
  //   } on Exception catch (e) {
  //     Navigator.pop(context);
  //     showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
  //     print("Exception" + e.toString());
  //   }
  // }

//  void _sendToServer() {
//    if (_formkey.currentState.validate()) {
//      _formkey.currentState.save();
//      if (passvisible) {
//        updatePassApi();
//        // loginApi();
//      } else
//        forgotPassApi();
//      // verifyApi();
//    } else {
//      setState(() {
//        _autoValidate = true;
//      });
//    }
//  }

  Future<void> validiateUser() async {
    var jsonstring={
      "userType":userType,
      "mobile":phoneno
    };
    var jsondata=jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(forgotPasswordUrl,jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
                showSnakbarWithGlobalKey(_scaffoldKey, responsedata['data']);

          setState(() {
            otpvisible = true;
            passvisible = false;
          });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['error']);
    //print(responsedata['status']);
  }

  Future<void> validiateOtpCall() async {
    var jsonstring={
      "otp": otp
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
    if (responsedata['otp'] == true) {
      setState(() {
        otpvisible=false;
        passvisible=true;
      });
      showSnakbarWithGlobalKey(_scaffoldKey, "Validiate");
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
      showSnakbarWithGlobalKey(_scaffoldKey, "OTP not Match");
    //print(responsedata['status']);
  }

  Future<void> updatePasswordCall() async {
    var jsonstring={
      "mobile": phoneno,
      "password": password,
      "userType": userType
    };
    var jsondata=jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(updatePassUrl,jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      showSnakbarWithGlobalKey(_scaffoldKey, "Validiate");
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
      showSnakbarWithGlobalKey(_scaffoldKey, "OTP not Match");
    //print(responsedata['status']);
  }

  continuebtn() {
    if (passvisible == false && otpvisible == false) {
      if (phoneno.length == 10) {
        validiateUser();
      } else {
        showSnakbarWithGlobalKey(
            _scaffoldKey, "mobile number must be 10 digit");
      }
    } else if (otpvisible == true && passvisible == false) {
      if (otp.length == 6) {
        print("otp enter");
        validiateOtpCall();
      } else {
        showSnakbarWithGlobalKey(_scaffoldKey, "Please Enter Valid Otp");
      }
    } else if (passvisible == true && otpvisible == false) {
      print("pass> " + password + " " + password.length.toString());
      if (password.length > 3) {
        if (password == confpass)
          updatePasswordCall();

        else
          showSnakbarWithGlobalKey(
              _scaffoldKey, "Password and Confirm password not match");
      } else {
        showSnakbarWithGlobalKey(
            _scaffoldKey, "Password length must be Greater than three");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         colors: [bluecolor, bluecolor, bluecolor])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
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
                            size: 20,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Forgot Password Information",
                        style: TextStyle(
                          color: bluecolor,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                // decoration: BoxDecoration(
                //     color: bluecolor,
                //     borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(25),
                //         topRight: Radius.circular(25))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "we will send OTP to your Mobile",
                          style: TextStyle(color: darkgreycolor),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Mobile Number",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: bluecolor, fontSize: 18),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          "+91",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
//                                        CountryCodePicker(
//                                          onChanged: (e) =>
//                                              print(e.toLongString()),
//                                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//                                          initialSelection: 'IN',
//                                          favorite: ['+91', 'IN'],
//                                          showFlag: false,
//                                          // optional. Shows only country name and flag
//                                          showCountryOnly: false,
//                                          // optional. Shows only country name and flag when popup is closed.
//                                          showOnlyCountryWhenClosed: false,
//                                          // optional. aligns the flag and the Text left
//                                          alignLeft: true,
//                                        ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: TextFormField(
                                        enabled: mobilefieldenable,
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          counterText: "",
                                          suffixIcon: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.phone_android,
                                              color: bluecolor,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Enter Mobile Number",
                                        ),
                                        onChanged: (value) {
                                          this.phoneno = value;
                                        },
//                                          validator: (String arg) {
//                                            if (arg.length < 10)
//                                              return 'Please Enter Valid Mobile Number';
//                                            else
//                                              return null;
//                                          },
//                                          onSaved: (value) {
//                                            this.phoneno = value;
//                                            print(value);
//                                          },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (otpvisible)
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

//                                            TextFormField(
//                                              maxLength: 4,
//                                              keyboardType:
//                                                  TextInputType.number,
//                                              inputFormatters: [
//                                                WhitelistingTextInputFormatter
//                                                    .digitsOnly
//                                              ],
//                                              decoration: InputDecoration(
//                                                labelStyle:
//                                                    TextStyle(letterSpacing: 5),
//                                                counterText: "",
//                                                hintStyle: TextStyle(
//                                                    fontWeight:
//                                                        FontWeight.bold),
//                                                border: InputBorder.none,
//                                                hintText:
//                                                    "\u2022 \u2022 \u2022 \u2022 \u2022",
//                                              ),
//                                              onChanged: (vale) {
//                                                this.otp = vale;
//                                              },
////                                      validator: (String arg) {
////                                        if (arg.length < 4)
////                                          return 'Please Enter Valid OTP';
////                                        else
////                                          return null;
////                                      },
////                                      onSaved: (value) {
////                                        this.otp = value;
////                                        print(value);
////                                      },
//                                            ),

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
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            // _sendToServer();
                            continuebtn();
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
//                              GestureDetector(
//                                onTap: () {
//                                  FocusScope.of(context)
//                                      .requestFocus(FocusNode());
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) =>
//                                              ForgotPasswordScreen()));
//                                },
//                                child: Text(
//                                  "Forgot Password",
//                                  style: TextStyle(color: Colors.grey),
//                                ),
//                              ),
                              SizedBox(
                                height: 30,
                              ),
//                                GestureDetector(
//                                  onTap: () {
//                                    FocusScope.of(context)
//                                        .requestFocus(FocusNode());
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                            builder: (context) =>
//                                                RegiesterScreen()));
//                                  },
//                                  child: Text(
//                                    "Click here to Register!",
//                                    style: TextStyle(color: Colors.grey),
//                                  ),
//                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
