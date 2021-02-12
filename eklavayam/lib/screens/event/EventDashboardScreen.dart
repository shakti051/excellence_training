import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/event/EventDetailScreen.dart';

import 'package:eklavayam/screens/event/model/AllEventModel.dart';
import 'package:eklavayam/utill/BookingConfirmationScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/StaticString.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class EventDashboardScreen extends StatefulWidget {
  @override
  _EventDashboardScreenState createState() => _EventDashboardScreenState();
}

class _EventDashboardScreenState extends State<EventDashboardScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Razorpay razorpay;
  String name, image, mobile, token;
  int uniqueId;

  TextEditingController ticket_namecontroller,
      ticket_emailcontroler,
      ticket_mobilecontroller,
      ticket_noofticket;

  List<AllEventData> alleventlist;

  Future<void> getAllEventCall() async {
    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.getApiCall(getAllEventUrl);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      AllEventModel allEventModel = AllEventModel.fromJson(responsedata);
      setState(() {
        alleventlist = allEventModel.data;
      });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  Future<void> bookEventCall(int index) async {
    // 9812010471

    var jsonstring = {
      "createdOn": getTimeStamp(),
      "eventUniqueId": alleventlist[index].uniqueId,
      "userId": uniqueId,
      "firstName": ticket_namecontroller.text,
      "lastName": "",
      "email": ticket_emailcontroler.text,
      "mobile": ticket_mobilecontroller.text,
      "numberOfTickets": ticket_noofticket.text
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(createTicketUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      if (alleventlist[index].paidType == 0)
        showSnakbarWithGlobalKey(_scaffoldKey, "Successfully Booked");
      else
        razorPayApiCall(alleventlist[index].ticketPrice *
            int.parse(ticket_noofticket.text));
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  Future<void> razorPayApiCall(int price) async {
    var jsonstring = {
      "currency": "INR",
      "totalPrice": price,
      "userId": uniqueId
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(razorPayurl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      openRazorPayCheckout(
        responsedata['data']['amount'],
        responsedata['data']['orderId'],
      );
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RazorPayScreen(amount: responsedata['amount'],orderid: responsedata['orderId'],)));

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
      uniqueId = (sharedPrefs.getInt('uniqueId') ?? 0);
      // print(name + " " + image + " " + mobile + " " + token);
      //print("SFtoken> " + token);
    });
  }

  void openRazorPayCheckout(amount, orderid) {
    print("openrazorpay " + amount.toString() + " " + orderid.toString());
    // print("orderid: "+orderid+" amount "+amount);
    var options = {
      "key": razor_Key_Id,
      "amount": amount,
      "name": "EKLVAYAM ",
      "order_id": orderid,
      "description": "Please Pay",
      "theme": {"color": "#2851AE"},
//      "prefill" : {
//        "contact" : "2323232323",
//        "email" : "shdjsdh@gmail.com"
//      },
//      "external" : {
//        "wallets" : ["paytm"]
//      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print("razorpay11:");
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Payment success");
    print(response.orderId + " " + response.paymentId);
    print("razorpayres: " + response.toString());
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BookingConfirmationScreen(
                "appoinmentid", "grandtotal", response.paymentId)));
    showSnakbarWithGlobalKey(_scaffoldKey, "Payment success");
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Payment error" + response.code.toString() + " " + response.message);
    showSnakbarWithGlobalKey(_scaffoldKey, "Payment error");
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    showSnakbarWithGlobalKey(_scaffoldKey, "External Wallet");
  }

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

    restoreSF();
    Future.delayed(Duration.zero, () => getAllEventCall());

    ticket_namecontroller = TextEditingController();
    ticket_emailcontroler = TextEditingController();
    ticket_mobilecontroller = TextEditingController();
    ticket_noofticket = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildArtGrid(context),
    );
  }

  Widget _buildArtGrid(BuildContext context) {
    return alleventlist != null
        ? Container(
            padding: EdgeInsets.only(top: 80),
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, indexx) {
                  return StickyHeader(
                      header: Container(
                        margin: EdgeInsets.only(top: 0, bottom: 10),
                        height: 50.0,
                        color: orangecolor,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "All Category",
                          style: TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      content: Container(
                        padding: EdgeInsets.only(top: 0.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          // itemCount: artlist[indexx].interest.length,
                          itemCount: alleventlist.length,
                          // gridDelegate:
                          //     SliverGridDelegateWithFixedCrossAxisCount(
                          //         crossAxisCount: 1),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
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
                              child: Card(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
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
                                                      BorderRadius.circular(
                                                          100),
                                                  //child: storylist[index].user.profile!=null?Image.network(storylist[index].user.profile,fit: BoxFit.fill,height: 40,width: 40,):
                                                  child: alleventlist[index]
                                                              .profileImg !=
                                                          null
                                                      ? Image.network(
                                                          alleventlist[index]
                                                              .profileImg,
                                                          fit: BoxFit.fill,
                                                          height: 40,
                                                          width: 40,
                                                        )
                                                      : Image.asset(
                                                          "assets/images/logo.png",
                                                          fit: BoxFit.fill,
                                                          height: 40,
                                                          width: 40)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Organiser",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  orangecolor,
                                                              size: 15,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  orangecolor,
                                                              size: 15,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  orangecolor,
                                                              size: 15,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  orangecolor,
                                                              size: 15,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  orangecolor,
                                                              size: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  alleventlist[index]
                                                              .fullName
                                                              .length >
                                                          25
                                                      ? Text(
                                                          alleventlist[index]
                                                              .fullName
                                                              .substring(0, 25),
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      : Text(
                                                          alleventlist[index]
                                                              .fullName,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                ],
                                              ),
                                            ],
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
                                    Stack(
                                      // alignment: FractionalOffset.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 100, right: 5),
                                            height: 40,
                                            width: 35,
                                            child: Material(
                                              clipBehavior: Clip.antiAlias,
                                              shape: BeveledRectangleBorder(
                                                  // side: BorderSide(color: Colors.blue), if you need
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10.0))),
                                              child: Container(
                                                height: 40,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10,
                                              bottom: 5,
                                              left: 15,
                                              right: 15),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey.shade200)
                                                ),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 150,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    alleventlist[index]
                                                        .eventImages[0],
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
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: orangecolor),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("31"),
                                                Text("DEC"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                top: 100, right: 15),
                                            height: 40,
                                            width: 100,
                                            color: Colors.blue,
                                            child: alleventlist[index]
                                                        .ticketPrice !=
                                                    0
                                                ? Text(
                                                    alleventlist[index]
                                                        .basePrice
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Text(
                                                    "FREE",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                            // child: Row(
                                            //   children: [
                                            //     Container(
                                            //       alignment: Alignment.centerRight,
                                            //       height: 30,
                                            //       //width: 65,
                                            //
                                            //       decoration: BoxDecoration(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   0),
                                            //           color: Colors.blue),
                                            //       child: Text("FREE Entry",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                            //     ),
                                            //   ],
                                            // ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 15, right: 15),
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width,
                                      color: bluecolorlight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            alleventlist[index].eventName,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            alleventlist[index].eventCategory,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            alleventlist[index].description,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EventDetailScreen(
                                                                    alleventlist[
                                                                            index]
                                                                        .uniqueId)));
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
                                                            BorderRadius
                                                                .circular(20),
                                                        color: darkbluecolor),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.list_alt,
                                                          color: Colors.white,
                                                        ),
                                                        Text(
                                                          "Show Event",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    bookTicketBottomSheet(
                                                        context, index);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: orangecolor),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .analytics_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        Text(
                                                          "Book Ticket",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
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
                              ),
                              // child: Stack(
                              //   children: <Widget>[
                              //     Card(
                              //       margin: EdgeInsets.all(5),
                              //       elevation: 2,
                              //       color
                              //           : whitecolor,
                              //       shadowColor: bluecolor,
                              //       child: new GridTile(
                              //         //footer: new Text(data[index]['name']),
                              //         child: Center(
                              //             child: Text(
                              //               alleventlist[indexx].interest[index]
                              //                   .termText,
                              //               style: TextStyle(color: artlist[indexx]
                              //                   .interest[index].value
                              //                   ? whitecolor
                              //                   : bluecolor, fontSize: 20),
                              //             )), //just for testing, will fill with image later
                              //       ),
                              //     ),
                              //     // artlist[indexx].interest[index].value? Container(
                              //     //   margin: EdgeInsets.all(5),
                              //     //   color: Colors.cyan.withAlpha(60),
                              //     //   child: Center(child: Icon(Icons.check,size: 60,color: whitecolor,)),
                              //     // ):Container()
                              //   ],
                              // ),
                            );
                          },
                        ),
                      ));
                }))
        : Container();
  }

  void bookTicketBottomSheet(context, int index) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return new Container(
            height: 550.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
              decoration: new BoxDecoration(
                  color: bluecolor,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(30.0),
                      topRight: const Radius.circular(30.0))),
              child: Expanded(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Book Ticket",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ],
                      ),
