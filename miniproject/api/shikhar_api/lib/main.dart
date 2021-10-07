import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shikhar_api/model/otp_model.dart';
import 'service/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:const OTPPage(),
    );
  }
}

class OTPPage extends StatefulWidget {
  const OTPPage({ Key? key }) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  OtpModel? otpModel;
  Services _services = Services();
  void postCall() {
    var body = {
      'login_mobile': '9811641705',
      'device_id': '00000000-89ABCDEF-01234567-89ABCDEF',
    };
    _services.callApi(body, '/api/api_client_signin.php?request=login_otp').then((value) {
       var testVal = value;
      log('$testVal', name: 'Test Value');
      final otpModel = otpModelFromJson(testVal);
      log("you device Id is"+otpModel.loginInfo.deviceId, name: 'Device id');
    });
  }

  @override
  void initState() {
    super.initState();
    postCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 100),
        Text("hello")
      ],),
    );
  }
}
