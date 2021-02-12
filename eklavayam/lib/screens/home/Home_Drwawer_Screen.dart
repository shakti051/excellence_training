import 'package:eklavayam/screens/event/CreateEventScreen.dart';
import 'package:eklavayam/screens/event/EventDashboardScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/model/BottombarController.dart';
import 'package:eklavayam/screens/home/DrawerScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';

import 'HomeScreen.dart';

class Home_Drawer_Screen extends StatelessWidget {
  bool isdrawerOpen=false;
  BottombarController getxController = Get.put(BottombarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: !isdrawerOpen
          ? PandaBar(
        backgroundColor: whitecolor,

        buttonColor: orangecolor,
        buttonSelectedColor: bluecolor,
        fabColors: [bluecolor, bluecolor],
        fabIcon: Image.asset("assets/images/Writers.png",),
        buttonData: [
          PandaBarButtonData(
            id: '1',
            icon: Icons.dashboard,
            title: 'Home',
          ),
          PandaBarButtonData(
              id: '2', icon: Icons.book, title: 'Explore'),
          PandaBarButtonData(
              id: '3',
              icon: Icons.account_balance_wallet,
              title: 'Profile'),
          PandaBarButtonData(
              id: '4', icon: Icons.settings, title: 'Setting'),
        ],
        onChange: (id) {

          print(id);
          getxController.changeBottomTab(id);


        },
        onFabButtonPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateEventScreen()));

        },
      )
          : Container(),
      body: Stack(
        children: [

          DrawerScreen(),
          HomeScreen(),
        ],

      ),
    );
  }
}
