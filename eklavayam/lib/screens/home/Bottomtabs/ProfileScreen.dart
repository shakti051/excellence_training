import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/home/Bottomtabs/profile_bubble_indication_painter.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController;

  String name, image, mobile, token;
  int uniqueId;

  Color first = Colors.black;
  Color second = Colors.white;
  Color third = Colors.white;
  Color fourth = Colors.white;
  Color fifth = Colors.white;


  Future<void> getUserbyIdApiCall() async {
    var jsonstring = {
      "uniqueId": uniqueId//uniqueId
    };
    var jsondata = jsonEncode(jsonstring);
   // print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(getUserbyIdUrl, jsondata);
    print("getUserbyIdApiCall");
    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {

      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RazorPayScreen(amount: responsedata['amount'],orderid: responsedata['orderId'],)));

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }



  Future<void> getUserContentApiCall() async {
    var jsonstring = {
      "uniqueId": uniqueId,
      "pageNumber": 0
    };
    var jsondata = jsonEncode(jsonstring);
   // print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(getUserContentUrl, jsondata);
    print("getUserContentApiCall");
    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {

      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RazorPayScreen(amount: responsedata['amount'],orderid: responsedata['orderId'],)));

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }



  restoreSF() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      name = (sharedPrefs.getString('name') ?? "Mr.");
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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
    restoreSF();
    Future.delayed(Duration.zero, () => callApis());
  }

  callApis()
  {
    getUserbyIdApiCall();
    //getUserFolowersApiCall();
    getUserContentApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      height: Get.height,
      width: Get.width,
      child: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          margin: EdgeInsets.only(top: 110),
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(right: 15, top: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: FractionalOffset.bottomLeft,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 65),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: orangecolor),
                          child: Image.asset(
                            "assets/images/background.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            margin: EdgeInsets.only(left: 30),
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: bluecolor),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  "assets/images/logo.png",
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 160, top: 0, bottom: 15),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/fb.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/twitter.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/insta.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/youtube.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/linkidin.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      //height: 35,
                      width: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: bluecolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Name",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),



              SizedBox(
                height: 20,
              ),
              _buildMenuBar(context),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (i) {
                    if (i == 0) {
                      setState(() {
                        first = Colors.black;
                        second = Colors.white;
                        third = Colors.white;
                        fourth = Colors.white;
                        fifth = Colors.white;
                      });
                    } else if (i == 1) {
                      setState(() {
                        first = Colors.white;
                        second = Colors.black;
                        third = Colors.white;
                        fourth = Colors.white;
                        fifth = Colors.white;
                      });
                    } else if (i == 2) {
                      setState(() {
                        first = Colors.white;
                        second = Colors.white;
                        third = Colors.black;
                        fourth = Colors.white;
                        fifth = Colors.white;
                      });
                    }
                    else if (i == 3) {
                      setState(() {
                        first = Colors.white;
                        second = Colors.white;
                        third = Colors.white;
                        fourth = Colors.black;
                        fifth = Colors.white;
                      });
                    }
                    else if (i == 4) {
                      setState(() {
                        first = Colors.white;
                        second = Colors.white;
                        third = Colors.white;
                        fourth = Colors.white;
                        fifth = Colors.black;
                      });
                    }
                  },
                  children: <Widget>[
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Container(
                        color: Colors.green,
                      ),
                    ),
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Container(
                        color: Colors.yellow,
                      ),
                    ),
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Container(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: Get.width - 5,
      height: 50.0,
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            colors: [bluecolor, bluecolor],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(
            dxTarget: 60, radius: 20, pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                padding: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onTabPress0,
                child: Center(
                  child: Text(
                    "Timeline",
                    style: TextStyle(
                      color: first,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                padding: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onTabPress1,
                child: Text(
                  "Post",
                  style: TextStyle(
                    color: second,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),

            Expanded(
              child: FlatButton(
                padding: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onTabPress2,
                child: Text(
                  "Follower",
                  style: TextStyle(
                    color: third,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                padding: EdgeInsets.only(left: 5, right: 0, top: 0, bottom: 0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onTabPress3,
                child: Text(
                  "Following",
                  style: TextStyle(
                    color: fourth,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                padding: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onTabPress4,
                child: Text(
                  "About",
                  style: TextStyle(
                    color: fifth,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTabPress0() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onTabPress1() {
    _pageController.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onTabPress2() {
    _pageController.animateToPage(2,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onTabPress3() {
    _pageController.animateToPage(3,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onTabPress4() {
    _pageController.animateToPage(4,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
