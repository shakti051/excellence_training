import 'package:eklavayam/screens/authentication/login_signup/ui/login_page.dart';
import 'package:eklavayam/screens/compitions/CompetionsScreen.dart';
import 'package:eklavayam/screens/event/CreateEventScreen.dart';
import 'package:eklavayam/screens/event/EventDashboardScreen.dart';
import 'package:eklavayam/screens/event/MyTicketScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/profile/ProfileHomeScreen.dart';
import 'package:eklavayam/screens/home/HomeDrawerBottomScreen.dart';
import 'package:eklavayam/screens/home/Home_Drwawer_Screen.dart';
import 'package:eklavayam/screens/splash/SplashScreen.dart';
import 'package:eklavayam/screens/writer/WriterListScreen.dart';
import 'package:eklavayam/screens/writer/WriterToolScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/StaticString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String name, image, mobile, token, profileStatus;
  int uniqueId;

  restoreSF() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      name = (sharedPrefs.getString('fullName') ?? "Mr.");
      profileStatus = (sharedPrefs.getString('profileStatus') ??
          "Hey there! I am using Eklavyam");
      image = (sharedPrefs.getString('image') ?? "");
      mobile = (sharedPrefs.getString('mobile') ?? "");
      token = (sharedPrefs.getString('token') ?? "");
      uniqueId = (sharedPrefs.getInt('uniqueId') ?? 0);

      // print(name + " " + image + " " + mobile + " " + token);
      //print("SFtoken> " + token);
    });
  }

  @override
  void initState() {

    super.initState();
    restoreSF();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, bottom: 30, left: 20),
      color: bluecolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // CircleAvatar(),
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "hi " + name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    profileStatus,
                    style: TextStyle(fontSize: 15, color: Colors.grey[300]),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: drawerItems
                    .map((element) => Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: GestureDetector(
                            onTap: () {
                              print("click");
                              if (element['title'] == "My Feed")
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeDrawerBottomScreen()));
                              else if (element['title'] == "Writer Tool")
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WriterToolScreen()));
                              else if (element['title'] == "Writers")
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WriterListScreen()));
                              else if (element['title'] == "Dictionary")
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SplashScreen()));
                              else if (element['title'] == "All Events")
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EventDashboardScreen()));
                              else if (element['title'] == "Create Events")
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateEventScreen()));
                              else if (element['title'] == "My Tickets")
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyTicketScreen()));
                              else if (element['title'] == "Compitions")
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompetionsScreen()));
                              else if (element['title'] == "My Profile")
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileHomeScreen(uniqueId,uniqueId)));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  element['icon'],
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  element['title'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Settings",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                height: 20,
                width: 2,
                color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
