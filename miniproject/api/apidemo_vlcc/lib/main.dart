import 'package:apidemo_vlcc/service/otp_service.dart';
import 'package:flutter/material.dart';
import 'model/otp_model.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OTPService otpVLC = OTPService();
  OTPModel? otpModel;
  bool apiHit = false;

  _getOTP() async {
    var getOTp =  await otpVLC.getOTPMobile().then((value) {
      otpModel = value;
      print("your message  code  is " );
      setState(() {
        apiHit = true;
      });
    });
    return getOTp;
  }

  @override
  void initState() {
    _getOTP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
            SizedBox(height: 100),
            Center(child: Text("hello"),)  
      ],),
    );
  }
}