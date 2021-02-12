import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/home/Bottomtabs/model/UserDetailModel.dart';
import 'package:eklavayam/utill/BasicDateTimeField.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';

class AboutTabScreen extends StatefulWidget {



UserDetailModel userDetailModel;
bool me;
  AboutTabScreen(this.userDetailModel,this.me);

  @override
  _AboutTabScreenState createState() => _AboutTabScreenState();
}

class _AboutTabScreenState extends State<AboutTabScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String email="",mobile="",name="",dob="",passion="",p_status="",description="";

  TextEditingController emailcontroller,mobilecontroller,namecontroller,passioncontroller,p_statuscontroller,descriptioncontroller;

  Future<void> updateAboutusCall() async {
    // 9812010471

    var jsonstring = {
      "userId":290,
      "fullName":"Vishwajeet bhau",
      "dob":"",
      "passion":"",
      "profileStatus":"",
      "description":""
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(update_aboutus, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }


  @override
  void initState() {

    super.initState();
    emailcontroller=TextEditingController();
    emailcontroller.text=widget.userDetailModel.data[0].email??"";
    mobilecontroller=TextEditingController();
    mobilecontroller.text=widget.userDetailModel.data[0].mobile??"";
    namecontroller=TextEditingController();
    namecontroller.text=widget.userDetailModel.data[0].fullName??"";
    passioncontroller=TextEditingController();
    passioncontroller.text=widget.userDetailModel.data[0].passion??"";
    p_statuscontroller=TextEditingController();
    p_statuscontroller.text=widget.userDetailModel.data[0].profileStatus??"";
    descriptioncontroller=TextEditingController();
    descriptioncontroller.text=widget.userDetailModel.data[0].description??"";
   //dob= widget.userDetailModel.data[0].dob!=null?getDateforTimestamp(widget.userDetailModel.data[0].dob):0;


  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              alignment: FractionalOffset.bottomLeft,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 65),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: orangecolor),
                  child: Image.asset(
                    "assets/images/background.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    margin: EdgeInsets.only(left: 30),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: bluecolor),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 160, top: 0, bottom: 15),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/images/fb.png",
                            height: 30,
                            width: 30,
                          ),

                          Image.asset(
                            "assets/images/twitter.png",
                            height: 30,
                            width: 30,
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          Image.asset(
                            "assets/images/insta.png",
                            height: 30,
                            width: 30,
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          Image.asset(
                            "assets/images/youtube.png",
                            height: 30,
                            width: 30,
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          Image.asset(
                            "assets/images/linkidin.png",
                            height: 30,
                            width: 30,
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                        ],
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 20),
            //   //height: 35,
            //   width: 120,
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     color: bluecolor,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Text(
            //     "Name",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),


            Text(
              "Email",
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
                  controller: emailcontroller,
                  // obscureText: passobsucure,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: " Email",
                  ),
                  onChanged: (value) {
                    email = value;
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
              "Mobile",
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
                  controller: mobilecontroller,
                  // obscureText: passobsucure,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: " Mobile",
                  ),
                  onChanged: (value) {
                    mobile = value;
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
              "Name",
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
                  controller: namecontroller,
                  // obscureText: passobsucure,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: " Name",
                  ),
                  onChanged: (value) {
                    name = value;
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
              "DOB",
              textAlign: TextAlign.left,
              style: TextStyle(color: bluecolor, fontSize: 18),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
              child: BasicDateTimeField(fun: (val) {
                // edate = val.toString();
                dob=getTimeStampWithDate(val);
              }),

              // TextField(
              //   maxLines: 5,
              //   // obscureText: passobsucure,
              //   decoration: InputDecoration(
              //     border: InputBorder.none,
              //     hintText: "Enter Event Name",
              //   ),
              //   onChanged: (value) {
              //     // this.phoneNo=value;
              //     // password = value;
              //     print(value);
              //   },
              // )
            ),
            SizedBox(
              height: 20,
            ),





            Text(
              "Passion",
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
                  controller: passioncontroller,
                  // obscureText: passobsucure,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: " Passion",
                  ),
                  onChanged: (value) {
                    passion = value;
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
              "Profile Status",
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
                  controller: p_statuscontroller,
                  // obscureText: passobsucure,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Profile Status",
                  ),
                  onChanged: (value) {
                    p_status = value;
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
                  controller: descriptioncontroller,
                  // obscureText: passobsucure,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description",
                  ),
                  onChanged: (value) {
                    description = value;
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

    );
  }
}
