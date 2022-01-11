import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/expert/expert_bottom_nav.dart';
import 'package:vlcc/providers/add_appointment_provider.dart';
import 'package:vlcc/providers/consultation_provider.dart';
import 'package:vlcc/providers/explore_clinics_provider.dart';
import 'package:vlcc/providers/feedback_provider.dart';
import 'package:vlcc/providers/notification_provider_expert.dart';
import 'package:vlcc/providers/reminder_consultation_provider.dart';
import 'package:vlcc/providers/reminder_provider.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/providers/video_consult_listing_provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/vlcc_theme.dart';
import 'package:vlcc/screens/bottom_bar/bottom_bar.dart';
import 'package:vlcc/screens/home_screen.dart';
import 'package:vlcc/screens/miscellaneous/notification_expert_screen.dart';
import 'package:vlcc/screens/miscellaneous/notifications_screen.dart';
import 'package:vlcc/screens/miscellaneous/privacy_policy.dart';
import 'package:vlcc/screens/miscellaneous/terms_condition.dart';
import 'package:vlcc/screens/packages/package_provider.dart';
import 'package:vlcc/screens/packages/package_routes.dart';
import 'package:vlcc/screens/packages/packages.dart';
import 'package:vlcc/screens/profile/expert_profile.dart';
import 'package:vlcc/screens/profile/profile.dart';
import 'package:vlcc/screens/profile/profile_page_routes.dart';
import 'package:vlcc/screens/sign_up/sign_up.dart';
import 'package:vlcc/screens/welcome_screen.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_widgets.dart';
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';
import 'database/db_helper.dart';
import 'providers/appointments_provider.dart';
import 'resources/notification_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize();
  await VlccShared().init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: AppColors.backgroundColor),
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  runApp(const MyApp());
}

Future<dynamic> onSelectNotificationPayload(payload) async {
  if (payload != null) {
    log(payload, name: 'payload', error: 'payload');
    var jsonPayload = json.decode(payload);

    if (jsonPayload["data"]["action"] == 'reminder') {
      Get.to(
        () => ConsumerBottomBar(
          isAppointment: true,
          appointmentId: jsonPayload["notificationId"],
          selectedPage: 0,
        ),
      );
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  VlccShared sharedPrefs = VlccShared();
  @override
  void initState() {
    super.initState();
    initializeFCM();
  }

  void initializeFCM() async {
    await getToken();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotificationPayload,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification;
      notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification?.title,
            notification?.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
              ),
            ));
      }
    });
  }

  Future<void> getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    log('$token', name: 'Firebase token');
    VlccShared().fcmToken = token ?? '';
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NotificationProviderExpert()),
          ChangeNotifierProvider(create: (_) => ExploreClinicsProvider()),
          ChangeNotifierProvider(create: (_) => VideoConsultListingProvider()),
          ChangeNotifierProvider(create: (_) => AppointmentsProvider()),
          ChangeNotifierProvider(create: (_) => FeedbackProvider()),
          ChangeNotifierProvider(create: (_) => AddAppointmentProvider()),
          ChangeNotifierProvider(create: (_) => AddAppointmentProvider()),
          ChangeNotifierProvider(create: (_) => ReminderConsultationProvider()),
          ChangeNotifierProvider(create: (_) => ReminderProvider()),
          ChangeNotifierProvider(create: (_) => ConsultationProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => DashboardProvider()),
          ChangeNotifierProvider(create: (_) => PackageProvider()),
          ChangeNotifierProvider(create: (_) => VlccShared()),
          ChangeNotifierProvider(create: (_) => DatabaseHelper()),
        ],
        child: GetMaterialApp(
          title: 'VLCC',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: VlccThemeData.lightTheme(context),
          navigatorObservers: <RouteObserver<ModalRoute<void>>>[routeObserver],
          routes: {
            ProfilePageRoutes.profileMain: (context) => Profile(),
            ProfilePageRoutes.profileExpert: (context) => ExpertProfile(),
            PackageRoutes.notificationsExpert: (context) =>
                NotificationExpertScreen(),
            PackageRoutes.packageDashboard: (context) => PackageDashboard(),
            PackageRoutes.packageInvoice: (context) => InvoiceListing(),
            PackageRoutes.termsAndConditions: (context) => TermsAndConditions(),
            PackageRoutes.notifications: (context) => NotificationScreen(),
            PackageRoutes.welcomeScreen: (context) => WelComeScreen(),
            PackageRoutes.privacyPolicy: (context) => PrivacyPolicy(),
            PackageRoutes.home: (context) =>
                const HomeScreen(title: 'VLCC Wellness'),
            PackageRoutes.bottomBar: (context) =>
                ConsumerBottomBar(selectedPage: 0)
          },
          home: sharedPrefs.authToken != ''
              ? (sharedPrefs.isExpert)
                  ? ExpertBottomBar()
                  : (sharedPrefs.isSignupProfileComplete
                      ? ConsumerBottomBar(selectedPage: 0)
                      : ProfileScreen())
              : WelComeScreen(),
        ),
      );
}
