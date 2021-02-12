import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/home/Bottomtabs/model/AboutModel.dart';
import 'package:eklavayam/screens/home/Bottomtabs/profile/profiletab/widget/MyDialog.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookPublishedScreen extends StatefulWidget {
  List<BookData> bookData;
  bool me;
  BookPublishedScreen(this.bookData,this.me);

  @override
  _BookPublishedScreenState createState() => _BookPublishedScreenState();
}

class _BookPublishedScreenState extends State<BookPublishedScreen>
   {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _controller;

  TextEditingController titleController, murlController, desController;
  File _coverImgae;
  final picker = ImagePicker();
  String eimage;

  bool errormsg = false;
  AnimationController controller;
  Animation<double> scaleAnimation;


  String name,image,mobile,token;
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
      _controller.close();
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  // Future<void> updateBookCall() async {
  //   // 9812010471
  //
  //   var jsonstring = {
  //     "userId":uniqueId,
  //     "type":2,
  //     "title":"Title Achievment",
  //     "description":"Achievement description",
  //     "images":"https://picsum.photos/200/300?random=1",
  //     "link":"https://picsum.photos/200/300?random=1"
  //   };
  //   var jsondata = jsonEncode(jsonstring);
  //   print(jsondata);
  //
  //   showAlertDialog(context);
  //   NetworkClient networkClient = new NetworkClient();
  //   var responsedata = await networkClient.postData(update_book_award_achiUrl, jsondata);
  //
  //   print(responsedata);
  //   Navigator.pop(context);
  //   if (responsedata['status'] == 1) {
  //
  //   } else
  //     showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  // }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _coverImgae = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    _controller.setState(() {
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
      createBookCall();
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
restoreSF();
    titleController = TextEditingController();
    murlController = TextEditingController();
    desController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.me? FloatingActionButton(
          child: new Icon(Icons.add),
          backgroundColor: orangecolor,
          onPressed: () {
            _ModalBottomSheet(context);
          }):null,
      body: Container(
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.only(top: 70.0),
            //   child: Text(
            //     "Choose Language",
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 30,
            //         color: whitecolor),
            //   ),
            // ),
            Expanded(
              child: widget.bookData != null
                  ? Container(
                      padding: EdgeInsets.all(10.0),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .9, crossAxisCount: 2),
                        shrinkWrap: true,
                        itemCount: widget.bookData.length,
                        itemBuilder: (context, index) => GestureDetector(
                          child: Card(
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // _showandUpdateSheet(context,widget.bookData[index].images,widget.bookData[index].title,widget.bookData[index].link,
                                    // widget.bookData[index].description);
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) => MyDialog(
                                          "Book",
                                            widget.me,
                                            widget.bookData[index].images,
                                            widget.bookData[index].title,
                                            widget.bookData[index].link,
                                            widget
                                                .bookData[index].description));
                                  },
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 200,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                widget.bookData[index].images,
                                                fit: BoxFit.fill,
                                              )),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Text(
                                            widget.bookData[index].title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Text(
                                            widget.bookData[index].description,
                                          ),
                                        ),

                                        // Padding(
                                        //   padding: const EdgeInsets.only(left:5,right: 5),
                                        //   child: Text(widget.bookData[index].link,style: TextStyle(color: bluecolor),),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Image.asset(
                                        'assets/images/ic_like_fill.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  showsnakbaratBottom() {
    _controller.setState(() {
      errormsg = true;
    });
    Timer(Duration(seconds: 2), () {
      _controller.setState(() {
        errormsg = false;
      });
    });
  }

  void _ModalBottomSheet(context) {
    String title = "", murl = "", des = "";

    _controller =
        //_scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {

        showBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height - 200,
                decoration: BoxDecoration(
                  color: bluecolor,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(30.0),
                      topRight: const Radius.circular(30.0)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(
                        "Add Books",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0))),
                        margin: EdgeInsets.only(top: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Upload Achievment',
                                    style: TextStyle(
                                        color: bluecolor, fontSize: 18),
                                  ),
                                ),
                              ),
                              _coverImgae == null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(10),
                                          strokeCap: StrokeCap.round,
                                          dashPattern: [6, 3],
                                          color: darkgreycolor,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100,
                                            child: Center(
                                              child: DottedBorder(
                                                  padding: EdgeInsets.all(20),
                                                  borderType: BorderType.Circle,
                                                  dashPattern: [6, 3],
                                                  color: darkgreycolor,
                                                  child: GestureDetector(
                                                    child: Image.asset(
                                                        'assets/images/Camera.png'),
                                                    onTap: () => getImage(),
                                                  )),
                                            ),
                                          )),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  _coverImgae,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 100,
                                                  // width: 150,
                                                  // height: 90,
                                                  fit: BoxFit.fill,
                                                )),
                                            Positioned(
                                                right: 2,
                                                bottom: 2,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white
                                                      .withOpacity(.6),
                                                  child: IconButton(
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: bluecolor,
                                                      ),
                                                      onPressed: () {
                                                        _controller
                                                            .setState(() {
                                                          _coverImgae = null;
                                                        });
                                                      }),
                                                )),
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
                                style:
                                    TextStyle(color: bluecolor, fontSize: 18),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[500]))),
                                  child: TextField(
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
                                style:
                                    TextStyle(color: bluecolor, fontSize: 18),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[500]))),
                                  child: TextField(
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
                                style:
                                    TextStyle(color: bluecolor, fontSize: 18),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[500]))),
                                  child: TextField(
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    errormsg
                        ? Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            color: Colors.red,
                            child: Text(
                              "Please Enter all value",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_coverImgae != null &&
                                title != null &&
                                murl != null &&
                                des != null) {
                              uploadimageCall();
                            } else {
                              showsnakbaratBottom();
                              // showSnakbarWithGlobalKey(_scaffoldKey, "Please Enter All Value");
                            }

                            //_controller.close();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20.0, top: 10),
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
                            _controller.close();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20.0, top: 10),
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
                    )
                  ],
                ),
              );
            });
  }

  // void _showandUpdateSheet(
  //     context, String img, String title, String murl, String des) {
  //   String title = "", murl = "", des = "";
  //   titleController.text = title;
  //   murlController.text = murl;
  //   desController.text = des;
  //   _showEditController = showBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: MediaQuery.of(context).size.height - 200,
  //           decoration: BoxDecoration(
  //             color: bluecolor,
  //             borderRadius: new BorderRadius.only(
  //                 topLeft: const Radius.circular(30.0),
  //                 topRight: const Radius.circular(30.0)),
  //           ),
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 0.0),
  //                 child: Text(
  //                   "Add Books",
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Container(
  //                   padding: EdgeInsets.all(20),
  //                   decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: new BorderRadius.only(
  //                           topLeft: const Radius.circular(20.0),
  //                           topRight: const Radius.circular(20.0))),
  //                   margin: EdgeInsets.only(top: 10),
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         // SizedBox(
  //                         //   height: 10,
  //                         // ),
  //                         Container(
  //                           margin: EdgeInsets.symmetric(horizontal: 20),
  //                           child: Align(
  //                             alignment: Alignment.topLeft,
  //                             child: Text(
  //                               'Upload Achievment',
  //                               style:
  //                                   TextStyle(color: bluecolor, fontSize: 18),
  //                             ),
  //                           ),
  //                         ),
  //                         _coverImgae == null
  //                             ? Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 20, vertical: 10),
  //                                 child: DottedBorder(
  //                                     borderType: BorderType.RRect,
  //                                     radius: Radius.circular(10),
  //                                     strokeCap: StrokeCap.round,
  //                                     dashPattern: [6, 3],
  //                                     color: darkgreycolor,
  //                                     child: Container(
  //                                       margin: EdgeInsets.symmetric(
  //                                           horizontal: 15),
  //                                       width:
  //                                           MediaQuery.of(context).size.width,
  //                                       height: 100,
  //                                       child: Center(
  //                                         child: DottedBorder(
  //                                             padding: EdgeInsets.all(20),
  //                                             borderType: BorderType.Circle,
  //                                             dashPattern: [6, 3],
  //                                             color: darkgreycolor,
  //                                             child: GestureDetector(
  //                                               child: Image.asset(
  //                                                   'assets/images/Camera.png'),
  //                                               onTap: () => getImage(),
  //                                             )),
  //                                       ),
  //                                     )),
  //                               )
  //                             : Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 30, vertical: 10),
  //                                 child: Container(
  //                                   alignment: Alignment.topLeft,
  //                                   child: Stack(
  //                                     children: [
  //                                       ClipRRect(
  //                                           borderRadius:
  //                                               BorderRadius.circular(10),
  //                                           child: Image.file(
  //                                             _coverImgae,
  //                                             width: MediaQuery.of(context)
  //                                                 .size
  //                                                 .width,
  //                                             height: 100,
  //                                             // width: 150,
  //                                             // height: 90,
  //                                             fit: BoxFit.fill,
  //                                           )),
  //                                       Positioned(
  //                                           right: 2,
  //                                           bottom: 2,
  //                                           child: CircleAvatar(
  //                                             backgroundColor:
  //                                                 Colors.white.withOpacity(.6),
  //                                             child: IconButton(
  //                                                 icon: Icon(
  //                                                   Icons.delete,
  //                                                   color: bluecolor,
  //                                                 ),
  //                                                 onPressed: () {
  //                                                   _controller.setState(() {
  //                                                     _coverImgae = null;
  //                                                   });
  //                                                 }),
  //                                           )),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //
  //                         Text(
  //                           "Title",
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(color: bluecolor, fontSize: 18),
  //                         ),
  //                         SizedBox(
  //                           height: 2,
  //                         ),
  //                         Container(
  //                             decoration: BoxDecoration(
  //                                 border: Border(
  //                                     bottom:
  //                                         BorderSide(color: Colors.grey[500]))),
  //                             child: TextField(
  //                               controller: titleController,
  //                               // obscureText: passobsucure,
  //                               decoration: InputDecoration(
  //                                 border: InputBorder.none,
  //                                 hintText: "Enter Title",
  //                               ),
  //                               onChanged: (value) {
  //                                 title = value;
  //                                 // eNameController.clear();
  //                                 // eNameController.text=value;
  //                                 // this.phoneNo=value;
  //                                 // password = value;
  //                                 print(value);
  //                               },
  //                             )),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //
  //                         Text(
  //                           "MarketPlace URL",
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(color: bluecolor, fontSize: 18),
  //                         ),
  //                         SizedBox(
  //                           height: 2,
  //                         ),
  //                         Container(
  //                             decoration: BoxDecoration(
  //                                 border: Border(
  //                                     bottom:
  //                                         BorderSide(color: Colors.grey[500]))),
  //                             child: TextField(
  //                               controller: murlController,
  //                               // obscureText: passobsucure,
  //                               decoration: InputDecoration(
  //                                 border: InputBorder.none,
  //                                 hintText: "Enter MarketPlace URL",
  //                               ),
  //                               onChanged: (value) {
  //                                 murl = value;
  //                                 // eNameController.clear();
  //                                 // eNameController.text=value;
  //                                 // this.phoneNo=value;
  //                                 // password = value;
  //                                 print(value);
  //                               },
  //                             )),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //
  //                         Text(
  //                           "Description",
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(color: bluecolor, fontSize: 18),
  //                         ),
  //                         SizedBox(
  //                           height: 2,
  //                         ),
  //                         Container(
  //                             decoration: BoxDecoration(
  //                                 border: Border(
  //                                     bottom:
  //                                         BorderSide(color: Colors.grey[500]))),
  //                             child: TextField(
  //                               controller: desController,
  //                               // obscureText: passobsucure,
  //                               decoration: InputDecoration(
  //                                 border: InputBorder.none,
  //                                 hintText: "Enter Description",
  //                               ),
  //                               onChanged: (value) {
  //                                 des = value;
  //                                 // eNameController.clear();
  //                                 // eNameController.text=value;
  //                                 // this.phoneNo=value;
  //                                 // password = value;
  //                                 print(value);
  //                               },
  //                             )),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               errormsg
  //                   ? Container(
  //                       height: 25,
  //                       width: MediaQuery.of(context).size.width,
  //                       alignment: Alignment.center,
  //                       color: Colors.red,
  //                       child: Text(
  //                         "Please Enter all value",
  //                         style: TextStyle(color: Colors.white),
  //                       ),
  //                     )
  //                   : Container(),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () {
  //                       if (_coverImgae != null &&
  //                           title != null &&
  //                           murl != null &&
  //                           des != null) {
  //                         uploadimageCall();
  //                       } else {
  //                         showsnakbaratBottom();
  //                         // showSnakbarWithGlobalKey(_scaffoldKey, "Please Enter All Value");
  //                       }
  //
  //                       //_controller.close();
  //                     },
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(bottom: 20.0, top: 10),
  //                       child: Text(
  //                         "Save",
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     height: 50,
  //                     width: 2,
  //                     color: Colors.white,
  //                   ),
  //                   GestureDetector(
  //                     onTap: () {
  //                       _controller.close();
  //                     },
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(bottom: 20.0, top: 10),
  //                       child: Text(
  //                         "Cancel",
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
  //
  // showUpdateDialog(String img, String title, String murl, String des) {
  //   // String title="",murl="",des="";
  //   titleController.text = title;
  //   murlController.text = murl;
  //   desController.text = des;
  //   bool canedit=false;
  //
  //   return LayoutBuilder(
  //       builder: (BuildContext context, BoxConstraints constraints) {
  //     return Center(
  //       child: Material(
  //         color: Colors.transparent,
  //         child: ScaleTransition(
  //           scale: scaleAnimation,
  //           child: Container(
  //             width: MediaQuery.of(context).size.width - 30,
  //             height: MediaQuery.of(context).size.height - 120,
  //             decoration: ShapeDecoration(
  //                 color: Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(15.0))),
  //             child: Column(
  //               children: [
  //
  //                 Container(
  //                   padding: EdgeInsets.all(20),
  //                   decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: new BorderRadius.only(
  //                           topLeft: const Radius.circular(20.0),
  //                           topRight: const Radius.circular(20.0))),
  //                   margin: EdgeInsets.only(top: 5),
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         // SizedBox(
  //                         //   height: 10,
  //                         // ),
  //                         Container(
  //                           alignment: Alignment.topRight,
  //                           child: GestureDetector(
  //                               onTap: (){
  //                                 setState(() {
  //                                   canedit=true;
  //                                 });
  //
  //                               },
  //                               child: Icon(Icons.edit,color: orangecolor,size: 30,)),),
  //                         Container(
  //                           margin: EdgeInsets.symmetric(horizontal: 0),
  //                           child: Align(
  //                             alignment: Alignment.topLeft,
  //                             child: Text(
  //                               ' Achievment',
  //                               style:
  //                                   TextStyle(color: bluecolor, fontSize: 18),
  //                             ),
  //                           ),
  //                         ),
  //                         _coverImgae == null
  //                             ? Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 20, vertical: 10),
  //                                 child: DottedBorder(
  //                                     borderType: BorderType.RRect,
  //                                     radius: Radius.circular(10),
  //                                     strokeCap: StrokeCap.round,
  //                                     dashPattern: [6, 3],
  //                                     color: darkgreycolor,
  //                                     child: Container(
  //                                       margin: EdgeInsets.symmetric(
  //                                           horizontal: 15),
  //                                       width:
  //                                           MediaQuery.of(context).size.width,
  //                                       height: 150,
  //                                       child: Center(
  //                                         child: DottedBorder(
  //                                             padding: EdgeInsets.all(20),
  //                                             borderType: BorderType.Circle,
  //                                             dashPattern: [6, 3],
  //                                             color: darkgreycolor,
  //                                             child: GestureDetector(
  //                                               child: Image.asset(
  //                                                   'assets/images/Camera.png',),
  //                                               onTap: () => getImage(),
  //                                             )),
  //                                       ),
  //                                     )),
  //                               )
  //                             : Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 30, vertical: 10),
  //                                 child: Container(
  //                                   alignment: Alignment.topLeft,
  //                                   child: Stack(
  //                                     children: [
  //                                       ClipRRect(
  //                                           borderRadius:
  //                                               BorderRadius.circular(10),
  //                                           child: Image.file(
  //                                             _coverImgae,
  //                                             width: MediaQuery.of(context)
  //                                                 .size
  //                                                 .width,
  //                                             height: 150,
  //                                             // width: 150,
  //                                             // height: 90,
  //                                             fit: BoxFit.cover,
  //                                           )),
  //                                      canedit? Positioned(
  //                                           right: 2,
  //                                           bottom: 2,
  //                                           child: CircleAvatar(
  //                                             backgroundColor:
  //                                                 Colors.white.withOpacity(.6),
  //                                             child: IconButton(
  //                                                 icon: Icon(
  //                                                   Icons.delete,
  //                                                   color: bluecolor,
  //                                                 ),
  //                                                 onPressed: () {
  //                                                   setState(() {
  //                                                     _coverImgae = null;
  //                                                   });
  //                                                 }),
  //                                           )):Container(),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //
  //                         Text(
  //                           "Title",
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(color: bluecolor, fontSize: 18),
  //                         ),
  //                         SizedBox(
  //                           height: 2,
  //                         ),
  //                         Container(
  //                             decoration: BoxDecoration(
  //                                 border: Border(
  //                                     bottom:
  //                                         BorderSide(color: Colors.grey[500]))),
  //                             child: TextField(
  //                               enabled: canedit,
  //                               controller: titleController,
  //                               // obscureText: passobsucure,
  //                               decoration: InputDecoration(
  //                                 border: InputBorder.none,
  //                                 hintText: "Enter Title",
  //                               ),
  //                               onChanged: (value) {
  //                                 title = value;
  //                                 // eNameController.clear();
  //                                 // eNameController.text=value;
  //                                 // this.phoneNo=value;
  //                                 // password = value;
  //                                 print(value);
  //                               },
  //                             )),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //
  //                         Text(
  //                           "MarketPlace URL",
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(color: bluecolor, fontSize: 18),
  //                         ),
  //                         SizedBox(
  //                           height: 2,
  //                         ),
  //                         Container(
  //                             decoration: BoxDecoration(
  //                                 border: Border(
  //                                     bottom:
  //                                         BorderSide(color: Colors.grey[500]))),
  //                             child: TextField(
  //                               enabled: canedit,
  //                               controller: murlController,
  //                               // obscureText: passobsucure,
  //                               decoration: InputDecoration(
  //                                 border: InputBorder.none,
  //                                 hintText: "Enter MarketPlace URL",
  //                               ),
  //                               onChanged: (value) {
  //                                 murl = value;
  //                                 // eNameController.clear();
  //                                 // eNameController.text=value;
  //                                 // this.phoneNo=value;
  //                                 // password = value;
  //                                 print(value);
  //                               },
  //                             )),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //
  //                         Text(
  //                           "Description",
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(color: bluecolor, fontSize: 18),
  //                         ),
  //                         SizedBox(
  //                           height: 2,
  //                         ),
  //                         Container(
  //                             decoration: BoxDecoration(
  //                                 border: Border(
  //                                     bottom:
  //                                         BorderSide(color: Colors.grey[500]))),
  //                             child: TextField(
  //                               enabled: canedit,
  //                               controller: desController,
  //                               // obscureText: passobsucure,
  //                               decoration: InputDecoration(
  //                                 border: InputBorder.none,
  //                                 hintText: "Enter Description",
  //                               ),
  //                               onChanged: (value) {
  //                                 des = value;
  //                                 // eNameController.clear();
  //                                 // eNameController.text=value;
  //                                 // this.phoneNo=value;
  //                                 // password = value;
  //                                 print(value);
  //                               },
  //                             )),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //                         Container(
  //                           height: 50,
  //                           //color: orangecolor,
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                             children: [
  //                               canedit?GestureDetector(
  //                                 onTap: () {
  //                                   if (_coverImgae != null &&
  //                                       title != null &&
  //                                       murl != null &&
  //                                       des != null) {
  //                                     uploadimageCall();
  //                                   } else {
  //                                    // showsnakbaratBottom();
  //                                     // showSnakbarWithGlobalKey(_scaffoldKey, "Please Enter All Value");
  //                                   }
  //
  //                                   //_controller.close();
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       bottom: 20.0, top: 10),
  //                                   child: Text(
  //                                     "Save",
  //                                     style: TextStyle(
  //                                         color: Colors.white,
  //                                         fontSize: 20,
  //                                         fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ),
  //                               ):Container(),
  //                               Container(
  //                                 height: 50,
  //                                 width: 2,
  //                                 color: Colors.white,
  //                               ),
  //                               GestureDetector(
  //                                 onTap: () {
  //                                   // _controller.close();
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       bottom: 20.0, top: 10),
  //                                   child: Text(
  //                                     "Cancel",
  //                                     style: TextStyle(
  //                                         color: Colors.white,
  //                                         fontSize: 20,
  //                                         fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 // errormsg?Container(height: 25,width: MediaQuery.of(context).size.width,alignment:Alignment.center,color: Colors.red,
  //                 //   child: Text("Please Enter all value",style: TextStyle(color: Colors.white),),):Container(),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }
}

