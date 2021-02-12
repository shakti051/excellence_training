import 'dart:convert';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/event/model/EventCategoryModel.dart';
import 'package:eklavayam/screens/home/HomeDrawerBottomScreen.dart';
import 'package:eklavayam/screens/onetimeinfo/model/LanguageModel.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class WriterToolScreen extends StatefulWidget {
  @override
  _WriterToolScreenState createState() => _WriterToolScreenState();
}

class _WriterToolScreenState extends State<WriterToolScreen>  {
 final GlobalKey<HtmlEditorState> keyEditor = GlobalKey<HtmlEditorState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // final txt = await keyEditor.currentState.getText();
  String name, image, mobile, token;
  int uniqueId;
  String sdate = "";

  int currentIndex = 0;
  bool pshow = false;
  bool nshow = true;
  String ntext = "Next";

  List<EventCategoryData> eventCategoryList;
  EventCategoryData selectedEventCategory;

  List<LanguageData> languagelist;
  LanguageData selectedLanguage;

  TextEditingController titleController;
  String title = "";

  Future<void> getLanguageList() async {
    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.getApiCall(getLanguageUrl);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      LanguageModel languageModel = new LanguageModel.fromJson(responsedata);
      setState(() {
        languagelist = languageModel.data;
      });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['msg']);
    //print(responsedata['status']);
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

  Future<void> createPostCall() async {
    String content = await keyEditor.currentState.getText();
    debugPrint("content>>  " + content);

    var jsonstring = {
      "userId": 290,
      "content": content,
      "title": title,
      "publishedOn": sdate,
      "language": selectedLanguage.uniqueId,
      "category": selectedEventCategory,
      "tags": "tags",
      "tagPeople": "tag people",
      "fullName": "fname",
      "contentType": 1
    };
    var jsondata = jsonEncode(jsonstring);
  //  print(jsondata);

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
    super.initState();
    titleController = TextEditingController();
    restoreSF();
    Future.delayed(Duration.zero, () => getEventCategoryCall());
    Future.delayed(Duration.zero, () => getLanguageList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: bluecolor,
        title: Text(
          "Writer Tool",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          MyStepperWidget(currentIndex: currentIndex),

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

          Expanded(child: SingleChildScrollView(child: getBodyWidget())),

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
                        print("Selected language"+ selectedLanguage.uniqueId.toString());
                        print("Selected Event Category "+selectedEventCategory.toString());
                            });
                          }
                          if (currentIndex == 1) {
                            setState(() {
                              pshow = true;
                              nshow = true;
                              ntext = "Next";
                              print("The Title is "+title);
                              print("Selected date is "+sdate);
                            });
                          }
                          if (currentIndex == 2) {
                            setState(() {
                              pshow = true;
                              nshow = true;
                              ntext = "Create Event";
                            });
                            //createPostCall();
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
                            if (currentIndex == 3) {
                              createPostCall();
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
        return 'Language & Interest';
      case 1:
        return 'Post';

      case 2:
        return 'Writer Tool';

      case 3:
        return 'Finish';

      default:
        return 'Unknown';
    }
  }

  getBodyWidget() {
    if (currentIndex == 0) return langANDinterestPage();
    if (currentIndex == 1) return postPage();
    if (currentIndex == 2) return writerTool();
    if (currentIndex == 3) return FinishPage();
  }

  langANDinterestPage() {
    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Language",
                textAlign: TextAlign.left,
                style: TextStyle(color: bluecolor, fontSize: 18),
              ),
              languagelist != null
                  ? Container(
                      padding: EdgeInsets.only(right: 5, top: 5, bottom: 0),
                      child: DropdownButtonFormField<LanguageData>(
                        isExpanded: true,
                        hint: Text("Select Language"),
                        value: selectedLanguage,
                        validator: (arg) {
                          if (arg == null)
                            return 'Please select Language';
                          else
                            return null;
                        },
                        onChanged: (LanguageData Value) {
//
                          setState(() {
                            selectedLanguage = Value;
                         //   print("The selected language "+selectedLanguage.toString());
                          });
                        },
                        items: languagelist.map((LanguageData user) {
                          return DropdownMenuItem<LanguageData>(
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
                height: 10,
              ),
              Text(
                "Event Category",
                textAlign: TextAlign.left,
                style: TextStyle(color: bluecolor, fontSize: 18),
              ),
              eventCategoryList != null
                  ? Container(
                      padding: EdgeInsets.only(right: 5, top: 5, bottom: 0),
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
                           // print("The selected cagegory is"+selectedEventCategory.toString());
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
                height: 10,
              ),
            ]));
  }

  postPage() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Title",
            textAlign: TextAlign.left,
            style: TextStyle(color: bluecolor, fontSize: 18),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[500]))),
              child: TextField(
                maxLines: 1,
                controller: titleController,
// obscureText: passobsucure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Title",
                ),
                onChanged: (value) {
                  title = value;
                  //print("The Title is "+title);

// this.phoneNo=value;
// password = value;
               //   print(value);
                },
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Date",
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
              sdate = getTimeStampWithDate(val);
              //print("Selected date is "+val);
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
        ],
      ),
    );
  }

  writerTool() {
    return Container(
      padding: EdgeInsets.all(15),
      //
      child: Expanded(
        child: HtmlEditor(
          hint: "Your text here...",
          showBottomToolbar: true,

          // decoration: BoxDecoration(
          //   color: Colors.red
          // ),
          //value: "text content initial, if any",
          key: keyEditor,
          height: MediaQuery.of(context).size.height-100,
        ),
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeDrawerBottomScreen()));
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

class MyStepperWidget extends StatelessWidget {
  const MyStepperWidget({
    Key key,
    @required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10, bottom: 10),
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
          // GestureDetector(
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //     child: Icon(
          //       Icons.arrow_back_ios,
          //       color: Colors.white,
          //     )),
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
    );
  }
}

class BasicDateTimeField extends StatelessWidget {
  Function fun;

  BasicDateTimeField({this.fun});

  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // Text('Basic date & time field (${format.pattern})'),
      DateTimeField(
        onChanged: fun,
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}