import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/MyTicketModel.dart';

class MyTicketScreen extends StatefulWidget {
  @override
  _MyTicketScreenState createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController bottomshetcontroller;
  PersistentBottomSheetController cancelshetcontroller;
  List<MyTicketData> myticketlist;
  String name, image, mobile, token;
  int uniqueId;

  Future<void> getMyTicketist() async {
    var jsonstring = {
      "userId": uniqueId //uniqueId
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata =
        await networkClient.postData(getEventMyTicketUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      MyTicketModel myTicketModel = new MyTicketModel.fromJson(responsedata);

      setState(() {
        myticketlist = myTicketModel.data;
      });
    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['msg']);
    //print(responsedata['status']);
  }

  Future<void> cancelTicket(int uniqueid) async {
    var jsonstring = {
      "uniqueId": uniqueid,
     //uniqueId
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata =
    await networkClient.postData(cancelTicketUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
    cancelshetcontroller.close();
    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['msg']);
    //print(responsedata['status']);
  }

  Future<void> cancelseat(int noofticket,int uniqueid) async {
    var jsonstring = {
      "cancelTickets": noofticket,
      "uniqueId": uniqueId//uniqueId
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata =
    await networkClient.postData(cancelTecketSeatUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
    cancelshetcontroller.close();
    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['msg']);
    //print(responsedata['status']);
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

    super.initState();
    restoreSF();
    Future.delayed(Duration.zero, () => getMyTicketist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        backgroundColor: bluecolor,
        centerTitle: true,
        title: Text(
          "My Tickets",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: myticketlist != null
          ? ListView.builder(
              itemCount: myticketlist.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Stack(
                        // alignment: FractionalOffset.center,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(top: 100, right: 5),
                              height: 40,
                              width: 35,
                              child: Material(
                                clipBehavior: Clip.antiAlias,
                                shape: BeveledRectangleBorder(
                                    // side: BorderSide(color: Colors.blue), if you need
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0))),
                                child: Container(
                                  height: 40,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10, bottom: 5, left: 15, right: 15),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      myticketlist[index].eventImages,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.all(20),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: orangecolor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(myticketlist[index].startDay),
                                  Text(myticketlist[index].startMonthName),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 100, right: 15),
                              height: 40,
                              width: 100,
                              color: Colors.blue,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.rupeeSign,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  myticketlist[index].totalPrice != 0
                                      ? Text(
                                          myticketlist[index]
                                              .totalPrice
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "FREE",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        color: bluecolorlight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myticketlist[index].eventName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  myticketlist[index].eventTypes,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Seats " +
                                      myticketlist[index]
                                          .ticketCount
                                          .toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Text("price", style: TextStyle(fontSize: 16),),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showTicketsbottomSheet(context, index);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => EventDetailScreen(
                                      //             alleventlist[index].uniqueId)));
                                      // setState(() {
                                      //   alleventlist[indexx].interest[index].value =
                                      //   !artlist[indexx].interest[index].value;
                                      // });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: darkbluecolor),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          //Icon(Icons.add,color: Colors.white,),
                                          Text(
                                            "View Ticket",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cancelTicketsbottomSheet(context, index);
                                      // bookTicketBottomSheet(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: orangecolor),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          //Icon(Icons.add,color: Colors.white,),
                                          Text(
                                            "Cancel Ticket",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              },
            )
          : Container(),
    );
  }

  showTicketsbottomSheet(context, int index) {
    bottomshetcontroller =
        _scafoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return Container(
        margin: EdgeInsets.only(top: 12),
        // height: MediaQuery.of(context).size.height,
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
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                myticketlist[index].eventName,
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
                  margin: EdgeInsets.only(top: 30),
                  child: Container(
                    child: Card(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Stack(
                            // alignment: FractionalOffset.center,
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: EdgeInsets.only(top: 100, right: 5),
                                  height: 40,
                                  width: 35,
                                  child: Material(
                                    clipBehavior: Clip.antiAlias,
                                    shape: BeveledRectangleBorder(
                                        // side: BorderSide(color: Colors.blue), if you need
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight:
                                                Radius.circular(10.0))),
                                    child: Container(
                                      height: 40,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 15, right: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          myticketlist[index].eventImages,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child: Container(
                              //     margin: EdgeInsets.all(20),
                              //     height: 50,
                              //     width: 50,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(100),
                              //         color: orangecolor),
                              //     child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Text(myticketlist[index].startDay),
                              //         Text(myticketlist[index].startMonthName),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 100, right: 15),
                                  height: 40,
                                  width: 100,
                                  color: Colors.blue,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.rupeeSign,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      myticketlist[index].totalPrice != 0
                                          ? Text(
                                              myticketlist[index]
                                                  .totalPrice
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              "FREE",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            color: bluecolorlight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   myticketlist[index].eventName,
                                //   style: TextStyle(
                                //       fontSize: 20,
                                //       fontWeight: FontWeight.bold),
                                // ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      myticketlist[index].eventTypes,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Seats " +
                                          myticketlist[index]
                                              .ticketCount
                                              .toString(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Start Date",
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                        ),
                                        Text(getDateforTimestamp(myticketlist[index].startDate), style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                    Container(height: 50,width: 1,color: bluecolor,),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "End Date",
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                        ),
                                        Text(getDateforTimestamp(myticketlist[index].endDate), style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 15,),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Description",
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                    ),
                                    Text(myticketlist[index].description, style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      );
    });
  }

  cancelTicketsbottomSheet(context, int index) {
    bool checkbox=true;

    List<bool> chekboxvaluelist=List();

    for(int i=0;i<myticketlist[index].ticketCount;i++)
      {
        chekboxvaluelist.add(false);
      }

    cancelshetcontroller =
        _scafoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return Container(
        margin: EdgeInsets.only(top: 12),
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
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "Cancel Tickets",
              style: TextStyle(
                  color: whitecolor, fontSize: 20, fontWeight: FontWeight.bold),
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
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      color: bluecolorlight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myticketlist[index].eventName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Start Date",
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                              ),
                              Text(getDateforTimestamp(myticketlist[index].startDate), style: TextStyle(fontSize: 16),),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ticket Price ",
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                              ),
                              Text(

                                    myticketlist[index]
                                        .totalPrice
                                        .toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                          "Seats ",
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                              ),
                              Text(

                                    myticketlist[index]
                                        .ticketCount
                                        .toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Price ",
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                              ),
                              Text(
                                    myticketlist[index]
                                        .totalTicketPrice
                                        .toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: myticketlist[index].ticketCount,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                margin: EdgeInsets.all(2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Text(
                                      "Seat " + (index+1).toString(),
                                      style: TextStyle(fontSize: 16),
                                    ),

                                    Checkbox(
                                      checkColor: bluecolor,
                                      activeColor: orangecolor,
                                      value: chekboxvaluelist[index],
                                      onChanged: (bool value) {
                                        cancelshetcontroller.setState(() {
                                          chekboxvaluelist[index] = value;
                                        });
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                )),
          ),

          Container(
            padding: EdgeInsets.only(bottom: 20),
            color: Colors.white,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    int totalseat=0;
                    for(int i=0;i<myticketlist[index].ticketCount;i++)
                    {
                      if(chekboxvaluelist[i]==true)
                        {
                          totalseat++;
                        }
                    }

                    if(totalseat>0)
                      {
                        print("cancel seat"+totalseat.toString());
                        cancelseat(totalseat, myticketlist[index].uniqueId);
                      }
                    else{ showSnakbarWithGlobalKey(_scafoldKey, "Please select atleast one seat");
                    print("Please select atleast one seat");
                    }
                   // showTicketsbottomSheet(context, index);

                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(20),
                        color: darkbluecolor),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        //Icon(Icons.add,color: Colors.white,),
                        Text(
                          "Cancel Seats",
                          style:
                          TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cancelTicket(myticketlist[index].uniqueId);
                    //cancelTicketsbottomSheet(context, index);
                    // bookTicketBottomSheet(context);
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(20),
                        color: orangecolor),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        //Icon(Icons.add,color: Colors.white,),
                        Text(
                          "Cancel Ticket",
                          style:
                          TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )

        ]),

        // Container(
        //   color: Colors.white,
        //   child: Padding(
        //     padding: EdgeInsets.only(
        //         top:5.0, bottom: 20.0, left: 25.0, right: 25.0),
        //
        //   ),
        // ),
      );
    });
  }
}
