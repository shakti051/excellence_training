import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/home/Bottomtabs/model/AboutModel.dart';
import 'package:eklavayam/screens/home/Bottomtabs/model/UserDetailModel.dart';
import 'package:eklavayam/screens/home/Bottomtabs/profile/profiletab/PostScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/profile/profiletab/abouttab/AboutTabScreen.dart';
import 'package:eklavayam/screens/home/Bottomtabs/profile/profiletab/abouttab/SocialMediaScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'abouttab/AchievmentScreen.dart';
import 'abouttab/AwardsScreen.dart';
import 'abouttab/BookPublishedScreen.dart';
import 'abouttab/MediaGallaryScreen.dart';

class AboutScreen extends StatefulWidget {

  int userid,loggeduserid;

  AboutScreen(this.userid,this.loggeduserid);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with SingleTickerProviderStateMixin{

  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  TabController _controller;
  int _selectedIndex = 0;
  List<BookData> bookData;
  List<AchievementData> achievementData;
  List<AwardData> awardData;
  List<VideoData> videoData;
  bool dataload=false;
  bool dataload1=false;
  UserDetailModel userDetailModel;

  String name,image,mobile,token;
  int uniqueId;

  bool me=true;

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

  Future<void> getAboutUsList() async {

    var jsonstring=
    {
      "userId":widget.userid,
      "loggedUserId":widget.loggeduserid
    };
    var jsondata=jsonEncode(jsonstring);
    print("AboutScreen "+jsondata);
    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(getUserAboutUsUrl,jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      AboutModel aboutModel = new AboutModel.fromJson(responsedata);

      bookData = aboutModel.data.bookData;
      achievementData = aboutModel.data.achievementData;
      awardData = aboutModel.data.awardData;
      videoData = aboutModel.data.videoData;
      setState(() {
        dataload=true;
      });

    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['msg']);
    //print(responsedata['status']);
  }

  Future<void> getUserbyIdApiCall() async {
    var jsonstring = {
      "uniqueId": widget.userid//uniqueId
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

      userDetailModel=UserDetailModel.fromJson(responsedata);
      setState(() {
        dataload1=true;
      });
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RazorPayScreen(amount: responsedata['amount'],orderid: responsedata['orderId'],)));

    } else
      showSnakbarWithGlobalKey(_scafoldKey, "some error occure");
  }

  @override
  void initState() {
   
    super.initState();
    restoreSF();

    if(widget.userid==widget.loggeduserid)
      {
        setState(() {
          me=true;
        });
      }
    else  {
      setState(() {
        me=false;
      });
    }

    // Create TabController for getting the index of current tab

    Future.delayed(Duration.zero, () => callApies());

    _controller = TabController(length: 6, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  callApies()
  {
    getAboutUsList();
    getUserbyIdApiCall();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:  Container(child:
          Column(
            children: <Widget>[
            Container(
            height: 60,
            margin: EdgeInsets.only(left: 10,right: 10),
            child: TabBar(
              tabs: [
                Container(
                  child: new Text(
                    'About',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(

                  child: new Text(
                    'Social',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(

                  child: new Text(
                    'Books',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(

                  child: new Text(
                    'Achievments',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(

                  child: new Text(
                    'Awards',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(

                  child: new Text(
                    'Media',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
              unselectedLabelColor: bluecolor,
              indicatorColor: orangecolor,
              labelColor: orangecolor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 1.0,
              indicatorPadding: EdgeInsets.all(5),
              isScrollable: true,
              controller: _controller,
            ),
          ),
              Container(
                height: MediaQuery.of(context).size.height-200,
                child: TabBarView(
                    controller: _controller,
                    children: <Widget>[

                      dataload1==true?AboutTabScreen(userDetailModel,me):Container(),
                      dataload1==true?SocialMediaScreen(userDetailModel,me):Container(),
                      dataload==true? BookPublishedScreen(bookData,me):Container(),
                      dataload==true? AchievmentScreen(achievementData,me):Container(),
                      dataload==true? AwardsScreen(awardData,me):Container(),
                      dataload==true? MediaGallaryScreen(videoData,me):Container(),

                    ]),
              )])

      ),
      
    );

  }
}
