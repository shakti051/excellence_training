import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/StaticString.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_share/social_share.dart';

import '../CreatePostScreen.dart';
import '../ShowFullSizeImagesScreen.dart';
import 'model/LikesModel.dart';
import 'model/StoryfeedModel.dart';
import 'profile/LikeDialog.dart';

class OneStoryFeedScreen extends StatefulWidget {
  int contentid;
  OneStoryFeedScreen(this.contentid);

  @override
  _OneStoryFeedScreenState createState() => _OneStoryFeedScreenState();
}

class _OneStoryFeedScreenState extends State<OneStoryFeedScreen> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  List<StoryfeedData> storylist;

  List<LikesData> likeslist;

  var locale = 'en';
  final now = new DateTime.now();

  String name, image, mobile, token;
  int uniqueId;

  bool likeview = false;
  bool shareview = false;
  String likeimg = "assets/images/ic_like.png";

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

  Future<void> getStoryList() async {
    showAlertDialog(context);

    var jsonstring = {
      "contentId":widget.contentid,
      "userId":uniqueId,
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(getNotificationDetailUrl, jsondata);

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

  Future<void> getLikesList(
      int contenttype, int contentid, int contentuserid) async {
    showAlertDialog(context);

    var jsonstring = {
      "contentType": contenttype, //0,
      "contentId": contentid, //163,
      "contentUserId": contentuserid, //290,
      "userId": uniqueId
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(getLikesUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      LikesModel likesModel = new LikesModel.fromJson(responsedata);

      likeslist = likesModel.data;

      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => LikeDialog("Likes", likeslist));
    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['msg']);
    //print(responsedata['status']);
  }

  Future<void> likePostApi(
      int liketype, int contentid, String contenttype) async {
    showAlertDialog(context);

    var jsonstring = {
      "contentId": contentid, //content unique id
      "uniqueId": uniqueId, //user id
      "contentType": contenttype,
      "likeType": liketype
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(likePostUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['msg']);
    //print(responsedata['status']);
  }

  Future<void> likeCommentApi(int contentid, String contenttype) async {
    showAlertDialog(context);

    var jsonstring = {
      "contentId": contentid, //46,
      "uniqueId": uniqueId, //160,
      "contentType": contenttype //"unLike"
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(likeCommentUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['msg']);
    //print(responsedata['status']);
  }

  Future<void> commentApi(int contentid, String commenttxt, commenttype) async {
    showAlertDialog(context);

    var jsonstring = {
      "userId": uniqueId,
      "contentId": contentid,
      "comment": commenttxt,
      "commentType": commenttype //1=comment,2=replay
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(commmentUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      // StoryfeedModel storyfeedModel = new StoryfeedModel.fromJson(responsedata);
      //
      // setState(() {
      //   storylist = storyfeedModel.data;
      // });
    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['msg']);
    //print(responsedata['status']);
  }

  @override
  void initState() {
    super.initState();
    restoreSF();
    Future.delayed(Duration.zero, () => getStoryList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bluecolor,
      ),
      key: _scafoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => CreatePostScreen()));
            //   },
            //   child: Container(
            //     margin: EdgeInsets.only(left: 5, top: 95),
            //     width: MediaQuery.of(context).size.width,
            //     height: 75,
            //     color: Colors.white,
            //     child: Row(
            //       children: [
            //         Card(
            //           color: Colors.grey.shade100,
            //           elevation: 5.0,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(100.0)),
            //           child: Container(
            //             padding: EdgeInsets.all(10),
            //             height: 55,
            //             width: 55,
            //             decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //             ),
            //             child: Image.asset("assets/images/onlypen.png"),
            //           ),
            //         ),
            //         Expanded(
            //           child: Card(
            //             margin: EdgeInsets.only(left: 5, right: 10),
            //             color: Colors.grey.shade100,
            //             elevation: 5.0,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(20.0)),
            //             child: Container(
            //               alignment: Alignment.center,
            //               height: 50,
            //               decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //               ),
            //               child: Text("Write something about post.."),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 20,),
            if (storylist != null)
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 190),
                color: Colors.grey.shade100,
               // height: Get.height - 190,
                width: Get.width,
                child: ListView.builder(
                    itemCount: storylist.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 30),
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
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
                                        child: Text(storylist[index].time.substring(0,15)),
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
                                    : Container(),
                                storylist[index].contentType == 1
                                    ? Container(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        color: Colors.white,
                                        child: HtmlWidget(
                                          storylist[index].description,
                                          webView: true,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  showLikeView(index);
                                                },
                                                child: Image.asset(
                                                  getEomojifromtype(
                                                      storylist[index]
                                                          .isLikedType),
                                                  //pass like type
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  getLikesList(
                                                      0,
                                                      storylist[index]
                                                          .contentUniqueId,
                                                      int.parse(
                                                          storylist[index].id));
                                                },
                                                child: Text(storylist[index]
                                                        .likes
                                                        .toString() +
                                                    " Like"),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              commentBottomSheet(
                                                  context,
                                                  storylist[index]
                                                      .contentUniqueId,
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
                                                  width: 3,
                                                ),
                                                Text(storylist[index]
                                                        .comments
                                                        .length
                                                        .toString() +
                                                    " Comments"),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showShareView(index);
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.share,
                                                  color: orangecolor,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text("Share"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          likeview//storylist[index].likeShow
                              ? Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 20, bottom: 60),
                                    height: 40,
                                    width: 240,
                                    color: Colors.white,
                                    child: Card(
                                      elevation: 5,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              likePostApi(
                                                  1,
                                                  storylist[index]
                                                      .contentUniqueId,
                                                  "like");
                                              setState(() {
                                                storylist[index].isLikedType =
                                                    1;
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/images/ic_like_fill.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              likePostApi(
                                                  2,
                                                  storylist[index]
                                                      .contentUniqueId,
                                                  "like");
                                              setState(() {
                                                storylist[index].isLikedType =
                                                    2;
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/images/love2.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              likePostApi(
                                                  3,
                                                  storylist[index]
                                                      .contentUniqueId,
                                                  "like");
                                              setState(() {
                                                storylist[index].isLikedType =
                                                    3;
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/images/happy.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              likePostApi(
                                                  4,
                                                  storylist[index]
                                                      .contentUniqueId,
                                                  "like");
                                              setState(() {
                                                storylist[index].isLikedType =
                                                    4;
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/images/haha2.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              likePostApi(
                                                  5,
                                                  storylist[index]
                                                      .contentUniqueId,
                                                  "like");
                                              setState(() {
                                                storylist[index].isLikedType =
                                                    5;
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/images/think.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              likePostApi(
                                                  6,
                                                  storylist[index]
                                                      .contentUniqueId,
                                                  "like");
                                              setState(() {
                                                storylist[index].isLikedType =
                                                    6;
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/images/sad2.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              likePostApi(
                                                  7,
                                                  storylist[index]
                                                      .contentUniqueId,
                                                  "like");
                                              setState(() {
                                                storylist[index].isLikedType =
                                                    7;
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/images/lovely.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          shareview//storylist[index].shareShow
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 20, bottom: 60),
                                    height: 40,
                                    width: 200,
                                    color: Colors.white,
                                    child: Card(
                                      elevation: 5,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              SocialShare.shareFacebookStory(
                                                      "image.path",
                                                      "#ffffff",
                                                      "#000000",
                                                      "https://Eklavayam deep-link-url",
                                                      appId: fb_app_id)
                                                  .then((data) {
                                                print(data);
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/images/fb.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              SocialShare.shareTwitter(
                                                      "Eklvayam ")
                                                  .then((data) {
                                                print(data);
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/images/twitter.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                              onTap: () async {
                                                SocialShare.shareSms(
                                                        "Eklvayam ")
                                                    .then((data) {
                                                  print(data);
                                                });
                                              },
                                              child: Icon(
                                                Icons.sms,
                                                color: bluecolor,
                                                size: 25,
                                              )),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              SocialShare.shareWhatsapp(
                                                      "Eklvayam " +
                                                          storylist[index]
                                                              .id
                                                              .toString())
                                                  .then((data) {
                                                print(data);
                                              });
                                            },
                                            child: Image.asset(
                                              "assets/images/whatsapp.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                              onTap: () async {
//without an image
                                                SocialShare.shareOptions(
                                                        "Eklvayam " +
                                                            storylist[index]
                                                                .id
                                                                .toString())
                                                    .then((data) {
                                                  print(data);
                                                });

//with an image
                                                //  SocialShare.shareOptions("Hello world",imagePath: image.path);
                                              },
                                              child: Icon(
                                                Icons.share,
                                                color: bluecolor,
                                                size: 25,
                                              )),
                                          SizedBox(
                                            width: 7,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      );
                    }),
              )
            else
              Container(),
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

  commentBottomSheet(context, int contentid, List<StoryfeedComments> comments) {
    String comment = "";
    String reply = "";

    commentcontroller =
        _scafoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return Container(
        // padding: EdgeInsets.only(top: 120),
        height: MediaQuery.of(context).size.height - 150,
        color: Colors.transparent,
        child: Container(
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
                          shrinkWrap: true,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: orangecolor,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
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
                                            comments[index].user.name.length <
                                                    30
                                                ? Text(
                                                    comments[index].user.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )
                                                : Text(
                                                    comments[index]
                                                        .user
                                                        .name
                                                        .substring(0, 30),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                            Row(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
                                                        showLikeView(index);
                                                      },
                                                      child: Image.asset(
                                                        likeimg,
                                                        height: 25,
                                                        width: 25,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // getLikesList(0,storylist[index].contentUniqueId,int.parse(storylist[index].id));
                                                      },
                                                      child: Text(
                                                          storylist[index]
                                                                  .likes
                                                                  .toString() +
                                                              " Like"),
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    commentcontroller
                                                        .setState(() {
                                                      comments[index]
                                                              .commentBox =
                                                          !comments[index]
                                                              .commentBox;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      // Icon(
                                                      //   Icons.comment,
                                                      //   color: orangecolor,
                                                      //   size: 20,
                                                      // ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        " Reply",
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  comments[index].user.time,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  comments[index].replyCommentData.length > 0
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: comments[index]
                                              .replyCommentData
                                              .length,
                                          itemBuilder: (context, ind) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  left: 40,
                                                  right: 10,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        orangecolor,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        child: Image.network(
                                                          comments[index]
                                                              .replyCommentData[
                                                                  ind]
                                                              .image,
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        comments[index]
                                                                    .replyCommentData[
                                                                        ind]
                                                                    .user
                                                                    .name
                                                                    .length <
                                                                30
                                                            ? Text(
                                                                comments[index]
                                                                    .replyCommentData[
                                                                        ind]
                                                                    .user
                                                                    .name,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16),
                                                              )
                                                            : Text(
                                                                comments[index]
                                                                    .replyCommentData[
                                                                        ind]
                                                                    .user
                                                                    .name
                                                                    .substring(
                                                                        0, 30),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16)),
                                                        //Text(comments[index].user.name),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(comments[index]
                                                            .replyCommentData[
                                                                ind]
                                                            .user
                                                            .msg),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          comments[index]
                                                              .replyCommentData[
                                                                  ind]
                                                              .user
                                                              .time,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })
                                      : Container(),
                                  comments[index].commentBox
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: 40,
                                              right: 10,
                                              top: 10,
                                              bottom: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  color: Colors.white,
                                                  child: TextField(
                                                    onChanged: (value) {
                                                      reply = value;
                                                    },
                                                    // controller: loginEmailController,
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      // errorText: lemailvalidiate ? 'Enter Valid Email' : null,
                                                      // border: InputBorder.none,
                                                      hintText: "Reply",
                                                      hintStyle: TextStyle(
                                                          fontFamily:
                                                              "WorkSansSemiBold",
                                                          fontSize: 17.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (reply.length > 0) {
                                                    commentApi(
                                                        comments[index]
                                                            .commentId,
                                                        reply,
                                                        "2");
                                                  }
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: orangecolor,
                                                  child: Icon(
                                                    Icons.send_rounded,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container()
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
                          onChanged: (value) {
                            comment = value;
                          },
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
                    GestureDetector(
                      onTap: () {
                        if (comment.length > 0) {
                          commentApi(contentid, comment, "1");
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: orangecolor,
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  String getEomojifromtype(var i) {
    if (i is int) {
      if (i == 1) {
        return "assets/images/ic_like_fill.png";
      } else if (i == 2) {
        return "assets/images/love2.png";
      } else if (i == 3) {
        return "assets/images/happy.png";
      } else if (i == 4) {
        return "assets/images/haha2.png";
      } else if (i == 5) {
        return "assets/images/think.png";
      } else if (i == 6) {
        return "assets/images/sad2.png";
      } else if (i == 7) {
        return "assets/images/lovely.png";
      } else {
        return "assets/images/ic_like.png";
      }
    } else
      return "assets/images/ic_like.png";
  }

  showLikeView(int i) {
    setState(() {
      storylist[i].likeShow = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      // 5s over, navigate to a new page
      setState(() {
        storylist[i].likeShow = false;
      }); //IntroScreen
    });
  }

  showShareView(int i) {
    setState(() {
      storylist[i].shareShow = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      // 5s over, navigate to a new page
      setState(() {
        storylist[i].shareShow = false;
      }); //IntroScreen
    });
  }
}
