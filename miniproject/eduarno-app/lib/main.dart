import 'package:eduarno/Theme_data/eduarno_theme_data.dart';
import 'package:eduarno/repo/bloc/assessment/assessment_data.dart';
import 'package:eduarno/repo/bloc/assessment/filter_data.dart';
import 'package:eduarno/repo/bloc/cms/cms_provider.dart';
import 'package:eduarno/repo/bloc/profile/academic_experience_api/academic_data.dart';
import 'package:eduarno/repo/bloc/profile/interest_detail_data.dart';
import 'package:eduarno/repo/bloc/profile/live_session_data.dart';
import 'package:eduarno/repo/bloc/profile/model/notification_model.dart';
import 'package:eduarno/repo/bloc/profile/personal_detail_data.dart';
import 'package:eduarno/Utilities/routes.dart';
import 'package:eduarno/screens/auth/otp.dart';
import 'package:eduarno/screens/auth/sign_in.dart';
import 'package:eduarno/screens/auth/sign_up.dart';
import 'package:eduarno/screens/auth/welcome.dart';
import 'package:eduarno/screens/chat/components/chat_message.dart';
import 'package:eduarno/screens/profile/interest_screen.dart';
import 'package:eduarno/screens/profile/signup_interest.dart';
import 'package:eduarno/screens/chat/chatsScreen.dart';
import 'package:eduarno/screens/session/session_detail.dart';
import 'package:eduarno/screens/session/session_provider.dart';
import 'package:eduarno/screens/wallet/wallet_provider.dart';
import 'package:eduarno/widgets/bottom_app_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'repo/bloc/user.dart';

// Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
//   if (message.containsKey('data')) {
//     // Handle data message
//     final dynamic data = message['data'];
//   }

//   if (message.containsKey('notification')) {
//     // Handle notification message
//     final dynamic notification = message['notification'];
//   }

//   // Or do other work.
// }

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.notification.title);
  print(message.notification.body);
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await User().init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print('Get interest added bool value ----->>> ${User().interestAdded}');
  print('Get new user bool value ----->>> ${User().isNewUser}');
  print('Get name bool value ----->>> ${User().name}');
  print('Get assessment taken value ----->>> ${User().isAssessment}');

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => WalletProvider()),
      ChangeNotifierProvider(create: (_) => SessionProvider()),
      ChangeNotifierProvider(create: (_) => User()),
      ChangeNotifierProvider(create: (_) => FilterBloc()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider(create: (_) => CMSProvider()),
      ChangeNotifierProvider(create: (_) => AcademicProvide()),
      ChangeNotifierProvider(create: (_) => AssessmentProvider()),
      ChangeNotifierProvider(create: (_) => InterestProvider()),
      ChangeNotifierProvider(create: (_) => LiveSessionProvider()),
      ChangeNotifierProvider(create: (_) => ChatMessageNotifier()),
      ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showInterestScreen = false;
  bool showHomeScreen = false;

  @override
  void initState() {
    super.initState();
    initializeFCM();
  }

  void initializeFCM() {
    getToken();
    // initializeNotification();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification;
      notification = message.notification;
      // ignore: omit_local_variable_types
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
  }

  getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    print('Fcm token ---------> $token');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eduarno',
      // theme: ThemeData(
      //   fontFamily: 'Poppins',
      //   canvasColor: Colors.transparent,
      //   unselectedWidgetColor: kGreyColor,
      // ),
      theme: EduarnoTheme.lightTheme(context),
      routes: {
        Routes.welcomePage: (context) => Welcome(),
        Routes.signInPage: (context) => SignIn(),
        Routes.signUpPage: (context) => SignUp(),
        Routes.interestPage: (context) => InterestScreen(),
        Routes.otpPage: (context) => Otp(),
        Routes.bottomNav: (context) => MyBottomBar(),
        Routes.signUpInterest: (context) => SignupInterest(),
        Routes.sessionDetails: (conetxt) => SessionDetail(),
        Routes.chatScreen: (conetxt) => ChatScreen(),
      },
      // home: Provider.of<User>(context).name != null ? MyBottomBar() : Welcome(),
      //initialRoute: Routes.bottomNav

      // initialRoute: (Provider.of<User>(context).isNewUser != null &&
      //         Provider.of<User>(context).isNewUser)
      //     ? (((Provider.of<User>(context).interestAdded != null &&
      //                 Provider.of<User>(context).interestAdded) &&
      //             (Provider.of<User>(context).isAssessment != null &&
      //                 Provider.of<User>(context).isAssessment == true))
      //         ? Routes.bottomNav
      //         : Routes.signUpInterest)
      //     : Routes.welcomePage,
      initialRoute: (Provider.of<User>(context).isNewUser != null &&
              Provider.of<User>(context).isNewUser)
          ? (((Provider.of<User>(context).interestAdded != null &&
                      Provider.of<User>(context).interestAdded) &&
                  (Provider.of<User>(context).isAssessment != null &&
                      Provider.of<User>(context).isAssessment == true))
              ? Routes.bottomNav
              : Routes.signInPage)
          : Routes.welcomePage,
    );
  }
}
