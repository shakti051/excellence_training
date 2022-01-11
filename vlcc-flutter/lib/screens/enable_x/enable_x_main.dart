// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'video_call.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'permission_service.dart';

// class EnableXVideoConsultation extends StatefulWidget {
//   const EnableXVideoConsultation({Key? key}) : super(key: key);

//   @override
//   _EnableXVideoConsultationState createState() =>
//       _EnableXVideoConsultationState();
// }

// class _EnableXVideoConsultationState extends State<EnableXVideoConsultation> {
//   static const String kBaseURL = "https://demo.enablex.io/";
//   /* To try the app with Enablex hosted service you need to set the kTry = true */
//   static bool kTry = true;
//   /*Use enablec portal to create your app and get these following credentials*/

//   static const String kAppId = "6103e7b97fdf83297328e394";
//   static const String kAppkey = "UePy4yJugyYenutyJa8eSeVurunevyHadeAy";
//   static String token = "";

//   var header = kTry
//       ? {
//           "x-app-id": kAppId,
//           "x-app-key": kAppkey,
//           "Content-Type": "application/json"
//         }
//       : {"Content-Type": "application/json"};

//   Future<void> _handleCameraAndMic() async {
//     var cam = await Permission.camera.request();
//     var mic = await Permission.microphone.request();
//     var store = await Permission.storage.request();
//     var result = cam.isGranted && mic.isGranted && store.isGranted;
//   }

//   Future<void> permissionAccess() async {
//     var result =
//         await PermissionService().requestPermission(onPermissionDenied: () {
// //      print('Permission has been denied');
//     });

//     if (result) {
//       joinRoomValidations();
//     }
//   }

//   // bool permissionError = false;

//   Future<void> joinRoomValidations() async {
//     // await _handleCameraAndMic();
//     // if (permissionError) {
//     //   Fluttertoast.showToast(
//     //       msg: "Plermission denied",
//     //       toastLength: Toast.LENGTH_SHORT,
//     //       gravity: ToastGravity.BOTTOM,
//     //       backgroundColor: Colors.red,
//     //       textColor: Colors.white,
//     //       fontSize: 16.0);
//     //   return;
//     // }
//     // if (nameController.text.isEmpty) {
//     //   Fluttertoast.showToast(
//     //       msg: "Please Enter your name",
//     //       toastLength: Toast.LENGTH_SHORT,
//     //       gravity: ToastGravity.BOTTOM,
//     //       backgroundColor: Colors.red,
//     //       textColor: Colors.white,
//     //       fontSize: 16.0);
//     //   isValidated = false;
//     // } else if (roomIdController.text.isEmpty) {
//     //   Fluttertoast.showToast(
//     //       msg: "Please Enter your roomId",
//     //       toastLength: Toast.LENGTH_SHORT,
//     //       gravity: ToastGravity.BOTTOM,
//     //       backgroundColor: Colors.red,
//     //       textColor: Colors.white,
//     //       fontSize: 16.0);
//     //   isValidated = false;
//     // } else {
//     //   isValidated = true;
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
