import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/home/Bottomtabs/model/AboutModel.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart' as htmlwidget;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MediaGallaryScreen extends StatefulWidget {
  bool me;
  List<VideoData> videoData;
  MediaGallaryScreen(this.videoData,this.me);

  @override
  _MediaGallaryScreenState createState() => _MediaGallaryScreenState();
}

class _MediaGallaryScreenState extends State<MediaGallaryScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _controller;
  TextEditingController titleController,murlController,desController;

  File _coverImgae;
  final picker = ImagePicker();
  String eimage;

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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

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
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restoreSF();
    titleController=TextEditingController();
    murlController=TextEditingController();
    desController=TextEditingController();
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
              child: widget.videoData != null
                  ? Container(
                  padding: EdgeInsets.all(10.0),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .8, crossAxisCount: 2),
                    shrinkWrap: true,
                    itemCount: widget.videoData.length,
                    itemBuilder: (context, index) => GestureDetector(
                      child: Card(
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 140,
                                width: 200,
                                child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child:Container(
                                        color: Colors.white,
                                        child: htmlwidget.HtmlWidget(
                                          widget.videoData[index].html,
                                          webView: true,
                                        ))
                                    // child: Image.network(
                                    //   widget.videoData[index].images,
                                    //   fit: BoxFit.fill,
                                    // )
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left:5,right: 5),
                                child: Text(widget.videoData[index].title,maxLines: 3,style: TextStyle(fontWeight: FontWeight.bold),),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(left:5,right: 5),
                              //   child: widget.videoData[index].description!=null?Text(widget.videoData[index].description,):Container(),
                              // ),

                              // Padding(
                              //   padding: const EdgeInsets.only(left:5,right: 5),
                              //   child: Text(widget.videoData[index].link,style: TextStyle(color: bluecolor),),
                              // ),


                            ],
                          ),
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

  void _ModalBottomSheet(context) {
    String title="",murl="",des="";

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
                    "Add Achievment",
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
                                style: TextStyle(color: bluecolor,fontSize: 18),
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
                            style: TextStyle(color: bluecolor, fontSize: 18),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[500]))),
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
                            style: TextStyle(color: bluecolor, fontSize: 18),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[500]))),
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
                            style: TextStyle(color: bluecolor, fontSize: 18),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[500]))),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _controller.close();
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
}
