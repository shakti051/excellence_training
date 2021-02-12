import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'Bottomtabs/model/BottombarController.dart';
import 'DrawerScreen.dart';
import 'HomeScreen.dart';

class HomeDrawerBottomScreen extends StatefulWidget {


  @override
  _HomeDrawerBottomScreenState createState() => _HomeDrawerBottomScreenState();
}

class _HomeDrawerBottomScreenState extends State<HomeDrawerBottomScreen> {
  bool isdrawerOpen=false;
  String _currentIndex='0';

  BottombarController getxController = Get.put(BottombarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: !isdrawerOpen
      //     ? PandaBar(
      //   backgroundColor: whitecolor,
      //
      //   buttonColor: orangecolor,
      //   buttonSelectedColor: bluecolor,
      //   fabColors: [bluecolor, bluecolor],
      //   fabIcon: Image.asset("assets/images/Writers.png",),
      //   buttonData: [
      //     PandaBarButtonData(
      //       id: '1',
      //       icon: Icons.dashboard,
      //       title: 'Home',
      //     ),
      //     PandaBarButtonData(
      //         id: '2', icon: Icons.book, title: 'Explore'),
      //     PandaBarButtonData(
      //         id: '3',
      //         icon: Icons.account_balance_wallet,
      //         title: 'Profile'),
      //     PandaBarButtonData(
      //         id: '4', icon: Icons.settings, title: 'Setting'),
      //   ],
      //   onChange: (id) {
      //
      //     print(id);
      //     getxController.changeBottomTab(id);
      //
      //
      //   },
      //   onFabButtonPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateEventScreen()));
      //
      //   },
      // )
      //     : Container(),

      bottomNavigationBar: !isdrawerOpen
          ?BottomNavyBar(
          showElevation:true,
        selectedIndex: int.parse(_currentIndex),
        onItemSelected: (index) {
          getxController.changeBottomTab(index.toString());
          setState(() => _currentIndex = index.toString());
          // _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('My Feeds'),
              icon:  Icon(Icons.dashboard),
            activeColor: bluecolor,
          ),
          BottomNavyBarItem(
              title: Text('Writers'),
              icon: Icon(FontAwesomeIcons.pen),
            activeColor: orangecolor,
          ),
          BottomNavyBarItem(
              title: Text('preferences'),
              icon: Icon(Icons.settings_applications),
            activeColor: Colors.green,
          ),
          // BottomNavyBarItem(
          //     title: Text('Item Four'),
          //     icon: Icon(Icons.settings)
          // ),
        ],
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

