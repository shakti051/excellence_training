import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eklavayam/screens/home/HomeDrawerBottomScreen.dart';
import 'package:eklavayam/screens/home/Home_Drwawer_Screen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;


class BookingConfirmationScreen extends StatefulWidget {
  final String appoinmentid,grandtotal,transuction_id;


  BookingConfirmationScreen(this.appoinmentid,this.grandtotal,this.transuction_id);


  @override
  _BookingConfirmationScreenState createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String token="";
  int uniqueId=0;


  // restore() async {
  //   final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  //     token = (sharedPrefs.getString('token') ?? "");
  //     uniqueId = (sharedPrefs.getInt('uniqueId') ?? 0);
  //     print("jobtype: > " + uniqueId.toString() + " " + token);
  //    // addPaymentApi();
  //
  // }

  // addPaymentApi() async {
  //   try {
  //     showAlertDialog(context);
  //     http.Response response = await http
  //         .post(addPaymentUrl,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer ' + token,
  //         },
  //         body: jsonEncode({
  //           "appointmentId": widget.appoinmentid,
  //           "transactionId": widget.transuction_id,
  //           "paymentType": 1,
  //           "paymentMode": "Online",
  //           "amount": widget.grandtotal
  //         }))
  //         .timeout(Duration(seconds: api_timeout));
  //
  //     // var jsonres = jsonDecode(appoinmentid+"  "+grandtotal+"  "+coupon_code+"   >"+response.statusCode.toString()+response.body);
  //
  //     // print("paynowapi>>> "+response.statusCode.toString()+" " + jsonres.toString());
  //     // Navigator.pop(context);
  //     print("addPAymentres");
  //     print(response);
  //     Navigator.pop(context);
  //     if (response.statusCode == 200) {
  //
  //
  //       }
  //
  //   } on TimeoutException catch (e) {
  //     Navigator.pop(context);
  //     showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
  //     print("Timeout Exception" + e.toString());
  //   } on SocketException catch (e) {
  //     Navigator.pop(context);
  //     showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
  //     print("Socket Exception" + e.toString());
  //   } on Exception catch (e) {
  //     Navigator.pop(context);
  //     showSnakbarWithGlobalKey(_scaffoldKey, exception_message);
  //     print("Exception" + e.toString());
  //   }
  // }



  @override
  void initState() {
    super.initState();
   // restore();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [bluecolor, bluecolor, bluecolor])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
//                  GestureDetector(
//                      onTap: () {
//                        Navigator.pop(context);
//                      },
//                      child: Icon(
//                        Icons.arrow_back,
//                        color: whiteclr,
//                        size: 25,
//                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                    child: Text(
                      "Ticket Confirmed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          //CheckSign.ok,
                          size: 150.0,
                          color: Colors.green,
                        ),
                        SizedBox(height: 20,),
                        Text("Confirmed",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20),
                        Text("Thanks for choosing",style: TextStyle(fontSize: 22,)),
                        SizedBox(height: 10,),
                        Text("EKLVAYAM",style: TextStyle(fontSize: 22,)),
                        SizedBox(height: 20,),
                        Text("Ticket ID  "+widget.appoinmentid,style: TextStyle(fontSize: 22,)),
                        SizedBox(height: 20,),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            //mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Icon(
                                    FontAwesomeIcons.rupeeSign,
                                    size: 20,
                                  )),
                              SizedBox(
                                width: 3,
                              ),
                              Text(widget.grandtotal,style: TextStyle(fontSize: 22,)),
                            ],
                          ),
                        ),
                        SizedBox(height: 40,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeDrawerBottomScreen()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
                            decoration: BoxDecoration(
                              color: bluecolor,
                                  borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                                "Got It",style: TextStyle(fontSize: 22,color: Colors.white
                            ),)
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

