import 'package:eklavayam/screens/event/CreateEventScreen.dart';
import 'package:eklavayam/screens/event/EventDashboardScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/ExploreScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/ProfileScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/SettingScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/StoryFeedScreen.dart';
import 'package:eklavayam/screens/home/NotificationScreen.dart';
import 'package:eklavayam/screens/writer/WriterListScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Bottomtabs/model/BottombarController.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isdrawerOpen = false;
  BottombarController getxController = Get.put(BottombarController());
  String page = '1';

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        duration: Duration(milliseconds: 250),
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isdrawerOpen ? 40 : 0),
        ),
        child:
        Stack(
          children: <Widget>[

            GetX<BottombarController>(
              builder: (context) {
                switch (getxController.spage.value) {
                  case '0':
                    return StoryBoardScreen();
                  case '1':
                    return WriterListScreen();
                  case '2':
                    return SettingScreen();
                  case '3':
                    return ProfileScreen();
                  case '4':
                    return SettingScreen();
                  default:
                    return Container();
                }
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: whitecolor,
                padding: EdgeInsets.only(top: 35),
                // margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isdrawerOpen
                        ? IconButton(
                        icon: Icon(Icons.keyboard_backspace),
                        onPressed: () {
                          setState(() {
                            xOffset = 0;
                            yOffset = 0;
                            scaleFactor = 1;
                            isdrawerOpen = false;
                          });
                        })
                        : IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            xOffset = 230;
                            yOffset = 150;
                            scaleFactor = 0.6;
                            isdrawerOpen = true;
                          });
                        }),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/fulllogo.png",
                          height: 50,
                          width: 170,
                        ),
                      ],
                    ),
                    IconButton(
                        icon: Icon(Icons.notifications), onPressed: () {
                          Get.to(NotificationScreen());

                    }),

                  ],
                ),
              ),
            )
          ],
        ),

      );

  }
}
