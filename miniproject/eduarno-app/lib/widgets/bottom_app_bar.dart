import 'package:badges/badges.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/auth/login.dart';
import 'package:eduarno/repo/bloc/profile/live_session_data.dart';
import 'package:eduarno/repo/bloc/profile/model/notification_model.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/screens/assessment/assesment_listing.dart';
import 'package:eduarno/screens/auth/welcome.dart';
import 'package:eduarno/screens/profile/notification_screen.dart';
import 'package:eduarno/screens/profile/profile.dart';
import 'package:eduarno/screens/session/session_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MyBottomBar extends StatefulWidget {
  final bool isSignup;

  const MyBottomBar({this.isSignup = false});
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar>
    with SingleTickerProviderStateMixin {
  int _selectedPageIndex;
  NotificationProvider notifications = NotificationProvider();

  TabController tabController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  LiveSessionProvider liveSessionDetails = LiveSessionProvider();

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      tabController.index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    liveSessionDetails.getLiveSessionDetails().then((value) {
      User().setTrigger(liveSessionDetails.response.data.first.isAvailable);
    });
    notifications.getNotifications().then((value) {
      // setState(() {
      //   apiHit = true;
      //   // _notificationResponse = value;
      // });
    });
    tabController = TabController(length: 4, vsync: this);
    _selectedPageIndex = widget.isSignup ? 1 : 0;
    tabController.index = widget.isSignup ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final notify = context.watch<NotificationProvider>();
    // ignore: omit_local_variable_types
    // NotificationProvider notification = NotificationProvider();
    // final notification = context.
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(title: Text("Assessment")),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          SessionScreen(openDrawer: () {
            _scaffoldKey.currentState.openDrawer();
          }),
          AssessmentListing(openDrawer: () {
            _scaffoldKey.currentState.openDrawer();
          }),
          NotificationScreen(openDrawer: () {
            _scaffoldKey.currentState.openDrawer();
          }),
          Profile(openDrawer: () {
            _scaffoldKey.currentState.openDrawer();
          }),
        ],
      ),
      // _pages[_selectedPageIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10))
                  // circular(10)
                  ),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        // widget.goToProfile();
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/demo.png'),
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hello!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                        Container(
                          width: 160,
                          child: Text(
                            User().name,
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            ListTile(
              leading: SvgPicture.asset('assets/Home_fill.svg',
                  color: Color(0xff303030)),
              title: Text(
                'Session',
                style: TextStyle(
                    color: Color(0xff303030),
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () {
                _selectPage(0);
                // tabController.index = 0;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: SvgPicture.asset('assets/Graph_fill.svg',
                  color: Color(0xff303030)),
              title: Text(
                'Assessment',
                style: TextStyle(
                    color: Color(0xff303030),
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () {
                _selectPage(1);
                // tabController.index = 1;
                Navigator.pop(context);
              },
            ),
            // ListTile(
            //   leading: SvgPicture.asset("assets/Notification_fill.svg",
            //       color: Colors.white),
            //   title: Text(
            //     'Notifications',
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 18,
            //         fontWeight: FontWeight.normal),
            //   ),
            //   onTap: () {
            //     tabController.index = 2;
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/profile_filled.svg',
                color: Color(0xff303030),
                fit: BoxFit.fitHeight,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    color: Color(0xff303030),
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () {
                _selectPage(3);
                // tabController.index = 3;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Color(0xff303030),
              ),
              title: Text(
                'Sign out',
                style: TextStyle(
                    color: Color(0xff303030),
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () async {
                await AuthProvider.logOut();
                await Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(pageBuilder: (BuildContext context,
                        Animation animation, Animation secondaryAnimation) {
                      return Welcome();
                    }, transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    }),
                    (Route route) => false);
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        strokeColor: AppColors.primaryColor,
        scaleCurve: Curves.elasticOut,
        //selectedColor: Colors.grey,
        //unSelectedColor: Colors.orange,
        //selectedColor: Colors.deepOrangeAccent,
        currentIndex: _selectedPageIndex,
        items: [
          CustomNavigationBarItem(
            icon: _selectedPageIndex == 0
                ? SvgPicture.asset('assets/Home_fill.svg',
                    color: Color(0xff41C36C))
                : SvgPicture.asset('assets/Home.svg', color: Color(0xff303030)),
          ),
          CustomNavigationBarItem(
            icon: _selectedPageIndex == 1
                ? SvgPicture.asset('assets/Graph_fill.svg',
                    color: Color(0xff41C36C))
                : SvgPicture.asset('assets/Graph.svg',
                    color: Color(0xff303030)),
          ),
          CustomNavigationBarItem(
            icon: _selectedPageIndex == 2
                ? Badge(
                    showBadge: notify.notificationCount != 0,
                    // notification.notificationCount != 0,
                    padding: const EdgeInsets.all(5.0),
                    position: BadgePosition.topEnd(top: -15, end: -10),
                    badgeColor: kPrimaryGreenColor,
                    badgeContent: Text(
                      // '${notification.notificationCount}',
                      '${notify.notificationCount}',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    child: SvgPicture.asset('assets/Notification_fill.svg',
                        color: Color(0xff41C36C)),
                  )
                : Badge(
                    showBadge: notify.notificationCount != 0,
                    // notification.notificationCount != 0,
                    padding: const EdgeInsets.all(5.0),
                    position: BadgePosition.topEnd(top: -15, end: -10),
                    badgeColor: kPrimaryGreenColor,
                    badgeContent: Text(
                      // '${notification.notificationCount}',
                      '${notify.notificationCount}',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    child: SvgPicture.asset('assets/Notification.svg',
                        color: Color(0xff303030)),
                  ),
          ),
          CustomNavigationBarItem(
            icon: _selectedPageIndex == 3
                ? SvgPicture.asset('assets/profile_filled.svg',
                    color: Color(0xff41C36C))
                : SvgPicture.asset('assets/Profile.svg',
                    color: Color(0xff303030)),
          ),
        ],
      ),
    );
  }
}
