import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/expert/expert_appointments.dart';
import 'package:vlcc/expert/expert_dashboard.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/screens/profile/expert_profile.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import 'package:vlcc/widgets/custom_alert_dialog.dart';

class ExpertBottomBar extends StatefulWidget {
  const ExpertBottomBar({Key? key}) : super(key: key);

  @override
  _ExpertBottomBarState createState() => _ExpertBottomBarState();
}

class _ExpertBottomBarState extends State<ExpertBottomBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int selectedPage = 0;
  var _pageOptions = [];

  @override
  void initState() {
    _pageOptions = [
      ExpertDashboardScreen(),
      ExpertAppointmentScreen(),
      ExpertProfile(),
    ];
    super.initState();
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
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        "assets/images/dashboard.svg",
                        color: selectedPage == 0 ? Colors.white : Colors.white,
                      ),
                    ),
                    label: 'Dashboard'),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      "assets/images/appointment.svg",
                      color: selectedPage == 1 ? Colors.white : Colors.white,
                    ),
                  ),
                  label: 'Appointments',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      "assets/images/profile-circle.svg",
                      color: selectedPage == 2 ? Colors.white : Colors.white,
                    ),
                  ),
                  label: 'Profile',
                ),
              ],
              currentIndex: selectedPage,
              backgroundColor: AppColors.logoOrange,
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
