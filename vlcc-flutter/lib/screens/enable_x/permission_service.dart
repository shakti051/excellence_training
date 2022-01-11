// import 'package:permission_handler/permission_handler.dart';

// class PermissionService {
//   final PermissionService _permissionHandler = PermissionService();

//   Future<bool> _requestPermission() async {
//     // var result =
//     var cam = await Permission.camera.request();
//     var mic = await Permission.microphone.request();
//     var store = await Permission.storage.request();
//     var result = cam.isGranted && mic.isGranted && store.isGranted;

//     if (result) {
//       return true;
//     }
//     return false;
//   }

//   Future<bool> requestPermission({required Function onPermissionDenied}) async {
//     var granted = await _requestPermission();
//     if (!granted) {
//       onPermissionDenied();
//     }
//     return granted;
//   }

//   // Future<bool> hasPhonePermission() async {
//   //   return hasPermission(PermissionGroup.phone);
//   // }

//   // Future<bool> hasPermission(PermissionGroup permission) async {
//   //   var permissionStatus =
//   //       await _permissionHandler.checkPermissionStatus(permission);
//   //   return permissionStatus == PermissionStatus.granted;
//   // }
// }
