import 'dart:io';
import 'package:eklavayam/screens/home/Bottomtabs/model/LikeSelectedModel.dart';
import 'package:eklavayam/screens/home/Bottomtabs/model/LikesModel.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikeDialog extends StatefulWidget {
  String dialog_name;
  List<LikesData> likeslist;

  LikeDialog(this.dialog_name, this.likeslist);

  @override
  State<StatefulWidget> createState() => LikeDialogState();
}

class LikeDialogState extends State<LikeDialog>
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

  List<LikesData> likelist = List(); //1
  List<LikesData> lovelist = List(); //2
  List<LikesData> happylist = List(); //3
  List<LikesData> hahalist = List(); //4
  List<LikesData> thinklist = List(); //5
  List<LikesData> sadlist = List(); //6
  List<LikesData> lovelylist = List(); //7
  List<LikeSelectedModel> selectedLikesModel = List();

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

  // Future<void> createBookCall() async {
  //   // 9812010471
  //
  //   var jsonstring = {
  //     "userId": uniqueId,
  //     "type": 0,
  //     "title": titleController.text,
  //     "description": desController.text,
  //     "images": eimage,
  //     "link": murlController.text
  //   };
  //   var jsondata = jsonEncode(jsonstring);
  //   print(jsondata);
  //
  //   showAlertDialog(context);
  //   NetworkClient networkClient = new NetworkClient();
  //   var responsedata =
  //   await networkClient.postData(addbook_award_achiUrl, jsondata);
  //
  //   print(responsedata);
  //   Navigator.pop(context);
  //   if (responsedata['status'] == 1) {
  //     //_controller.close();
  //   } else
  //     showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  // }

  @override
  void initState() {
    super.initState();
    restoreSF();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    createMenuList();
  }

  createMenuList()async{
    await createList();
    await createemojitabslist();
  }

  createemojitabslist()
  {
    selectedLikesModel.add(LikeSelectedModel(0,"All","assets/images/like.gif",widget.likeslist));
    if(likelist.length>0)
      selectedLikesModel.add(LikeSelectedModel(1,"Likes","assets/images/ic_like_fill.png",likelist));
    if(lovelist.length>0)
      selectedLikesModel.add(LikeSelectedModel(2,"Love","assets/images/love2.png",lovelist));
    if(happylist.length>0)
      selectedLikesModel.add(LikeSelectedModel(3,"Happy","assets/images/happy.png",happylist));
    if(hahalist.length>0)
      selectedLikesModel.add(LikeSelectedModel(4,"HaHa","assets/images/haha2.png",hahalist));
    if(thinklist.length>0)
      selectedLikesModel.add(LikeSelectedModel(5,"Think","assets/images/think.png",thinklist));
    if(sadlist.length>0)
      selectedLikesModel.add(LikeSelectedModel(6,"Sad","assets/images/sad2.png",sadlist));
    if(lovelylist.length>0)
      selectedLikesModel.add(LikeSelectedModel(7,"Lovely","assets/images/lovely.png",lovelylist));
  }

  createList() {
    for (int i = 0; i < widget.likeslist.length; i++) {
      if (widget.likeslist[i].likeType == 1) {
        likelist.add(widget.likeslist[i]);
      } else if (widget.likeslist[i].likeType == 2) {
        lovelist.add(widget.likeslist[i]);
      } else if (widget.likeslist[i].likeType == 3) {
        happylist.add(widget.likeslist[i]);
      } else if (widget.likeslist[i].likeType == 4) {
        hahalist.add(widget.likeslist[i]);
      } else if (widget.likeslist[i].likeType == 5) {
        thinklist.add(widget.likeslist[i]);
      } else if (widget.likeslist[i].likeType == 6) {
        sadlist.add(widget.likeslist[i]);
      } else if (widget.likeslist[i].likeType == 7) {
        lovelylist.add(widget.likeslist[i]);
      }
    }
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
            // height: MediaQuery.of(context).size.height - 40,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 0.0),
                  //       child: Text(
                  //         widget.dialog_name,
                  //         style: TextStyle(
                  //             color: bluecolor,
                  //             fontSize: 22,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //     // Container(
                  //     //   alignment: Alignment.bottomRight,
                  //     //   child: GestureDetector(
                  //     //       onTap: () {
                  //     //         setState(() {
                  //     //           canedit = !canedit;
                  //     //         });
                  //     //       },
                  //     //       child: Container(
                  //     //           height: 35,
                  //     //           width: 35,
                  //     //           decoration: BoxDecoration(
                  //     //               color: canedit?Colors.grey:orangecolor,
                  //     //               borderRadius: BorderRadius.circular(100)),
                  //     //           child: Icon(
                  //     //             Icons.edit,
                  //     //             color: Colors.white,
                  //     //             size: 25,
                  //     //           ))),
                  //     // ),
                  //
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),

                  Container(height: 55,
                  child:   ListView.builder(
                      itemCount: selectedLikesModel.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          height: 55,
                          color: Colors.white,
                          child: Column(children: [
                            Image.asset(selectedLikesModel[index].emojipath,height: 25,width: 25,),
                            SizedBox(height: 3,),
                            Text(selectedLikesModel[index].selectedlikeslist.length.toString()+" "+selectedLikesModel[index].name,style: TextStyle(fontSize: 10),),
                          ],)
                        );
                      }),
                  ),


                  ListView.builder(
                    padding: EdgeInsets.zero,
                      itemCount: widget.likeslist.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                         // height: 80,
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
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      //color: bluecolor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: widget.likeslist[index].profileImg !=
                                              null
                                          ? Image.network(
                                              widget.likeslist[index].profileImg,fit: BoxFit.fill,)
                                          : Image.asset(
                                              "assets/images/onlypen.png",fit: BoxFit.fill),
                                    )),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.likeslist[index].fullName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    //SizedBox(height: 5),
                                    //Text(notificationdata[index].contentText,maxLines: 3,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
