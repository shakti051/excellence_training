import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/home/Bottomtabs/model/NotificationModel.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bottomtabs/one_story_feed_screen.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name, image, mobile, token;
  int uniqueId;

  List<NotificationData> notificationdata = List();

  Future<void> getNotificationListApiCall() async {
    var jsonstring = {"userId": uniqueId};
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata =
        await networkClient.postData(getNotificationUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      NotificationModel notificationModel =
          NotificationModel.fromJson(responsedata);
      setState(() {
        notificationdata = notificationModel.data;
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
    Future.delayed(Duration.zero, () => getNotificationListApiCall());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: bluecolor,
        title: Text(
          "Notificatons",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: notificationdata.length != null
          ? ListView.builder(
              itemCount: notificationdata.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OneStoryFeedScreen(
                        notificationdata[index].targetObjectId)));
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    height: 80,
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                          color: Colors.grey.shade100,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0)),
                          child: Container(
                              padding: EdgeInsets.all(1),
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                //color: bluecolor,
                                shape: BoxShape.circle,
                              ),
                              child: notificationdata[index].profileImg != null
                                  ? Image.network(
                                      notificationdata[index].profileImg)
                                  : Image.asset("assets/images/onlypen.png")),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(notificationdata[index].fullName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                              SizedBox(height: 5),
                              Text(notificationdata[index].contentText,maxLines: 3,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
          : Container(child: Center(child:Text("No Notification")),),
    );
  }
}
