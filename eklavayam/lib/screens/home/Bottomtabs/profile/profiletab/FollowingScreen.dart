import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/home/Bottomtabs/model/FollowingProfileModel.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowingScreen extends StatefulWidget {

  int userid,loggeduserid;

  FollowingScreen(this.userid,this.loggeduserid);

  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  List<FollowingData> followinglist;
  String name, image, mobile, token;
  int uniqueId;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> getUserFolowingApiCall() async {
    var jsonstring = {
      "userId": widget.userid //uniqueId
    };
    var jsondata = jsonEncode(jsonstring);
    //print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata =
        await networkClient.postData(getUserFollowingUrl, jsondata);
    print("getUserFolowingApiCall");
    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      FollowingProfileModel followingProfileModel =
          FollowingProfileModel.fromJson(responsedata);
      setState(() {
        followinglist = followingProfileModel.data;
      });
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
    restoreSF();
    Future.delayed(Duration.zero, () => getUserFolowingApiCall());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [

          Container(
            alignment: Alignment.center,
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: orangecolor,
            child: Text("Following",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
          ),
SizedBox(height: 5,),
          followinglist != null
              ? ListView.builder(
                  itemCount: followinglist.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        height: 80,
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(
                                      100),
                                  color: bluecolor),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: followinglist[index].profileImg != null
                                      ? Image.network(
                                          followinglist[index].profileImg,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset("assets/images/logo.png")),
                            ),
                            SizedBox(width: 5,),
                            Expanded(child: Text(followinglist[index].fullName)),
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: bluecolor),
                              child: Text(
                                "Unfollow",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Container(),
        ],
      ),
    );
  }
}
