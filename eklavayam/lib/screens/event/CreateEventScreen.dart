import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/event/model/GetEventTypeModel.dart';
import 'package:eklavayam/utill/BasicDateTimeField.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'model/EventCategoryModel.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {

  int _paidtype, attendeesevent;

  int currentIndex = 0;
  bool pshow = false;
  bool nshow = true;
  String ntext = "Next";

  String eName = "",
      edes = "",
      sdate = "",
      edate = "",
      etype = "",
      ecategory = "",
      eimage = "",
      noofticket = "",
      ticketpernooling = "",
      attendees = "",
      price = "",
      paymentcurrency = "",
      tdes = "",
      emailtemplate = "";

  TextEditingController eNameController,
      edesController,
      noofticketController,
      ticketpernoolingcontroller,
      tpriceController,
      paymentcurrencyController,
      tdesController,
      emailtempController;

  // THESE MUST BE USED TO CONTROL THE STEPPER FROM EXTERNALLY.
  bool goNext = false;
  bool goPrevious = false;

  String name,image,mobile,token;
  int uniqueId;

  List<EventTypeData> eventTypelist;
  EventTypeData selectedEventType;

  List<EventCategoryData> eventCategoryList;
  EventCategoryData selectedEventCategory;

  File _profileImage;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
        uploadimageCall();
      } else {
        print('No image selected.');
      }
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> getEventTypeCall() async {
    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.getApiCall(getEventTypeUrl);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      GetEventTypeModel EventTypeModel =
          GetEventTypeModel.fromJson(responsedata);
      setState(() {
        eventTypelist = EventTypeModel.data;
      });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  Future<void> getEventCategoryCall() async {
    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.getApiCall(getEventCategoryUrl);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      EventCategoryModel eventCategoryModel =
          EventCategoryModel.fromJson(responsedata);
      setState(() {
        eventCategoryList = eventCategoryModel.data;
      });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }

  Future<void> uploadimageCall() async {
    print("uploadimage");
    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.uploadImage(_profileImage);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      eimage = responsedata['imageUrl'];
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

  Future<void> createEventCall() async {
    // 9812010471

    var jsonstring = {
      "description": edes,
      "endDate": edate,
      "eventCategory": selectedEventCategory.termTypeId,
      "eventImages": [
        eimage
      ],
      "eventName": eName,
      "eventType": selectedEventType.termTypeId,
      "paidType": _paidtype,
      "numberOfTickets": noofticket,
      "ticketPerBooking": ticketpernooling,
      "baseCurrency": paymentcurrency,
      "attendeesType": attendeesevent,
      "startDate": sdate,
      "ticketDescription": tdes,
      "ticketPrice": price,
      "uniqueId": uniqueId,
      "emailTemplate": emailtemplate
    };
    var jsondata = jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(createEventUrl, jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      setState(() {
        currentIndex = 3;
        pshow=false;
        nshow=false;
      });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
  }





  @override
  void initState() {
    super.initState();
    restoreSF();
    Future.delayed(Duration.zero, () => getEventTypeCall());
    Future.delayed(Duration.zero, () => getEventCategoryCall());

    eNameController = TextEditingController();
    edesController = TextEditingController();
    noofticketController = TextEditingController();
    ticketpernoolingcontroller = TextEditingController();
    tpriceController = TextEditingController();
    paymentcurrencyController = TextEditingController();
    tdesController = TextEditingController();
    emailtempController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 40, bottom: 10),
            decoration: BoxDecoration(
              color: bluecolor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1.0,
                  blurRadius: 2.0,
                )
              ],
              // borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: currentIndex == 0 ? orangecolor : Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.details),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: currentIndex == 1 ? orangecolor : Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.person),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: currentIndex == 2 ? orangecolor : Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.camera_alt),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: currentIndex == 3 ? orangecolor : Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.check),
                )
              ],
            ),
            //    child: IconStepper.externallyControlled(
            //       goNext: goNext,
            //       goPrevious: goPrevious,
            //       direction: Axis.horizontal,
            //       stepColor: Colors.white,
            //       activeStepColor: orangecolor,
            //       lineColor: Colors.white,
            //       lineLength: 50,
            //       steppingEnabled: true,
            //       icons: [
            //         Icon(Icons.details),
            //         Icon(Icons.person),
            //         Icon(Icons.camera_alt),
            //         Icon(Icons.check),
            //
            //   ],
            // ),
          ),
          Container(
            decoration: BoxDecoration(
              color: orangecolor,
              border: Border.all(width: 0.1),
            ),
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              header(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(child: getBodyWidget())),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pshow
                  ? RaisedButton(
                      color: orangecolor,
                      onPressed: () {
                        // MUST TO CONTROL STEPPER FROM EXTERNAL BUTTONS.
                        setState(() {
                          // goNext = false;
                          //goPrevious = true;

                          if (currentIndex > 0) {
                            currentIndex--;
                          }

                          if (currentIndex == 0) {
                            setState(() {
                              pshow = false;
                              nshow = true;
                              ntext = "Next";
                            });
                          }
                          if (currentIndex == 1) {
                            setState(() {
                              pshow = true;
                              nshow = true;
                              ntext = "Next";
                            });
                          }
                          if (currentIndex == 2) {
                            setState(() {
                              pshow = true;
                              nshow = true;
                              ntext = "Create Event";
                            });
                            //createEventCall();
                          }
                          if (currentIndex == 3) {
                            setState(() {
                              pshow = false;
                              nshow = false;
                              //ntext="Create Event";
                            });
                          }
                        });
                      },
                      child: Text('Previous'),
                    )
                  : Container(),
              nshow
                  ? RaisedButton(
                      color: orangecolor,
                      onPressed: () {
                        // MUST TO CONTROL STEPPER FROM EXTERNAL BUTTONS.
                        setState(() {
                          //goNext = true;
                          //goPrevious = false;

                          if (currentIndex < 3) {
                            currentIndex++;
                            if(currentIndex==3)
                              {
                                createEventCall();
                                setState(() {
                                  pshow = false;
                                  nshow = false;
                                  //ntext="Create Event";
                                });
                              }


                          }
                          if (currentIndex == 0) {
                            setState(() {
                              pshow = false;
                              nshow = true;
                              ntext = "Next";
                            });
                          }
                          if (currentIndex == 1) {
                            setState(() {
                              pshow = true;
                              nshow = true;
                              ntext = "Next";
                            });
                          }
                          if (currentIndex == 2) {
                            setState(() {
                              pshow = true;
                              nshow = true;
                              ntext = "Create Event";
                            });
                            // createEventCall();
                          }

                          // if (ntext == "Create Event") {
                          //
                          // }
                        });
                      },
                      child: Text(
                        ntext,
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }

  String header() {
    switch (currentIndex) {
      case 0:
        return 'Details';
      case 1:
        return 'Personal';

      case 2:
        return 'Image';

      case 3:
        return 'Finish';

      default:
        return 'Unknown';
    }
  }

  getBodyWidget() {
    if (currentIndex == 0) return DetailsPage();
    if (currentIndex == 1) return PersonalPage();
    if (currentIndex == 2) return ImagePage();
    if (currentIndex == 3) return FinishPage();
  }

  DetailsPage() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Event Name",
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
                controller: eNameController,
                // obscureText: passobsucure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Event Name",
                ),
                onChanged: (value) {
                  eName = value;
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
            "Event Description",
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
                maxLines: 5,
                controller: edesController,
                // obscureText: passobsucure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Event Description",
                ),
                onChanged: (value) {
                  edes = value;
                  // this.phoneNo=value;
                  // password = value;
                  print(value);
                },
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Start Date",
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
             // sdate = val.toString();
              sdate=getTimeStampWithDate(val);
            }),


          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "End Date",
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
              edate=getTimeStampWithDate(val);
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
        ],
      ),
    );
  }

  PersonalPage() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Event Type",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          eventTypelist != null
              ? Container(
                  padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                  child: DropdownButtonFormField<EventTypeData>(
                    isExpanded: true,
                    hint: Text("Select Event Type"),
                    value: selectedEventType,
                    validator: (arg) {
                      if (arg == null)
                        return 'Please select Event Type';
                      else
                        return null;
                    },
                    onChanged: (EventTypeData Value) {
//
                      setState(() {
                        selectedEventType = Value;
                      });
                    },
                    items: eventTypelist.map((EventTypeData user) {
                      return DropdownMenuItem<EventTypeData>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            //user.icon,
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user.termText,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          Text(
            "Event Category",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          eventCategoryList != null
              ? Container(
                  padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                  child: DropdownButtonFormField<EventCategoryData>(
                    isExpanded: true,
                    hint: Text("Select Event Category"),
                    value: selectedEventCategory,
                    validator: (arg) {
                      if (arg == null)
                        return 'Please select Event Category';
                      else
                        return null;
                    },
                    onChanged: (EventCategoryData Value) {
//
                      setState(() {
                        selectedEventCategory = Value;
                      });
                    },
                    items: eventCategoryList.map((EventCategoryData user) {
                      return DropdownMenuItem<EventCategoryData>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            //user.icon,
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user.termText,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          Text(
            "Event Glimpse",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          _profileImage == null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      strokeCap: StrokeCap.round,
                      dashPattern: [6, 3],
                      color: Colors.grey,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: Center(
                          child: DottedBorder(
                              padding: EdgeInsets.all(20),
                              borderType: BorderType.Circle,
                              dashPattern: [6, 3],
                              color: Colors.grey,
                              child: GestureDetector(
                                child: Image.asset(
                                  'assets/images/Camera.png',
                                  color: bluecolor,
                                ),
                                onTap: () => getImage(),
                              )),
                        ),
                      )),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _profileImage,
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              // width: 150,
                              // height: 90,
                              fit: BoxFit.fill,
                            )),
                        Positioned(
                            right: 2,
                            bottom: 2,
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(.6),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: orangecolor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _profileImage = null;
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
        ],
      ),
    );
  }

  ImagePage() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Paid Type",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    "Free Entry",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Radio(
                    value: 0,
                    groupValue: _paidtype,
                    onChanged: (int value) {
                      setState(() {
                        _paidtype = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Paid Entry",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Radio(
                    value: 1,
                    groupValue: _paidtype,
                    onChanged: (value) {
                      setState(() {
                        _paidtype = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Number of Ticket Available",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
              child: TextField(
                controller: noofticketController,
                // obscureText: passobsucure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Number of Ticket Availabe",
                ),
                onChanged: (value) {
                  noofticket = value;
                  // this.phoneNo=value;
                  // password = value;
                  print(value);
                },
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Ticket per Booking",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
              child: TextField(
                controller: ticketpernoolingcontroller,
                // obscureText: passobsucure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ticket per Booking",
                ),
                onChanged: (value) {
                  ticketpernooling = value;
                  // this.phoneNo=value;
                  // password = value;
                  print(value);
                },
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Attendees of Event ",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    "Performer",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Radio(
                    value: 0,
                    groupValue: attendeesevent,
                    onChanged: (int value) {
                      setState(() {
                        attendeesevent = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Audiance",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Radio(
                    value: 1,
                    groupValue: attendeesevent,
                    onChanged: (value) {
                      setState(() {
                        attendeesevent = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Ticket Price",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
              child: TextField(
                controller: tpriceController,
                // obscureText: passobsucure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Ticket Price",
                ),
                onChanged: (value) {
                  price = value;
                  // this.phoneNo=value;
                  // password = value;
                  print(value);
                },
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Payment Currency",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
              child: TextField(
                controller: paymentcurrencyController,
                // obscureText: passobsucure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Payment Currency",
                ),
                onChanged: (value) {
                  paymentcurrency = value;
                  // this.phoneNo=value;
                  // password = value;
                  print(value);
                },
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Ticket Description",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
              child: TextField(
                maxLines: 5,
                controller: tdesController,
                // obscureText: passobsucure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Ticket Description",
                ),
                onChanged: (value) {
                  tdes = value;
                  // this.phoneNo=value;
                  // password = value;
                  print(value);
                },
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Email Template",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
              child: TextField(
                controller: emailtempController,
                maxLines: 5,
                // obscureText: passobsucure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Email Template",
                ),
                onChanged: (value) {
                  emailtemplate = value;
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
    );
  }

  FinishPage() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 150,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Uploaded Successfully",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                color: Colors.orange,
                padding: EdgeInsets.all(10),
                child: Text(
                  "Go Back",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}


