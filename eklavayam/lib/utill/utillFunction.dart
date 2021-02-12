import 'package:eklavayam/screens/authentication/login_signup/ui/login_page.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io' show Platform;



String exception_message = "Some error occurred. Please try after some time";
int api_timeout = 60;

saveStringSF(String key, String value) async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  sharedPrefs.setString(key, value);
//    sharedPrefs.setStringList(key, value);
}

saveBoolSF(String key, dynamic value) async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  sharedPrefs.setBool(key, value);
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
    // SpinKitRotatingCircle(
    // color: Colors.white,
    //   size: 50.0,
    // ),
        CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(bluecolor),
        ),
        Container(
            margin: EdgeInsets.only(left: 10), child: Text("Please wait...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



DateTime currentBackPressTime;

Future<bool> onDoubleClickExit(BuildContext context) {
  DateTime now = DateTime.now();

  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    showSnakbar(context, "back");
    return Future.value(false);
  }
  return Future.value(true);
}

Future<bool> onBackPressed(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Do you want to Exit the App?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  SystemNavigator.pop();
                },
              )
            ],
          );
        },
      ) ??
      false;
}

Future<bool> exitApp(BuildContext context) {
  return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Do you want to Exit the App?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                print("you choose no");
                Navigator.of(context).pop(false);
              },
              child: Text(
                'No',
                style: TextStyle(color: bluecolor),
              ),
            ),
            FlatButton(
              onPressed: () async {
                //  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                // await AuthClient.internal().signOut();

                await saveStringSF("token", "");
                await saveBoolSF('login', false);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (c) => LoginPage()),
                    (r) => false);
              },
              child: Text(
                'Yes',
                style: TextStyle(color: orangecolor),
              ),
            ),
          ],
        ),
      ) ??
      false;
}

showSnakbarWithGlobalKey(GlobalKey<ScaffoldState> globalKey, String msg) {
  try {
    final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(msg));
    globalKey.currentState.showSnackBar(snackBar);
  } catch (e) {}
}

showSnakbar(BuildContext context, String message) {
  try {
    Scaffold.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green,
    ));
  } on Exception catch (e, s) {
    print(s);
  }
}

// styledToast(context,String msg){
// return   showToast(msg,
//     context: context,
//     animation: StyledToastAnimation.slideFromTop,
//     reverseAnimation: StyledToastAnimation.slideToTop,
//     position: StyledToastPosition.top,
//     startOffset: Offset(0.0, -3.0),
//     reverseEndOffset: Offset(0.0, -3.0),
//     duration: Duration(seconds: 4),
//     //Animation duration   animDuration * 2 <= duration
//     animDuration: Duration(seconds: 1),
//     curve: Curves.elasticOut,
//     reverseCurve: Curves.fastOutSlowIn);
// }

getTimeStamp() {
  String timestamp = DateTime.now().toUtc().millisecondsSinceEpoch.toString().substring(0, 9);
  print("dtnow1: "+DateTime.now().toString());
  print("dtnow2: "+DateTime.now().toUtc().toString());
  print("dtnow3: "+DateTime.now().toUtc().millisecondsSinceEpoch.toString());
  return timestamp;
}

getTimeStampWithDateTime(DateTime date, DateTime time) {
  print("gettimestamp: "+getTimeStamp());
  print("date: "+date.toString()+" time: "+time.toString());
  print("dtnow2: "+DateTime(
      date.year, date.month, date.day, time.hour, time.minute, time.second)
      .toUtc().toString());
  String timstamp = DateTime(
          date.year, date.month, date.day, time.hour, time.minute, time.second)
      .toUtc()
      .millisecondsSinceEpoch
      .toString()
      .substring(0, 9);
  print("tstamp: " + timstamp);
  return timstamp+"0";
}



getTimeStampWithDate(DateTime date) {
  print("gettimestamp: "+getTimeStamp());
 // print("date: "+date.toString()+" time: "+time.toString());
 //  print("dtnow2: "+DateTime(
 //      date.year, date.month, date.day, date.hour, time.minute, time.second)
 //      .toUtc().toString());
  String timstamp = DateTime(
      date.year, date.month, date.day, date.hour, date.minute, date.second)
      .toUtc()
      .millisecondsSinceEpoch
      .toString()
      .substring(0, 9);
  print("tstamp: " + timstamp);
  return timstamp+"0";
}



getDateforTimestamp(int timestamp)
{

  print(timestamp);
  // int timeInMillis = 1586348737122;
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp*1000);
  //String datetime= DateFormat.yMMMd().format(date);
  String datetime = DateFormat('dd MMM,yy  hh:mm a').format(date);
  //var datetime = new DateTime(date.year, date.month, date.day, date.hour, date.minute);
  print("datetime: "+datetime.toString());
  return   datetime.toString();

}



// showCupertinoDialog(
//     context: context,
//     builder: (context) {
//       return CupertinoAlertDialog(
//         content: Text('Fab Button Pressed!'),
//         actions: <Widget>[
//           CupertinoDialogAction(
//             child: Text('Close'),
//             isDestructiveAction: true,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           )
//         ],
//       );
//     });


//
// SizedBox(
// width: 200.0,
// height: 100.0,
// child: Shimmer.fromColors(
// baseColor: Colors.red,
// highlightColor: Colors.yellow,
// child: Text(
// 'Shimmer',
// textAlign: TextAlign.center,
// style: TextStyle(
// fontSize: 40.0,
// fontWeight:
// FontWeight.bold,
// ),
// ),
// ),
// );



getPlateform() {
  if (Platform.isAndroid) {
    return "Android";
  } else if (Platform.isIOS) {
    return "IOS";
  } else if (Platform.isFuchsia) {
    return "Fuchsia";
  } else if (Platform.isLinux) {
    return "Linux";
  } else if (Platform.isMacOS) {
    return "MacOS";
  } else if (Platform.isWindows) {
    return "Windows";
  }
}
