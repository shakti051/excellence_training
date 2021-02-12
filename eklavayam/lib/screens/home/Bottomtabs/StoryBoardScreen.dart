import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/home/Bottomtabs/model/StoryfeedModel.dart';
import 'package:eklavayam/screens/home/CreatePostScreen.dart';
import 'package:eklavayam/screens/home/ShowFullSizeImagesScreen.dart';
import 'package:eklavayam/utill/ExtendedImageExample.dart';

import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:timeago/timeago.dart' as timeago;

class StoryBoardScreen extends StatefulWidget {
  @override
  _StoryBoardScreenState createState() => _StoryBoardScreenState();
}

class _StoryBoardScreenState extends State<StoryBoardScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  List<StoryfeedData> storylist;

  var locale = 'en';
  final now = new DateTime.now();

  String name, image, mobile, token;
  int uniqueId;

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

  PersistentBottomSheetController commentcontroller;

  AudioPlayer audioPlayer;

  int durationAnimationBox = 500;
  int durationAnimationBtnLongPress = 150;
  int durationAnimationBtnShortPress = 500;
  int durationAnimationIconWhenDrag = 150;
  int durationAnimationIconWhenRelease = 1000;

  // For long press btn
  AnimationController animControlBtnLongPress, animControlBox;
  Animation zoomIconLikeInBtn, tiltIconLikeInBtn, zoomTextLikeInBtn;
  Animation fadeInBox;
  Animation moveRightGroupIcon;
  Animation pushIconLikeUp,
      pushIconLoveUp,
      pushIconHahaUp,
      pushIconWowUp,
      pushIconSadUp,
      pushIconAngryUp;
  Animation zoomIconLike,
      zoomIconLove,
      zoomIconHaha,
      zoomIconWow,
      zoomIconSad,
      zoomIconAngry;

  // For short press btn
  AnimationController animControlBtnShortPress;
  Animation zoomIconLikeInBtn2, tiltIconLikeInBtn2;

  // For zoom icon when drag
  AnimationController animControlIconWhenDrag;
  AnimationController animControlIconWhenDragInside;
  AnimationController animControlIconWhenDragOutside;
  AnimationController animControlBoxWhenDragOutside;
  Animation zoomIconChosen, zoomIconNotChosen;
  Animation zoomIconWhenDragOutside;
  Animation zoomIconWhenDragInside;
  Animation zoomBoxWhenDragOutside;
  Animation zoomBoxIcon;

  // For jump icon when release
  AnimationController animControlIconWhenRelease;
  Animation zoomIconWhenRelease, moveUpIconWhenRelease;
  Animation moveLeftIconLikeWhenRelease,
      moveLeftIconLoveWhenRelease,
      moveLeftIconHahaWhenRelease,
      moveLeftIconWowWhenRelease,
      moveLeftIconSadWhenRelease,
      moveLeftIconAngryWhenRelease;

  Duration durationLongPress = Duration(milliseconds: 250);
  Timer holdTimer;
  bool isLongPress = false;
  bool isLiked = false;

  // 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = wow, 5 = sad, 6 = angry
  int whichIconUserChoose = 0;

  // 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = wow, 5 = sad, 6 = angry
  int currentIconFocus = 0;
  int previousIconFocus = 0;
  bool isDragging = false;
  bool isDraggingOutside = false;
  bool isJustDragInside = true;

  Future<void> getStoryList() async {
    showAlertDialog(context);

    var jsonstring = {"uniqueId": uniqueId, "pageNumber": 0};
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(getAllFeedUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      StoryfeedModel storyfeedModel = new StoryfeedModel.fromJson(responsedata);

      setState(() {
        storylist = storyfeedModel.data;
      });
    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['msg']);
    //print(responsedata['status']);
  }

  @override
  void initState() {
    super.initState();
    restoreSF();
    Future.delayed(Duration.zero, () => getStoryList());

    audioPlayer = AudioPlayer();

    // Button Like
    initAnimationBtnLike();

    // Box and Icons
    initAnimationBoxAndIcons();

    // Icon when drag
    initAnimationIconWhenDrag();

    // Icon when drag outside
    initAnimationIconWhenDragOutside();

    // Box when drag outside
    initAnimationBoxWhenDragOutside();

    // Icon when first drag
    initAnimationIconWhenDragInside();

    // Icon when release
    initAnimationIconWhenRelease();
  }

  initAnimationBtnLike() {
    // long press
    animControlBtnLongPress = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationBtnLongPress));
    zoomIconLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);
    tiltIconLikeInBtn =
        Tween(begin: 0.0, end: 0.2).animate(animControlBtnLongPress);
    zoomTextLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);

    zoomIconLikeInBtn.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn.addListener(() {
      setState(() {});
    });
    zoomTextLikeInBtn.addListener(() {
      setState(() {});
    });

    // short press
    animControlBtnShortPress = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationBtnShortPress));
    zoomIconLikeInBtn2 =
        Tween(begin: 1.0, end: 0.2).animate(animControlBtnShortPress);
    tiltIconLikeInBtn2 =
        Tween(begin: 0.0, end: 0.8).animate(animControlBtnShortPress);

    zoomIconLikeInBtn2.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn2.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxAndIcons() {
    animControlBox = AnimationController(
        vsync: this, duration: Duration(milliseconds: durationAnimationBox));

    // General
    moveRightGroupIcon = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 1.0)),
    );
    moveRightGroupIcon.addListener(() {
      setState(() {});
    });

    // Box
    fadeInBox = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.7, 1.0)),
    );
    fadeInBox.addListener(() {
      setState(() {});
    });

    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );

    pushIconLikeUp.addListener(() {
      setState(() {});
    });
    zoomIconLike.addListener(() {
      setState(() {});
    });
    pushIconLoveUp.addListener(() {
      setState(() {});
    });
    zoomIconLove.addListener(() {
      setState(() {});
    });
    pushIconHahaUp.addListener(() {
      setState(() {});
    });
    zoomIconHaha.addListener(() {
      setState(() {});
    });
    pushIconWowUp.addListener(() {
      setState(() {});
    });
    zoomIconWow.addListener(() {
      setState(() {});
    });
    pushIconSadUp.addListener(() {
      setState(() {});
    });
    zoomIconSad.addListener(() {
      setState(() {});
    });
    pushIconAngryUp.addListener(() {
      setState(() {});
    });
    zoomIconAngry.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDrag() {
    animControlIconWhenDrag = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));

    zoomIconChosen =
        Tween(begin: 1.0, end: 1.8).animate(animControlIconWhenDrag);
    zoomIconNotChosen =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDrag);
    zoomBoxIcon =
        Tween(begin: 50.0, end: 40.0).animate(animControlIconWhenDrag);

    zoomIconChosen.addListener(() {
      setState(() {});
    });
    zoomIconNotChosen.addListener(() {
      setState(() {});
    });
    zoomBoxIcon.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragOutside() {
    animControlIconWhenDragOutside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragOutside =
        Tween(begin: 0.8, end: 1.0).animate(animControlIconWhenDragOutside);
    zoomIconWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxWhenDragOutside() {
    animControlBoxWhenDragOutside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomBoxWhenDragOutside =
        Tween(begin: 40.0, end: 50.0).animate(animControlBoxWhenDragOutside);
    zoomBoxWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragInside() {
    animControlIconWhenDragInside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragInside =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDragInside);
    zoomIconWhenDragInside.addListener(() {
      setState(() {});
    });
    animControlIconWhenDragInside.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isJustDragInside = false;
      }
    });
  }

  initAnimationIconWhenRelease() {
    animControlIconWhenRelease = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenRelease));

    zoomIconWhenRelease = Tween(begin: 1.8, end: 0.0).animate(CurvedAnimation(
        parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveUpIconWhenRelease = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveLeftIconLikeWhenRelease = Tween(begin: 20.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconLoveWhenRelease = Tween(begin: 68.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconHahaWhenRelease = Tween(begin: 116.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconWowWhenRelease = Tween(begin: 164.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconSadWhenRelease = Tween(begin: 212.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconAngryWhenRelease = Tween(begin: 260.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));

    zoomIconWhenRelease.addListener(() {
      setState(() {});
    });
    moveUpIconWhenRelease.addListener(() {
      setState(() {});
    });

    moveLeftIconLikeWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconLoveWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconHahaWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconWowWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconSadWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconAngryWhenRelease.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    animControlBtnLongPress.dispose();
    animControlBox.dispose();
    animControlIconWhenDrag.dispose();
    animControlIconWhenDragInside.dispose();
    animControlIconWhenDragOutside.dispose();
    animControlBoxWhenDragOutside.dispose();
    animControlIconWhenRelease.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatePostScreen()));
              },
              child: Container(
                margin: EdgeInsets.only(left: 5, top: 95),
                width: MediaQuery.of(context).size.width,
                height: 75,
                color: Colors.white,
                child: Row(
                  children: [
                    Card(
                      color: Colors.grey.shade100,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset("assets/images/onlypen.png"),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.only(left: 5, right: 10),
                        color: Colors.grey.shade100,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Text("Write something about post.."),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            storylist != null
                ? Container(
                    padding: EdgeInsets.only(top: 10, bottom: 30),
                    color: Colors.grey.shade100,
                    height: Get.height,
                    width: Get.width,
                    child: ListView.builder(
                        itemCount: storylist.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 30),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  height: 50,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 5,
                                          ),
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: storylist[index]
                                                          .user
                                                          .profile !=
                                                      null
                                                  ? Image.network(
                                                      storylist[index]
                                                          .user
                                                          .profile,
                                                      fit: BoxFit.fill,
                                                      height: 40,
                                                      width: 40,
                                                    )
                                                  : Image.asset(
                                                      "assets/images/WritingTool.png",
                                                      fit: BoxFit.fill,
                                                      height: 40,
                                                      width: 40,
                                                    )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          storylist[index].user.name.length < 15
                                              ? Text(storylist[index].user.name)
                                              : Text(storylist[index]
                                                  .user
                                                  .name
                                                  .substring(0, 15)),
                                        ],
                                      ),

                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(getDateforTimestamp(
                                            storylist[index].postTime)),
                                        // child: Text(timeago.format(now.subtract(now.difference(DateTime.fromMillisecondsSinceEpoch(storylist[index].postTime*1000))), locale: locale)),
                                        // child: Text(storylist[index].time.substring(0, 16)),
                                      ),

                                      // Row(
                                      //   children: <Widget>[
                                      //
                                      //     Text("First Name"),
                                      //     SizedBox(width: 5,),
                                      //     ClipRRect(
                                      //         borderRadius: BorderRadius.circular(100),
                                      //         child: Image.asset("assets/images/chetan.jpg",fit: BoxFit.fill,height: 40,width: 40,)),
                                      //     SizedBox(width: 5,),
                                      //
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                storylist[index].contentType == 0
                                    ? ImageView(storylist[index].images)
                                    // Container(
                                    //   width: MediaQuery.of(context).size.width,
                                    //   height: 200,
                                    //   decoration: BoxDecoration(color: Colors.grey),
                                    //   child: storylist[index].user.profile != null
                                    //       ? Image.network(
                                    //           storylist[index].user.profile,
                                    //           fit: BoxFit.cover,
                                    //         )
                                    //       : Image.asset(
                                    //           "assets/images/fulllogo.png",
                                    //           fit: BoxFit.fill,
                                    //         ),
                                    // )
                                    : Container(),
                                storylist[index].contentType == 1
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        color: Colors.white,
                                        child: HtmlWidget(
                                          storylist[index].description,
                                         // webView: true,
                                        ))
                                    : Container(),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  //height: 340,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      storylist[index].contentType == 0
                                          ? Text(
                                              storylist[index].description,
                                              style: TextStyle(fontSize: 15),
                                            )
                                          : Container(),

                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 1,
                                        width: 200,
                                        color: darkgreycolor,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                          child: Stack(
                                        children: [
                                          //renderBox(),
                                          renderIcons(),
                                        ],
                                      )),
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          // Row(
                                          //   children: <Widget>[
                                          //     Icon(
                                          //       Icons.thumb_up,
                                          //       color: orangecolor,
                                          //       size: 20,
                                          //     ),
                                          //     SizedBox(
                                          //       width: 2,
                                          //     ),
                                          //     Text(storylist[index]
                                          //             .likes
                                          //             .toString() +
                                          //         " Likes"),
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //   ],
                                          // ),
                                          GestureDetector(
                                            onHorizontalDragEnd:
                                                onHorizontalDragEndBoxIcon,
                                            onHorizontalDragUpdate:
                                                onHorizontalDragUpdateBoxIcon,
                                            child: Container(
                                              // width: 500,
                                              // height: 350.0,
                                              child: Stack(
                                                children: <Widget>[
                                                  // Box and icons
                                                  // Stack(
                                                  //   children: <Widget>[
                                                  //     // Box
                                                  //     //renderBox(),
                                                  //
                                                  //     // Icons
                                                  //     renderIcons(),
                                                  //   ],
                                                  //   alignment: Alignment.bottomCenter,
                                                  // ),

                                                  // Button like
                                                  renderBtnLike(),
                                                  //renderIcons(),

                                                  // Icons when jump
                                                  // Icon like
                                                  whichIconUserChoose == 1 &&
                                                          !isDragging
                                                      ? Container(
                                                          child:
                                                              Transform.scale(
                                                            child: Image.asset(
                                                              'assets/images/like.gif',
                                                              width: 40.0,
                                                              height: 40.0,
                                                            ),
                                                            scale: this
                                                                .zoomIconWhenRelease
                                                                .value,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: processTopPosition(this
                                                                .moveUpIconWhenRelease
                                                                .value),
                                                            left: this
                                                                .moveLeftIconLikeWhenRelease
                                                                .value,
                                                          ),
                                                        )
                                                      : Container(),

                                                  // Icon love
                                                  whichIconUserChoose == 2 &&
                                                          !isDragging
                                                      ? Container(
                                                          child:
                                                              Transform.scale(
                                                            child: Image.asset(
                                                              'assets/images/love.gif',
                                                              width: 40.0,
                                                              height: 40.0,
                                                            ),
                                                            scale: this
                                                                .zoomIconWhenRelease
                                                                .value,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: processTopPosition(this
                                                                .moveUpIconWhenRelease
                                                                .value),
                                                            left: this
                                                                .moveLeftIconLoveWhenRelease
                                                                .value,
                                                          ),
                                                        )
                                                      : Container(),

                                                  // Icon haha
                                                  whichIconUserChoose == 3 &&
                                                          !isDragging
                                                      ? Container(
                                                          child:
                                                              Transform.scale(
                                                            child: Image.asset(
                                                              'assets/images/haha.gif',
                                                              width: 40.0,
                                                              height: 40.0,
                                                            ),
                                                            scale: this
                                                                .zoomIconWhenRelease
                                                                .value,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: processTopPosition(this
                                                                .moveUpIconWhenRelease
                                                                .value),
                                                            left: this
                                                                .moveLeftIconHahaWhenRelease
                                                                .value,
                                                          ),
                                                        )
                                                      : Container(),

                                                  // Icon Wow
                                                  whichIconUserChoose == 4 &&
                                                          !isDragging
                                                      ? Container(
                                                          child:
                                                              Transform.scale(
                                                            child: Image.asset(
                                                              'assets/images/wow.gif',
                                                              width: 40.0,
                                                              height: 40.0,
                                                            ),
                                                            scale: this
                                                                .zoomIconWhenRelease
                                                                .value,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: processTopPosition(this
                                                                .moveUpIconWhenRelease
                                                                .value),
                                                            left: this
                                                                .moveLeftIconWowWhenRelease
                                                                .value,
                                                          ),
                                                        )
                                                      : Container(),

                                                  // Icon sad
                                                  whichIconUserChoose == 5 &&
                                                          !isDragging
                                                      ? Container(
                                                          child:
                                                              Transform.scale(
                                                            child: Image.asset(
                                                              'assets/images/sad.gif',
                                                              width: 40.0,
                                                              height: 40.0,
                                                            ),
                                                            scale: this
                                                                .zoomIconWhenRelease
                                                                .value,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: processTopPosition(this
                                                                .moveUpIconWhenRelease
                                                                .value),
                                                            left: this
                                                                .moveLeftIconSadWhenRelease
                                                                .value,
                                                          ),
                                                        )
                                                      : Container(),

                                                  // Icon angry
                                                  whichIconUserChoose == 6 &&
                                                          !isDragging
                                                      ? Container(
                                                          child:
                                                              Transform.scale(
                                                            child: Image.asset(
                                                              'assets/images/angry.gif',
                                                              width: 40.0,
                                                              height: 40.0,
                                                            ),
                                                            scale: this
                                                                .zoomIconWhenRelease
                                                                .value,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: processTopPosition(this
                                                                .moveUpIconWhenRelease
                                                                .value),
                                                            left: this
                                                                .moveLeftIconAngryWhenRelease
                                                                .value,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              // Area of the content can drag
                                              // decoration:  BoxDecoration(border: Border.all(color: Colors.grey)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              commentBottomSheet(context,
                                                  storylist[index].comments);
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.comment,
                                                  color: orangecolor,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(storylist[index]
                                                        .comments
                                                        .length
                                                        .toString() +
                                                    " Comments"),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.share,
                                                color: orangecolor,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("Share"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      // Container(
                                      //   alignment: Alignment.center,
                                      //   decoration: BoxDecoration(
                                      //     border: Border(
                                      //       left: BorderSide(
                                      //         //                   <--- left side
                                      //         color: orangecolor,
                                      //         width: 2.0,
                                      //       ),
                                      //       right: BorderSide(
                                      //         //                   <--- left side
                                      //         color: orangecolor,
                                      //         width: 2.0,
                                      //       ),
                                      //       top: BorderSide(
                                      //         //                    <--- top side
                                      //         color: orangecolor,
                                      //         width: 2.0,
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   height: 20,
                                      //   width: 150,
                                      //   child: Text(
                                      //     "Sports and Fitness",
                                      //     style: TextStyle(color: orangecolor),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  ImageView(List<Images> imglist) {
    if (imglist != null && imglist.length != 0) {
      if (imglist.length == 1)
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowFullSizeImagesScreen(imglist)));
          },
          child: Container(
            color: bluecolorlight,
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Image.network(
              imglist[0].imgUrl,
              fit: BoxFit.fill,
            ),
          ),
        );
      else if (imglist.length == 2)
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowFullSizeImagesScreen(imglist)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: bluecolorlight,
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    imglist[0].imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  flex: 1,
                  child: Image.network(
                    imglist[0].imgUrl,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
        );
      else if (imglist.length == 3)
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowFullSizeImagesScreen(imglist)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    imglist[0].imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          imglist[1].imgUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          imglist[2].imgUrl,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      else if (imglist.length == 4)
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowFullSizeImagesScreen(imglist)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          imglist[0].imgUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Expanded(
                        flex: 2,
                        child: Image.network(
                          imglist[2].imgUrl,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          imglist[1].imgUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          imglist[3].imgUrl,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      else if (imglist.length > 4)
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        imglist[0].imgUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Image.network(
                        imglist[2].imgUrl,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        imglist[1].imgUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        imglist[3].imgUrl,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
    } else
      return Container();
  }

  commentBottomSheet(context, List<StoryfeedComments> comments) {
    commentcontroller =
        _scafoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return Container(
        margin: EdgeInsets.only(top: 120),
        // height: MediaQuery.of(context).size.height - 80,
        decoration: BoxDecoration(
          color: bluecolor,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0)),
        ),
//            boxShadow: [
//
//          BoxShadow(blurRadius: 15, color: Colors.grey[300], spreadRadius: 5),
//        ],
        // borderRadius: BorderRadius.circular(25), color: bluelightclr),
        //
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Comments",
                style: TextStyle(
                    color: whitecolor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: whitecolor,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(30.0),
                        topRight: const Radius.circular(30.0))),
                margin: EdgeInsets.only(top: 10),
                child: comments.length > 0
                    ? ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: orangecolor,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        comments[index].image,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      comments[index].user.name.length < 30
                                          ? Text(
                                              comments[index].user.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )
                                          : Text(
                                              comments[index]
                                                  .user
                                                  .name
                                                  .substring(0, 30),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                      //Text(comments[index].user.name),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(comments[index].user.msg),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        comments[index].user.time,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                    : Container(
                        child: Center(child: Text("No Comments")),
                      ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 10.0, left: 15.0, right: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: TextField(
                        // controller: loginEmailController,

                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          // errorText: lemailvalidiate ? 'Enter Valid Email' : null,
                          // border: InputBorder.none,

                          hintText: "Comments",
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: orangecolor,
                    child: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget renderBox() {
    return Opacity(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey[300], width: 0.3),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                // LTRB
                offset: Offset.lerp(Offset(0.0, 0.0), Offset(0.0, 0.5), 10.0)),
          ],
        ),
        // width: 300.0,
        height: isDragging
            ? (previousIconFocus == 0 ? this.zoomBoxIcon.value : 30.0)
            : isDraggingOutside
                ? this.zoomBoxWhenDragOutside.value
                : 50.0,

        // margin: EdgeInsets.only(bottom: 130.0, left: 10.0),
      ),
      opacity: this.fadeInBox.value,
    );
  }

  Widget renderIcons() {
    return Container(
      child: Row(
        children: <Widget>[
          // icon like
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 1
                      ? Container(
                          child: Text(
                            'Like',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  Image.asset(
                    'assets/images/like.gif',
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              // margin: EdgeInsets.only(bottom: pushIconLikeUp.value),
              width: 30.0,
              height: currentIconFocus == 1 ? 70.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 1
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 1
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconLike.value,
          ),

          // icon love
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 2
                      ? Container(
                          child: Text(
                            'Love',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  Image.asset(
                    'assets/images/love.gif',
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              //  margin: EdgeInsets.only(bottom: pushIconLoveUp.value),
              width: 30.0,
              height: currentIconFocus == 2 ? 70.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 2
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 2
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconLove.value,
          ),

          // icon haha
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 3
                      ? Container(
                          child: Text(
                            'Haha',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  Image.asset(
                    'assets/images/haha.gif',
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              // margin: EdgeInsets.only(bottom: pushIconHahaUp.value),
              width: 30.0,
              height: currentIconFocus == 3 ? 70.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 3
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 3
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconHaha.value,
          ),

          // icon wow
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 4
                      ? Container(
                          child: Text(
                            'Wow',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  Image.asset(
                    'assets/images/wow.gif',
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              //margin: EdgeInsets.only(bottom: pushIconWowUp.value),
              width: 30.0,
              height: currentIconFocus == 4 ? 70.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 4
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 4
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconWow.value,
          ),

          // icon sad
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 5
                      ? Container(
                          child: Text(
                            'Sad',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  Image.asset(
                    'assets/images/sad.gif',
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              // margin: EdgeInsets.only(bottom: pushIconSadUp.value),
              width: 30.0,
              height: currentIconFocus == 5 ? 70.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 5
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 5
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconSad.value,
          ),

          // icon angry
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 6
                      ? Container(
                          child: Text(
                            'Angry',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  Image.asset(
                    'assets/images/angry.gif',
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              // margin: EdgeInsets.only(bottom: pushIconAngryUp.value),
              width: 30.0,
              height: currentIconFocus == 6 ? 70.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 6
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 6
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconAngry.value,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      //width: 200.0,
      height: 30.0,
      margin: EdgeInsets.only(left: this.moveRightGroupIcon.value, top: 0.0),
      // uncomment here to see area of draggable
      // color: Colors.amber.withOpacity(0.5),
    );
  }

  Widget renderBtnLike() {
    return Container(
      child: GestureDetector(
        onTapDown: onTapDownBtn,
        onTapUp: onTapUpBtn,
        onTap: onTapBtn,
        child: Container(
          child: Row(
            children: <Widget>[
              // Icon like
              Transform.scale(
                child: Transform.rotate(
                  child: Image.asset(
                    getImageIconBtn(),
                    width: 20.0,
                    height: 20.0,
                    fit: BoxFit.contain,
                    color: getTintColorIconBtn(),
                  ),
                  angle: !isLongPress
                      ? handleOutputRangeTiltIconLike(tiltIconLikeInBtn2.value)
                      : tiltIconLikeInBtn.value,
                ),
                scale: !isLongPress
                    ? handleOutputRangeZoomInIconLike(zoomIconLikeInBtn2.value)
                    : zoomIconLikeInBtn.value,
              ),

              // Text like
              Transform.scale(
                child: Text(
                  getTextBtn(),
                  style: TextStyle(
                    color: getColorTextBtn(),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                scale: !isLongPress
                    ? handleOutputRangeZoomInIconLike(zoomIconLikeInBtn2.value)
                    : zoomTextLikeInBtn.value,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          padding: EdgeInsets.all(10.0),
          color: Colors.transparent,
        ),
      ),
      width: 75.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
        // border: Border.all(color: getColorBorderBtn()),
      ),
      // margin: EdgeInsets.only(top: 70.0),
    );
  }

  String getTextBtn() {
    if (isDragging) {
      return 'Like';
    }
    switch (whichIconUserChoose) {
      case 1:
        return 'Like';
      case 2:
        return 'Love';
      case 3:
        return 'Haha';
      case 4:
        return 'Wow';
      case 5:
        return 'Sad';
      case 6:
        return 'Angry';
      default:
        return 'Like';
    }
  }

  Color getColorTextBtn() {
    if ((!isLongPress && isLiked)) {
      return Color(0xff3b5998);
    } else if (!isDragging) {
      switch (whichIconUserChoose) {
        case 1:
          return Color(0xff3b5998);
        case 2:
          return Color(0xffED5167);
        case 3:
        case 4:
        case 5:
          return Color(0xffFFD96A);
        case 6:
          return Color(0xffF6876B);
        default:
          return Colors.grey;
      }
    } else {
      return Colors.grey;
    }
  }

  String getImageIconBtn() {
    if (!isLongPress && isLiked) {
      return 'assets/images/ic_like_fill.png';
    } else if (!isDragging) {
      switch (whichIconUserChoose) {
        case 1:
          return 'assets/images/ic_like_fill.png';
        case 2:
          return 'assets/images/love2.png';
        case 3:
          return 'assets/images/haha2.png';
        case 4:
          return 'assets/images/wow2.png';
        case 5:
          return 'assets/images/sad2.png';
        case 6:
          return 'assets/images/angry2.png';
        default:
          return 'assets/images/ic_like.png';
      }
    } else {
      return 'assets/images/ic_like.png';
    }
  }

  Color getTintColorIconBtn() {
    if (!isLongPress && isLiked) {
      return Color(0xff3b5998);
    } else if (!isDragging && whichIconUserChoose != 0) {
      return null;
    } else {
      return Colors.grey;
    }
  }

  double processTopPosition(double value) {
    // margin top 100 -> 40 -> 160 (value from 180 -> 0)
    if (value >= 120.0) {
      return value - 80.0;
    } else {
      return 160.0 - value;
    }
  }

  Color getColorBorderBtn() {
    if ((!isLongPress && isLiked)) {
      return Color(0xff3b5998);
    } else if (!isDragging) {
      switch (whichIconUserChoose) {
        case 1:
          return Color(0xff3b5998);
        case 2:
          return Color(0xffED5167);
        case 3:
        case 4:
        case 5:
          return Color(0xffFFD96A);
        case 6:
          return Color(0xffF6876B);
        default:
          return Colors.grey;
      }
    } else {
      return Colors.grey[400];
    }
  }

  void onHorizontalDragEndBoxIcon(DragEndDetails dragEndDetail) {
    isDragging = false;
    isDraggingOutside = false;
    isJustDragInside = true;
    previousIconFocus = 0;
    currentIconFocus = 0;

    onTapUpBtn(null);
  }

  void onHorizontalDragUpdateBoxIcon(DragUpdateDetails dragUpdateDetail) {
    // return if the drag is drag without press button
    if (!isLongPress) return;

    // the margin top the box is 150
    // and plus the height of toolbar and the status bar
    // so the range we check is about 200 -> 500

    if (dragUpdateDetail.globalPosition.dy >= 200 &&
        dragUpdateDetail.globalPosition.dy <= 500) {
      isDragging = true;
      isDraggingOutside = false;

      if (isJustDragInside && !animControlIconWhenDragInside.isAnimating) {
        animControlIconWhenDragInside.reset();
        animControlIconWhenDragInside.forward();
      }

      if (dragUpdateDetail.globalPosition.dx >= 20 &&
          dragUpdateDetail.globalPosition.dx < 83) {
        if (currentIconFocus != 1) {
          handleWhenDragBetweenIcon(1);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 83 &&
          dragUpdateDetail.globalPosition.dx < 126) {
        if (currentIconFocus != 2) {
          handleWhenDragBetweenIcon(2);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 126 &&
          dragUpdateDetail.globalPosition.dx < 180) {
        if (currentIconFocus != 3) {
          handleWhenDragBetweenIcon(3);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 180 &&
          dragUpdateDetail.globalPosition.dx < 233) {
        if (currentIconFocus != 4) {
          handleWhenDragBetweenIcon(4);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 233 &&
          dragUpdateDetail.globalPosition.dx < 286) {
        if (currentIconFocus != 5) {
          handleWhenDragBetweenIcon(5);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 286 &&
          dragUpdateDetail.globalPosition.dx < 340) {
        if (currentIconFocus != 6) {
          handleWhenDragBetweenIcon(6);
        }
      }
    } else {
      whichIconUserChoose = 0;
      previousIconFocus = 0;
      currentIconFocus = 0;
      isJustDragInside = true;

      if (isDragging && !isDraggingOutside) {
        isDragging = false;
        isDraggingOutside = true;
        animControlIconWhenDragOutside.reset();
        animControlIconWhenDragOutside.forward();
        animControlBoxWhenDragOutside.reset();
        animControlBoxWhenDragOutside.forward();
      }
    }
  }

  void handleWhenDragBetweenIcon(int currentIcon) {
    playSound('icon_focus.mp3');
    whichIconUserChoose = currentIcon;
    previousIconFocus = currentIconFocus;
    currentIconFocus = currentIcon;
    animControlIconWhenDrag.reset();
    animControlIconWhenDrag.forward();
  }

  void onTapDownBtn(TapDownDetails tapDownDetail) {
    holdTimer = Timer(durationLongPress, showBox);
  }

  void onTapUpBtn(TapUpDetails tapUpDetail) {
    if (isLongPress) {
      if (whichIconUserChoose == 0) {
        playSound('box_down.mp3');
      } else {
        playSound('icon_choose.mp3');
      }
    }

    Timer(Duration(milliseconds: durationAnimationBox), () {
      isLongPress = false;
    });

    holdTimer.cancel();

    animControlBtnLongPress.reverse();

    setReverseValue();
    animControlBox.reverse();

    animControlIconWhenRelease.reset();
    animControlIconWhenRelease.forward();
  }

  // when user short press the button
  void onTapBtn() {
    if (!isLongPress) {
      if (whichIconUserChoose == 0) {
        isLiked = !isLiked;
      } else {
        whichIconUserChoose = 0;
      }
      if (isLiked) {
        playSound('short_press_like.mp3');
        animControlBtnShortPress.forward();
      } else {
        animControlBtnShortPress.reverse();
      }
    }
  }

  double handleOutputRangeZoomInIconLike(double value) {
    if (value >= 0.8) {
      return value;
    } else if (value >= 0.4) {
      return 1.6 - value;
    } else {
      return 0.8 + value;
    }
  }

  double handleOutputRangeTiltIconLike(double value) {
    if (value <= 0.2) {
      return value;
    } else if (value <= 0.6) {
      return 0.4 - value;
    } else {
      return -(0.8 - value);
    }
  }

  void showBox() {
    playSound('box_up.mp3');
    isLongPress = true;

    animControlBtnLongPress.forward();

    setForwardValue();
    animControlBox.forward();
  }

  // We need to set the value for reverse because if not
  // the angry-icon will be pulled down first, not the like-icon
  void setReverseValue() {
    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
  }

  // When set the reverse value, we need set value to normal for the forward
  void setForwardValue() {
    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
  }

  Future playSound(String nameSound) async {
    // Sometimes multiple sound will play the same time, so we'll stop all before play the
    await audioPlayer.stop();
    final file = File('${(await getTemporaryDirectory()).path}/$nameSound');
    await file.writeAsBytes((await loadAsset(nameSound)).buffer.asUint8List());
    await audioPlayer.play(file.path, isLocal: true);
  }

  Future loadAsset(String nameSound) async {
    return await rootBundle.load('sounds/$nameSound');
  }
}
