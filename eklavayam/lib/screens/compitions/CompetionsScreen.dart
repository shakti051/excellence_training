import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/CompetitionModel.dart';

class CompetionsScreen extends StatefulWidget {
  @override
  _CompetionsScreenState createState() => _CompetionsScreenState();
}

class _CompetionsScreenState extends State<CompetionsScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<CompetitionData> competitionlist;
  String name, image, mobile, token;
  int uniqueId;

  Future<void> getMyCompetitionList() async {
    var jsonstring = {
      //uniqueId
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata =
        await networkClient.postData(getCompetitionUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      CompetitionModel competitionModel =
          new CompetitionModel.fromJson(responsedata);

      setState(() {
        competitionlist = competitionModel.data;
      });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['msg']);
    //print(responsedata['status']);
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
    restoreSF();
    Future.delayed(Duration.zero, () => getMyCompetitionList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bluecolor,
        centerTitle: true,
        title: Text(
          "Competition",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: competitionlist != null
          ? ListView.builder(
              itemCount: competitionlist.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * .3,
                                child: Image.network(
                                  competitionlist[index].banner,
                                  fit: BoxFit.cover,
                                )),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 50, left: 20),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       Navigator.of(context).pop();
                            //     },
                            //     child: Container(
                            //       child: Icon(
                            //         Icons.arrow_back_ios,
                            //         size: 25,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                competitionlist[index].competitionName,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Start Date:  ",
                                        style: TextStyle(
                                            color: bluecolor, fontSize: 16),
                                      ),
                                      Text(
                                          getDateforTimestamp(
                                              competitionlist[index].startDate),
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 14)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "End Date:  ",
                                        style: TextStyle(
                                            color: bluecolor, fontSize: 16),
                                      ),
                                      Text(
                                          getDateforTimestamp(
                                              competitionlist[index].endDate),
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 14)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "No of Entry :  ",
                                        style: TextStyle(
                                            color: bluecolor, fontSize: 16),
                                      ),
                                      Text(
                                          competitionlist[index]
                                              .totalNumEntries
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 16)),
                                    ],
                                  ),
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       "Reaminig Ticket:  ",
                                  //       style: TextStyle(
                                  //           fontSize: 16, color: bluecolor),
                                  //     ),
                                  //     Text(
                                  //         eventDetailModel.data.remainingTicket
                                  //             .toString(),
                                  //         style: TextStyle(
                                  //             color: Colors.black, fontSize: 16)),
                                  //   ],
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "Winners ",
                            style: TextStyle(color: bluecolor, fontSize: 16),
                          ),
                        ),
                        competitionlist[index].winner.length > 0
                            ? Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        competitionlist[index].winner.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, indexx) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            right: 15, top: 15, bottom: 15),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 90,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(100),
                                                  color: orangecolor),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: Image.network(
                                                    competitionlist[index]
                                                        .winner[indexx]
                                                        .photo,fit: BoxFit.cover,),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(competitionlist[index]
                                                .winner[indexx]
                                                .name),
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            : Container(),
                       // Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.black,)
                      ],
                    ),
                  ),
                );
              })
          : Container(),
    );
  }
}
