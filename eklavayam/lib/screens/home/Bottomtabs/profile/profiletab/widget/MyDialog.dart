import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDialog extends StatefulWidget {
  String dialog_name;
  String img;
  String title;
  String murl;
  String des;
  bool me;

  MyDialog(
      this.dialog_name, this.me, this.img, this.title, this.murl, this.des);

  @override
  State<StatefulWidget> createState() => MyDialogState();
}

class MyDialogState extends State<MyDialog>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController titleController, murlController, desController;
  File _coverImgae;
  final picker = ImagePicker();
  String eimage;
  String title = "", murl = "", des = "";

  bool errormsg = false;
  AnimationController controller;
  Animation<double> scaleAnimation;

  bool canedit = false;

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

  Future<void> createBookCall() async {
    // 9812010471

    var jsonstring = {
      "userId": uniqueId,
      "type": 0,
      "title": titleController.text,
      "description": desController.text,
      "images": eimage,
      "link": murlController.text
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata =
        await networkClient.postData(addbook_award_achiUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      //_controller.close();
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  Future<void> updateCall() async {
    // 9812010471
    int type = 0;
    if (widget.dialog_name == "Book") type = 0;
    if (widget.dialog_name == "Achievement") type = 1;
    if (widget.dialog_name == "Awards") type = 2;

    var jsonstring = {
      "uniqueId": uniqueId,
      "type": type,
      "title": title,
      "description": des,
      "images": eimage,
      "link": murl
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata =
        await networkClient.postData(update_book_award_achiUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _coverImgae = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    setState(() {
      if (pickedFile != null) {
        _coverImgae = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadimageCall() async {
    print("uploadimage");
    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.uploadImage(_coverImgae);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      eimage = responsedata['imageUrl'];
      updateCall();
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  @override
  void initState() {
    super.initState();
    restoreSF();
    titleController = TextEditingController();
    murlController = TextEditingController();
    desController = TextEditingController();

    eimage = widget.img;
    titleController.text = widget.title;
    title = widget.title;
    murlController.text = widget.murl;
    murl = widget.murl;
    desController.text = widget.des;
    des = widget.des;

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width - 30,
            height: MediaQuery.of(context).size.height - 40,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Text(
                          widget.dialog_name + " Detail",
                          style: TextStyle(
                              color: bluecolor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      widget.me
                          ? Container(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      canedit = !canedit;
                                    });
                                  },
                                  child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: canedit
                                              ? Colors.grey
                                              : orangecolor,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 25,
                                      ))),
                            )
                          : Container(),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Upload ' + widget.dialog_name,
                        style: TextStyle(color: bluecolor, fontSize: 18),
                      ),
                    ),
                  ),
                  _coverImgae == null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Stack(
                            children: [
                              DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(10),
                                  strokeCap: StrokeCap.round,
                                  dashPattern: [6, 3],
                                  color: darkgreycolor,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    width: MediaQuery.of(context).size.width,
                                    height: 180,
                                    child: Image.network(widget.img),
                                    // child: Center(
                                    //   child: DottedBorder(
                                    //       padding: EdgeInsets.all(20),
                                    //       borderType: BorderType.Circle,
                                    //       dashPattern: [6, 3],
                                    //       color: darkgreycolor,
                                    //       child: GestureDetector(
                                    //         child: Image.network(
                                    //             widget.img),
                                    //         onTap: () => getImage(),
                                    //       )),
                                    // ),
                                  )),
                              canedit
                                  ? Positioned(
                                      right: 2,
                                      bottom: 2,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.white.withOpacity(.6),
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: bluecolor,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                getImage();
                                              });
                                            }),
                                      ))
                                  : Container(),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _coverImgae,
                                      width: MediaQuery.of(context).size.width,
                                      height: 180,
                                      // width: 150,
                                      // height: 90,
                                      fit: BoxFit.fill,
                                    )),
                                canedit
                                    ? Positioned(
                                        right: 2,
                                        bottom: 2,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Colors.white.withOpacity(.6),
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: bluecolor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _coverImgae = null;
                                                });
                                              }),
                                        ))
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    "Title",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: bluecolor, fontSize: 18),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[500]))),
                      child: TextField(
                        enabled: canedit,
                        controller: titleController,
                        // obscureText: passobsucure,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Title",
                        ),
                        onChanged: (value) {
                          title = value;
                          // eNameController.clear();
                          // eNameController.text=value;
                          // this.phoneNo=value;
                          // password = value;
                          print(value);
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    "MarketPlace URL",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: bluecolor, fontSize: 18),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[500]))),
                      child: TextField(
                        enabled: canedit,
                        controller: murlController,
                        // obscureText: passobsucure,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter MarketPlace URL",
                        ),
                        onChanged: (value) {
                          murl = value;
                          // eNameController.clear();
                          // eNameController.text=value;
                          // this.phoneNo=value;
                          // password = value;
                          print(value);
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    "Description",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: bluecolor, fontSize: 18),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[500]))),
                      child: TextField(
                        enabled: canedit,
                        controller: desController,
                        // obscureText: passobsucure,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Description",
                        ),
                        onChanged: (value) {
                          des = value;
                          // eNameController.clear();
                          // eNameController.text=value;
                          // this.phoneNo=value;
                          // password = value;
                          print(value);
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),

                  // errormsg?Container(height: 25,width: MediaQuery.of(context).size.width,alignment:Alignment.center,color: Colors.red,
                  //   child: Text("Please Enter all value",style: TextStyle(color: Colors.white),),):Container(),
                  //
                  canedit
                      ? Container(
                          height: 50,
                          color: orangecolor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (title != null &&
                                      murl != null &&
                                      des != null) {
                                    if (_coverImgae == null) {
                                      updateCall();
                                    } else {
                                      uploadimageCall();
                                    }
                                  } else {
                                    //showsnakbaratBottom();
                                    showSnakbarWithGlobalKey(
                                        _scaffoldKey, "Please Enter All Value");
                                  }

                                  //_controller.close();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20.0, top: 10),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 2,
                                color: Colors.white,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20.0, top: 10),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: orangecolor,
                            height: 50,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20.0, top: 10),
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
