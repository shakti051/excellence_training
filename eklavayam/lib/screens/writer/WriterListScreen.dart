import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/WritersListModel.dart';

class WriterListScreen extends StatefulWidget {
  @override
  _WriterListScreenState createState() => _WriterListScreenState();
}

class _WriterListScreenState extends State<WriterListScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name, image, mobile, token;
  int uniqueId;

  List<WritersListData> writerList;

  Future<void> getWriterListApiCall() async {
    var jsonstring = {"userId": 290};
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(writerListUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      WritersListModel writersListModel =
      WritersListModel.fromJson(responsedata);
      setState(() {
        writerList = writersListModel.data;
      });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  Future<void> followApiCall(int followerid) async {
    var jsonstring = {
      "userId": uniqueId,
      "followerId": followerid
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(followUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RazorPayScreen(amount: responsedata['amount'],orderid: responsedata['orderId'],)));

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  Future<void> unFollowApiCall(int followerid) async {
    var jsonstring = {
      "userId": uniqueId,
      "followerId": followerid
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(unFolowUrl, jsondata);

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
    // TODO: implement initState
    super.initState();
    restoreSF();
    Future.delayed(Duration.zero, () => getWriterListApiCall());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * .3,
                          child: Image.asset(
                            "assets/images/background.jpg",
                            fit: BoxFit.fill,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                       bottom: 0,

                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                      width: MediaQuery.of(context).size.width,
                          color: Colors.white.withOpacity(.3),
                          child:    Text(
                            "Writers",
                            style: TextStyle(
                              color: bluecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),

                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: writerList != null
                          ? ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: writerList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  right: 15, top: 15, bottom: 15),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: FractionalOffset.bottomLeft,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 45),
                                        height: 100,
                                       // padding: EdgeInsets.all(2),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: orangecolor),
                                        child: ClipRRect(

                                          borderRadius: BorderRadius
                                              .circular(10),
                                          child: writerList[index]
                                              .coverImg !=
                                              null
                                              ? Image.network(
                                            writerList[index]
                                                .coverImg,fit: BoxFit.cover,)
                                              : Image.asset(
                                              "assets/images/writerpen.jpg",fit: BoxFit.cover),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          padding: EdgeInsets.all(1),
                                            margin: EdgeInsets.only(left: 30),
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    100),
                                                color: bluecolor),
                                            child: ClipRRect(

                                                borderRadius: BorderRadius
                                                    .circular(100),
                                                child: writerList[index]
                                                    .profileImg !=
                                                    null
                                                    ? Image.network(
                                                    writerList[index]
                                                        .profileImg,fit: BoxFit.fill,)
                                                    : Image.asset(
                                                    "assets/images/logo.png",fit: BoxFit.fill),
                                            ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 130, top: 10),
                                          child: writerList[index]
                                              .fullName
                                              .length <
                                              30
                                              ? Text(
                                            writerList[index]
                                                .fullName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 16),
                                          )
                                              : Text(
                                            writerList[index]
                                                .fullName
                                                .substring(
                                                0, 28) +
                                                "...",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      if( writerList[index].followType=="Follow")
                                        {
                                          followApiCall( writerList[index].objectId);
                                          setState(() {
                                            writerList[index].followType="UnFollow";
                                          });
                                        }
                                      else{
                                        {
                                          unFollowApiCall( writerList[index].objectId);
                                          setState(() {
                                            writerList[index].followType="Follow";
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 25),
                                      height: 35,
                                      width: 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: bluecolor,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        writerList[index]
                                            .followType,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                          : Container(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
