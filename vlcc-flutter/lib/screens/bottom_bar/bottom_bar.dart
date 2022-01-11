import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/providers/feedback_provider.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/vlcc_theme.dart';
import 'package:vlcc/screens/appointments/appointments.dart';
import 'package:vlcc/screens/dashboard/dashboard_screen.dart';
import 'package:vlcc/screens/home_screen.dart';
import 'package:vlcc/screens/packages/packages.dart';
import 'package:vlcc/screens/search/search_page.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import 'package:vlcc/widgets/custom_alert_dialog.dart';

class ConsumerBottomBar extends StatefulWidget {
  final bool isAppointment;
  final int appointmentId;
  final int selectedPage;

  const ConsumerBottomBar({
    Key? key,
    this.isAppointment = false,
    this.appointmentId = 0,
    required this.selectedPage,
  }) : super(key: key);

  @override
  _ConsumerBottomBarState createState() => _ConsumerBottomBarState();
}

class _ConsumerBottomBarState extends State<ConsumerBottomBar> {
  final FeedbackProvider _feedbackProvider = FeedbackProvider();
  final DashboardProvider _dashboardProvider = DashboardProvider();
  final PackageProvider _packageProvider = PackageProvider();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey bannerKey = GlobalKey(debugLabel: '_bannerKey');
  final GlobalKey notificationKey = GlobalKey(debugLabel: '_notificationKey');
  final GlobalKey profileKey = GlobalKey(debugLabel: '_profileKey');

  final GlobalKey homeBottomNavigationKey =
      GlobalKey(debugLabel: 'homeBottomNavigationKey');
  final GlobalKey appointmentBottomNavigationKey =
      GlobalKey(debugLabel: 'appointmentBottomNavigationKey');
  final GlobalKey dashboardBottomNavigationKey =
      GlobalKey(debugLabel: 'dashboardBottomNavigationKey');
  final GlobalKey searchBottomNavigationKey =
      GlobalKey(debugLabel: 'searchBottomNavigationKey');

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  final VlccShared _vlccShared = VlccShared();

  int selectedPage = 0;
  var _pageOptions = [];

  @override
  void initState() {
    selectedPage = widget.selectedPage;
    _pageOptions = [
      HomeScreen(
        title: 'VLCC',
        titleColor: AppColors.logoOrange,
      ),
      SearchPage(isComingFromBookNow: false),
      Appointments(
        appointmentId: widget.appointmentId,
        isFromNotification: widget.isAppointment,
      ),
      DashboardScreen(
        title: 'VLCC',
        titleColor: AppColors.logoOrange,
      ),
    ];
    super.initState();
    // widget.isAppointment ? selectedPage = 2 : selectedPage = 0;
    // _dashboardProvider.bannerApiHit = false;
    //--------------------> Calling api to get banner <-------------------------------
    _feedbackProvider.getOfferBanner().then((value) {
      // _dashboardProvider.bannerApiHit = true;
    });
    _dashboardProvider.getProfileDetails();
    _packageProvider.getPackageInvoice();
    _databaseHelper.initializeDatabase().then((value) {
      log('Database Initialized');
      loadServices();
      loadCenters();
    });
  }

  void loadServices() {
    _databaseHelper.getServices().then((value) {
      _databaseHelper.setPopularService();
    });
  }

  void loadCenters() {
    _databaseHelper.getCenters();
  }

  void _showTutorial() {
    _initCoachTargets();

    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: AppColors.logoOrange,
      skipWidget: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor:
              MaterialStateProperty.all<Color>(AppColors.logoOrange),
          elevation: MaterialStateProperty.all<double>(8),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              fontSize: FontSize.defaultFont,
              fontWeight: FontWeight.bold,
              color: AppColors.logoOrange,
            ),
          ),
        ),
        onPressed: () {
          // _vlccShared.isFirstTimeLoginOnDevice(withValue: false);
          // setState(() {});
          log('onSkip button:', name: 'coach');
        },
        child: Text('SKIP'),
      ),
      paddingFocus: 10,
      // opacityShadow: 0.6,
      onFinish: () {
        // _vlccShared.isFirstTimeLoginOnDevice(withValue: false);
        // setState(() {});
      },
      onClickTarget: (target) {
        // _vlccShared.isFirstTimeLoginOnDevice(withValue: false);
        // setState(() {});
      },
      onClickOverlay: (target) {
        // _vlccShared.isFirstTimeLoginOnDevice(withValue: false);
        // setState(() {});
      },
      onSkip: () {
        // _vlccShared.isFirstTimeLoginOnDevice(withValue: false);
        // setState(() {});
      },
    )..show();
  }

  void _initCoachTargets() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: "homeBottomNavigationKey",
        keyTarget: homeBottomNavigationKey,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "This is your home page",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "notificationKey",
        keyTarget: HomeScreen.notificationKey,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  SizedBox(height: 8),
                  Text(
                    "Check your latest notifications here",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "profileKey",
        keyTarget: HomeScreen.profileKey,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  SizedBox(height: 40),
                  Text(
                    "Click here to access your profile details and settings",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "searchBottomNavigationKey",
        keyTarget: searchBottomNavigationKey,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Search for VLCC centres and available services here",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "appointmentBottomNavigationKey",
        keyTarget: appointmentBottomNavigationKey,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Get your list of booked appointments here.\n You can also book new appointments too.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "dashboardBottomNavigationKey",
        keyTarget: dashboardBottomNavigationKey,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const <Widget>[
                  Text(
                    "This is your dashboard!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _dashboardProvider = context.read<DashboardProvider>();
    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                onNo: () {
                  Navigator.pop(context);
                },
                onYes: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              );
            });
        return Future.value(false);
      },
      child: KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection
        ],
        child: Scaffold(
            key: _scaffoldKey,
            body: _pageOptions[selectedPage],
            floatingActionButton: Visibility(
              visible:
                  selectedPage == 0 && (_vlccShared.isFirstTimeLogin ?? false),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                  elevation: MaterialStateProperty.all<double>(8),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: FontSize.defaultFont)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: _showTutorial,
                child: Text('Take tour'),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      key: homeBottomNavigationKey,
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.home_rounded,
                        color: selectedPage == 0
                            ? VlccColor.themeOrange
                            : Colors.grey,
                      ),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                  icon: Padding(
                    key: searchBottomNavigationKey,
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      SVGAsset.searchIcon,
                      color: selectedPage == 1
                          ? VlccColor.themeOrange
                          : Colors.grey,
                    ),
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    key: appointmentBottomNavigationKey,
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      "assets/images/appointment.svg",
                      color: selectedPage == 2
                          ? VlccColor.themeOrange
                          : Colors.grey,
                    ),
                  ),
                  label: 'Appointments',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    key: dashboardBottomNavigationKey,
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      "assets/images/dashboard.svg",
                      color: selectedPage == 3
                          ? VlccColor.themeOrange
                          : Colors.grey,
                    ),
                  ),
                  label: 'Dashboard',
                ),
              ],
              currentIndex: selectedPage,
              backgroundColor: Colors.white,
              onTap: (index) {
                setState(() {
                  _dashboardProvider.bottomNavIndex = index;
                  selectedPage = index;
                });
              },
            )),
      ),
    );
  }
}
