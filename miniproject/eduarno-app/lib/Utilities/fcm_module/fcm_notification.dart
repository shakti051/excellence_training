// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../main.dart';

// class PushNotificationsManager {
//   PushNotificationsManager._();

//   factory PushNotificationsManager() => _instance;

//   SharedPreferences prefs;

//   static final PushNotificationsManager _instance =
//       PushNotificationsManager._();

//   // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   bool isInitialized = false;
//   // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   //     FlutterLocalNotificationsPlugin();

//   BehaviorSubject<Map<String, dynamic>> notificationSubject =
//       BehaviorSubject<Map<String, dynamic>>();

//   Future<void> init() async {
//     await SharedPreferences.getInstance().then((value) => prefs = value);
//     if (!isInitialized) {
//       initLocalNotificationPlugin();
//       _firebaseMessaging.requestNotificationPermissions();

//       _firebaseMessaging.configure(
//         onMessage: (Map<String, dynamic> message) async {
//           if (Platform.isIOS) {
//             print('iOS is the app');
//             String title = message['aps']['alert']['title'];
//             String body = message['aps']['alert']['body'];
//             await _showNotification(1, title, body, '');
//           } else {
//             await _showNotification(1, message['notification']['title'],
//                 message['notification']['body'], null);
//           }
//           //notificationSubject.add({'type': 'Active App', 'value': message});
//           print('onMessage: $message');
//         },
//         onBackgroundMessage: myBackgroundMessageHandler,
//         onLaunch: (Map<String, dynamic> message) async {
//           notificationSubject.add({'type': 'Terminated App', 'value': message});
//           print('onLaunch: $message');
//         },
//         onResume: (Map<String, dynamic> message) async {
//           notificationSubject.add({'type': 'Inactive App', 'value': message});
//           print('onResume: $message');
//         },
//       );

//       // For testing purposes print the Firebase Messaging token
//       String token;
//       token = await _firebaseMessaging.getToken();
//       // await prefs.setString(PrefConstants.USER_FCM_TOKEN, token);
//       print('FirebaseMessaging token: $token');
//       isInitialized = true;
//     }
//     //   void serializeAndNavigate(Map<String, dynamic> message) {
//     //     var notificationData = message['data'];
//     //     var view = notificationData['page'];

//     //     if (view != null) {
//     //       //Navigate to Page
//     //       if (view == 'HOME') {}
//     //     }
//     //   }
//   }

//   void initLocalNotificationPlugin() {
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     requestIOSPermissions(flutterLocalNotificationsPlugin);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void requestIOSPermissions(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }

//   Future<void> createChannel() async {
//     var notificationPlugin = FlutterLocalNotificationsPlugin();
//     var notificationChannel = AndroidNotificationChannel(
//       'test_push_notification',
//       'Test Push Notification',
//       'Channel to test push notification',
//       importance: Importance.high,
//       playSound: true,
//     );
//     await notificationPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(notificationChannel);

//     // var initializationSettingsAndroid =
//     //     new AndroidInitializationSettings('@mipmap/ic_launcher');
//     // var initializationSettingsIOS = new IOSInitializationSettings();
//     // var initializationSettings = new InitializationSettings(
//     //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

//     // // requestIOSPermissions(flutterLocalNotificationsPlugin);
//     // flutterLocalNotificationsPlugin.initialize(initializationSettings,
//     //     onSelectNotification: null);

//     //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     //       AndroidNotificationDetails(
//     //           'your channel id', 'your channel name', 'your channel description',
//     //           importance: Importance.max,
//     //           priority: Priority.high,
//     //           showWhen: false);
//     //   const NotificationDetails platformChannelSpecifics =
//     //       NotificationDetails(android: androidPlatformChannelSpecifics);
//     //   await flutterLocalNotificationsPlugin.show(
//     //       0, 'Hello', 'Savaari Test', platformChannelSpecifics,
//     //       payload: 'item x');
//   }

//   Future<void> _showNotification(
//     int notificationId,
//     String notificationTitle,
//     String notificationContent,
//     String payload, {
//     String channelId = '1234',
//     String channelTitle = 'Android Channel',
//     String channelDescription = 'Default Android Channel for notifications',
//     Priority notificationPriority = Priority.high,
//     Importance notificationImportance = Importance.max,
//   }) async {
//     assert(notificationImportance != null);
//     assert(notificationPriority != null);
//     assert(channelDescription != null);
//     assert(channelId != null);
//     assert(channelTitle != null);
//     // var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//     // channelId, channelTitle, channelDescription,
//     // playSound: true,
//     // // importance: notificationImportance,
//     // // priority: notificationPriority,
//     // styleInformation: BigTextStyleInformation(''));
//     // var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     // var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics, null);
//     // ignore: omit_local_variable_types
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'test', 'your channel name', 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             playSound: true,
//             ticker: 'ticker',
//             styleInformation: BigTextStyleInformation(''));

//     // ignore: omit_local_variable_types
//     const IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails(
//             presentAlert: true, presentBadge: true, presentSound: true);
//     // ignore: omit_local_variable_types
//     const MacOSNotificationDetails macOSPlatformChannelSpecifics =
//         MacOSNotificationDetails();
//     // ignore: omit_local_variable_types
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics,
//         macOS: macOSPlatformChannelSpecifics);

//     print('showing notifications');
//     await flutterLocalNotificationsPlugin.show(
//       notificationId,
//       notificationTitle,
//       notificationContent,
//       platformChannelSpecifics,
//       payload: payload,
//     );
//   }
// }
