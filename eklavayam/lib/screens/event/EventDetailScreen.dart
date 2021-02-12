import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/event/model/EventDetailModel.dart';
import 'package:eklavayam/utill/BookingConfirmationScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/StaticString.dart';
import 'package:eklavayam/utill/my_flutter_app_icons.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';



class EventDetailScreen extends StatefulWidget {
  final int eventid;

  EventDetailScreen(this.eventid);

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Razorpay razorpay;
  String name,image,mobile,token;
  int uniqueId;
  // List<AllEventData> alleventlist;
  EventDetailModel eventDetailModel;

  TextEditingController ticket_namecontroller,ticket_emailcontroler,ticket_mobilecontroller,ticket_noofticket;

  Future<void> getEventDetaiCall() async {
    var jsonstring = {
      "eventUniqueId": widget.eventid,
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata =
        await networkClient.postData(getEventDetailByIdUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      setState(() {
        eventDetailModel = EventDetailModel.fromJson(responsedata);
      });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  Future<void> bookEventCall() async {
    // 9812010471

    var jsonstring = {

      "createdOn":  getTimeStamp(),
      "eventUniqueId": eventDetailModel.data.uniqueId,
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
      if(eventDetailModel.data.paidType==0)
        showSnakbarWithGlobalKey(_scaffoldKey, "Successfully Booked");
      else
        razorPayApiCall(eventDetailModel.data.ticketPrice*int.parse(ticket_noofticket.text));

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
      Navigator.pop(context);
      openRazorPayCheckout(responsedata['data']['amount'],responsedata['data']['orderId']);
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>RazorPayScreen(amount: responsedata['amount'],orderid: responsedata['orderId'],)));

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  void openRazorPayCheckout(amount, orderid) {
    print("openrazorpay");
    var options = {
      "key": razor_Key_Id,
      "amount": amount,
      "name": "Eklvayam ",
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
      print("razorpay:");
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
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);


    Future.delayed(Duration.zero, () => getEventDetaiCall());
    restoreSF();

    ticket_namecontroller=TextEditingController();
    ticket_emailcontroler=TextEditingController();
    ticket_mobilecontroller=TextEditingController();
    ticket_noofticket=TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: eventDetailModel != null
          ? Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*.3,
                            child: Image.network(
                              eventDetailModel.data.eventImages[0],
                              fit: BoxFit.fill,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, left: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(

                              child: CircleAvatar(
                                backgroundColor: bluecolor,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
                            eventDetailModel.data.eventName,
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
                                      getDateforTimestamp(eventDetailModel.data.startDate)
                                          .toString(),
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
                                        fontSize: 16, color: bluecolor),
                                  ),
                                  Text(
                                      getDateforTimestamp(eventDetailModel.data.endDate)
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       "Event Date:  ",
                          //       style:
                          //           TextStyle(color: bluecolor, fontSize: 16),
                          //     ),
                          //     Text("21-nov-20 to 30-nov-20",
                          //         style: TextStyle(
                          //             color: Colors.black, fontSize: 20)),
                          //   ],
                          // ),
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
                                    "Total Ticket:  ",
                                    style: TextStyle(
                                        color: bluecolor, fontSize: 16),
                                  ),
                                  Text(
                                      eventDetailModel.data.numberOfTickets
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reaminig Ticket:  ",
                                    style: TextStyle(
                                        fontSize: 16, color: bluecolor),
                                  ),
                                  Text(
                                      eventDetailModel.data.remainingTicket
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16)),
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
                                    "Ticket Type  ",
                                    style: TextStyle(
                                        color: bluecolor, fontSize: 16),
                                  ),
                                  Text(eventDetailModel.data.paidType,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ticket Price:  ",
                                    style: TextStyle(
                                        color: bluecolor, fontSize: 16),
                                  ),
                                  Wrap(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(top: 2),
                                          child: Icon(
                                            MyFlutterApp.rupee_sign,
                                            size: 15,
                                          )),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                      eventDetailModel.data.ticketPrice
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "About Event ",
                                style: TextStyle(
                                    color: bluecolor, fontSize: 16),
                              ),
                              Text(
                                eventDetailModel.data.description,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  bookTicketBottomSheet(context);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: orangecolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
          : Container(),
    );
  }

  void bookTicketBottomSheet(context) {
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
                              top: 30, bottom: 0, left: 15, right: 15),
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
                      GestureDetector(
                        onTap: (){
                          bookEventCall();
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
                      //),
                      //),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