//                      Expanded(
//                        child: SingleChildScrollView(
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              top: 30, bottom: 10, left: 15, right: 15),
                          margin: EdgeInsets.only(top: 30),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(30.0),
                                  topRight: const Radius.circular(30.0))),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 20.0,
                                      right: 20.0),
                                  child: TextField(
                                    // focusNode: myFocusNodeName,
                                    controller: ticket_namecontroller,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      //errorText: snamevalidiate ? 'Enter Valid Name' : null,
                                      border: InputBorder.none,
                                      icon: Icon(
                                        FontAwesomeIcons.user,
                                        color: Colors.black,
                                      ),
                                      hintText: "Enter Full Name",
                                      hintStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 20.0,
                                      right: 20.0),
                                  child: TextField(
                                    // focusNode: myFocusNodeName,
                                    controller: ticket_emailcontroler,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      //errorText: snamevalidiate ? 'Enter Valid Name' : null,
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      hintText: "Enter Email",
                                      hintStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 20.0,
                                      right: 20.0),
                                  child: TextField(
                                    // focusNode: myFocusNodeName,
                                    controller: ticket_mobilecontroller,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      //errorText: snamevalidiate ? 'Enter Valid Name' : null,
                                      border: InputBorder.none,
                                      icon: Icon(
                                        FontAwesomeIcons.mobile,
                                        color: Colors.black,
                                      ),
                                      hintText: "Enter Mobile Number",
                                      hintStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 20.0,
                                      right: 20.0),
                                  child: TextField(
                                    // focusNode: myFocusNodeName,
                                    controller: ticket_noofticket,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      //errorText: snamevalidiate ? 'Enter Valid Name' : null,
                                      border: InputBorder.none,
                                      icon: Icon(
                                        FontAwesomeIcons.ticketAlt,
                                        color: Colors.black,
                                      ),
                                      hintText: "Number of Ticket",
                                      hintStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
//                                child: Column(
//                                  children: [
////                                    Container(
////                                      margin: EdgeInsets.fromLTRB(15, 0, 5, 15),
////                                      padding: EdgeInsets.all(5),
////                                      decoration: BoxDecoration(
////                                        color: blueclr,
////                                        borderRadius: BorderRadius.circular(10),
////                                      ),
////                                      child: GestureDetector(
////                                          onTap: () {
////                                          //  Navigator.pop(context);
////                                            Navigator.push(
////                                                context,
////                                                MaterialPageRoute(
////                                                    builder: (context) =>
////                                                        AddAdressScreen()));
////                                          },
////                                          child: Row(
////                                            children: [
////                                              Icon(
////                                                Icons.add,
////                                                color: whiteclr,
////                                              ),
////                                              Text(
////                                                "Add More Address",
////                                                style: TextStyle(color: whiteclr),
////                                              ),
////                                            ],
////                                          )),
////                                    ),
//                                    Padding(
//                                      padding: const EdgeInsets.all(15.0),
//                                      child: addresslist != null &&
//                                              addresslist.length >= 1
//                                          ? ListView.builder(
//                                              itemCount: addresslist.length,
//                                              shrinkWrap: true,
//
//                                              itemBuilder: (BuildContext context,
//                                                  int index) {
//                                                return Slidable(
//                                                  actionPane:
//                                                      SlidableDrawerActionPane(),
//                                                  actionExtentRatio: 0.25,
//                                                  child: GestureDetector(
//                                                    onTap: () {
//                                                      _controller.setState(() {
//                                                        selectedAddressId =
//                                                            addresslist[index]
//                                                                .uniqueId
//                                                                .toString();
//                                                        selectedAddress = addresslist[
//                                                                    index]
//                                                                .address1 +
//                                                            ", " +
//                                                            addresslist[index]
//                                                                .address2 +
//                                                            ", " +
//                                                            addresslist[index]
//                                                                .city +
//                                                            ", " +
//                                                            addresslist[index]
//                                                                .state;
//                                                      });
//
//                                                      Navigator.pop(context);
//                                                    },
//                                                    child: Container(
//                                                        margin: EdgeInsets.only(
//                                                            bottom: 8),
//                                                        color: Colors.white,
//                                                        child: Column(
//                                                          crossAxisAlignment:
//                                                              CrossAxisAlignment
//                                                                  .start,
//                                                          children: [
//                                                            Padding(
//                                                              padding:
//                                                                  const EdgeInsets
//                                                                      .all(15.0),
//                                                              child: Text(
//                                                                addresslist[index]
//                                                                        .address1 +
//                                                                    ", " +
//                                                                    addresslist[
//                                                                            index]
//                                                                        .address2 +
//                                                                    ", " +
//                                                                    addresslist[
//                                                                            index]
//                                                                        .city +
//                                                                    ", " +
//                                                                    addresslist[
//                                                                            index]
//                                                                        .state,
//                                                                style: TextStyle(
//                                                                    fontSize: 18),
//                                                              ),
//                                                            ),
//
////
////                                        Column(
////                                          children: [
////                                            Text("Address1",
////                                                style: TextStyle(
////                                                    color: Colors.black,
////                                                    fontWeight:
////                                                        FontWeight.bold)),
////                                            Text(addresslist[index].address1),
////                                          ],
////                                        ),
////                                        SizedBox(
////                                          height: 5,
////                                        ),
////                                        Column(
////                                          children: [
////                                            Text(
////                                              "Address2 ",
////                                              style: TextStyle(
////                                                  color: Colors.black,
////                                                  fontWeight: FontWeight.bold),
////                                            ),
////                                            Text(addresslist[index].address2 ??
////                                                ""),
////                                          ],
////                                        ),
////                                        SizedBox(
////                                          height: 5,
////                                        ),
////                                        Row(
////                                          mainAxisAlignment:
////                                              MainAxisAlignment.spaceBetween,
////                                          children: [
////                                            Row(
////                                              children: [
////                                                Text("city  ",
////                                                    style: TextStyle(
////                                                        color: Colors.black,
////                                                        fontWeight:
////                                                            FontWeight.bold)),
////                                                Text(addresslist[index].city),
////                                              ],
////                                            ),
////                                            Row(
////                                              children: [
////                                                Text("State  ",
////                                                    style: TextStyle(
////                                                        color: Colors.black,
////                                                        fontWeight:
////                                                            FontWeight.bold)),
////                                                Text(addresslist[index].state),
////                                              ],
////                                            ),
////                                          ],
////                                        ),
//                                                          ],
//                                                        )),
//                                                  ),
////                actions: <Widget>[
////                  IconSlideAction(
////                    caption: 'Archive',
////                    color: Colors.blue,
////                    icon: Icons.archive,
////                    onTap: () {print('archive');},
////                  ),
////                  IconSlideAction(
////                    caption: 'Share',
////                    color: Colors.indigo,
////                    icon: Icons.share,
////                    onTap: () {print('share');},
////                  ),
////                ],
//                                                  secondaryActions: <Widget>[
////                  IconSlideAction(
////                    caption: 'Start',
////                    color: blueclr,
////                    icon: Icons.play_arrow,
////                    onTap: ()  {print('more');},
////                  ),
//                                                    IconSlideAction(
//                                                      caption: 'Delete',
//                                                      color: Colors.red,
//                                                      icon: Icons.delete,
//                                                      onTap: () {
//                                                        deleteAddressApi(
//                                                            addresslist[index]
//                                                                .uniqueId);
//
//                                                        print('delete');
//                                                      },
//                                                    ),
//                                                  ],
//                                                );
//                                              })
//                                          : Container(),
//                                    ),
//                                  ],
//                                ),
                        ),
                      ),
                      //),
                      //),
                      GestureDetector(
                        onTap: () {
                          bookEventCall(index);
                        },
                        child: Container(
                          color: Colors.white,
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: orangecolor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
