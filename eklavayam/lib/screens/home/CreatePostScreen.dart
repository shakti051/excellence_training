import 'dart:convert';
import 'dart:io';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/writer/WriterToolScreen.dart';

import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name, image, mobile, token;
  int uniqueId;
  List<Asset> images = List<Asset>();
  List<File> imagesFile = List();
  List<String> imgurl=List();
  String _error = 'No Error Dectected';
  TextEditingController titleController;
  String title = "";

  // Widget buildGridView() {
  //   return GridView.count(
  //     crossAxisCount: 3,
  //     children: List.generate(images.length, (index) {
  //       Asset asset = images[index];
  //       return Padding(
  //         padding: const EdgeInsets.all(2.0),
  //         child: AssetThumb(
  //           asset: asset,
  //           width: 300,
  //           height: 300,
  //         ),
  //       );
  //     }),
  //   );
  // }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#00A3C7",
          actionBarTitle: "Gallary",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#FBBA00",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  int variableSet = 0;
  ScrollController _scrollController;
  double width;
  double height;

  // Future<void> loadFiles() async{
  //   FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //
  //   if(result != null) {
  //     List<File> files = result.paths.map((path) => File(path)).toList();
  //
  //     setState(() {
  //       imagesFile =files;
  //     });
  //   } else {
  //     // User canceled the picker
  //   }
  // }

  Future<void> asset_file() async {
    imagesFile = [];
    for (Asset asset in images) {
      final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      imagesFile.add(File(filePath));
     await uploadimageCall(File(filePath));
    }

    createPostCall();

  }

  Future<void> uploadimageCall(File image) async {
    print("uploadimage");
    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.uploadImage(image);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      imgurl.add(responsedata['imageUrl']);
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  Future<void> createPostCall() async {
    var jsonstring = {
      "userId": uniqueId,
      "content": title,
      "leadMedia": [
        {
          "imgUrl":
              "https://stageapi.eklavyam.com:4001/upload/images/47073619-Photo.jpg"
        }
      ],
      "publishedOn": getTimeStamp(),
      "contentType": 1
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(createPostUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      setState(() {});
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
      uniqueId = (sharedPrefs.getInt('uniqueId') ?? "  ");
      // print(name + " " + image + " " + mobile + " " + token);
      //print("SFtoken> " + token);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    restoreSF();
    // Future.delayed(Duration.zero, () => getEventCategoryCall());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: bluecolor,
        title: const Text('Create Post'),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15, top: 5, right: 15),
                width: MediaQuery.of(context).size.width,
                height: 75,
                //color: Colors.white,
                child: Row(
                  children: [
                    Card(
                      color: Colors.grey.shade100,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset("assets/images/onlypen.png"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Vishwajeet",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    // Expanded(
                    //   child: Card(
                    //     margin: EdgeInsets.only(left: 5,right: 10),
                    //     //color: Colors.grey.shade100,
                    //     elevation: 0.0,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(5.0)),
                    //     child: Container(
                    //       alignment: Alignment.centerLeft,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //       ),
                    //       child: Text("Write something about post.."),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[500]))),
                  child: TextField(
                    controller: titleController,
// obscureText: passobsucure,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: "Write something about post... ",
                    ),
                    onChanged: (value) {
                      title = value;
// this.phoneNo=value;
// password = value;
                      print(value);
                    },
                  )),

              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      loadAssets();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: bluecolorlight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 40,
                      //width: 80,
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.add_photo_alternate_sharp,
                              color: orangecolor,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Photos",
                            style: TextStyle(
                                color: bluecolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WriterToolScreen()));// WriterToolScreen()
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: bluecolorlight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 40,
                      //width: 80,
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/images/onlypen.png",
                              height: 30,
                              width: 30,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Writer Tool",
                            style: TextStyle(
                                color: bluecolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: RaisedButton(
              //     child: Text("images"),
              //     onPressed: loadAssets,
              //   ),
              // ),

              DragAndDropGridView(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 4.5,
                ),
                padding: EdgeInsets.all(20),
                itemBuilder: (context, index) => Card(
                  elevation: 2,
                  child: LayoutBuilder(
                    builder: (context, costrains) {
                      if (variableSet == 0) {
                        height = costrains.maxHeight;
                        width = costrains.maxWidth;
                        variableSet++;
                      }
                      return GridTile(
                        child: AssetThumb(
                          asset: images[index],
                          width: width.toInt(),
                          height: height.toInt(),
                        ),
                      );
                    },
                  ),
                ),
                itemCount: images.length,
                onWillAccept: (oldIndex, newIndex) {
                  // Implement you own logic

                  // Example reject the reorder if the moving item's value is something specific
                  if (images[newIndex] == "something") {
                    return false;
                  }
                  return true; // If you want to accept the child return true or else return false
                },
                onReorder: (oldIndex, newIndex) {
                  final temp = images[oldIndex];
                  images[oldIndex] = images[newIndex];
                  images[newIndex] = temp;

                  setState(() {});
                },
              ),

              // Expanded(
              //   child: buildGridView(),
              // )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: (){
                asset_file();
              },
              child: Container(
                height: 60,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: orangecolor,
                ),
                child: Text(
                  "Post",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
