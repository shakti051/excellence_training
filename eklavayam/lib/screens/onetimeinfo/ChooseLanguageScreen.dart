import 'dart:convert';
import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/onetimeinfo/ChooseInterestCategoryScreen.dart';
import 'package:eklavayam/screens/onetimeinfo/model/LanguageModel.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';

class ChooseLanguageScreen extends StatefulWidget {
  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  int selectedCount = 0;
  NetworkClient networkClient, networkClientAdd;
  List<LanguageData> languagelist;

  Future<void> getLanguageList() async {
    showAlertDialog(context);
    networkClient = new NetworkClient();
    var responsedata = await networkClient.getApiCall(getLanguageUrl);

    //print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      LanguageModel languageModel = new LanguageModel.fromJson(responsedata);

      setState(() {
        languagelist = languageModel.data;
      });
    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['msg']);
    //print(responsedata['status']);
  }

  // Future<void> savefoodChatList(var data) async {
  //   //showAlertDialog(context);
  //   NetworkClient networkClient = new NetworkClient();
  //   var responsedata = await networkClient.postData('save_userInfo',data);
  //   //Navigator.pop(context);
  //   print("saveinfo>");
  //   print(responsedata);
  //   // SchedulerBinding.instance.addPostFrameCallback((_) {
  //   //
  //   //   Navigator.pop(context);
  //   // });
  //   if (responsedata['status'] == 1) {
  //     styledToast(context,"Data Saved Successfully");
  //
  //   }
  //
  //
  //   //     netquestionansModel = new QuestionansModel.fromJson(responsedata);
  //   //     questionansModel.food.addAll(netquestionansModel.food);
  //   //     setState(() {
  //   //       questionansModel.food.add(new Fooditem(
  //   //           id: "no", question: "Thankyou", qtype: 0, option: null));
  //   //     });
  //   //   } else
  //   //     styledToast(context, responsedata['msg']);
  //   //   //print(responsedata['status']);
  // }

  Future<void> addLangugeCall() async {
    networkClientAdd = new NetworkClient();
    var addedLanguage = await networkClientAdd.getApiCall(getAddedLanguageUrl);

    var jsonstring = {"addedLanguage": addedLanguage};
    var jsondata = jsonEncode(jsonstring);
      print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(loginUrl, jsondata);
    // print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      // LoginModel loginModel=LoginModel.fromJson(responsedata);
      // print(loginModel.status);
      // showSnakbarWithGlobalKey(_scaffoldKey, "Validiate");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChooseInterestCategoryScreen()));
    } else
      showSnakbarWithGlobalKey(_scafoldKey, responsedata['error']);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => getLanguageList());
  }

  // List<String> gridlist=["अ Hindi","A English","ਏ Punjabi","अ Marathi","A Asomiya","ক Bengali","a	Urdu","Tamil","Telugu","Sanskrit"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scafoldKey,
        backgroundColor: bluecolor,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Text(
                "Choose Language",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: whitecolor),
              ),
            ),
            Expanded(
              child: languagelist != null
                  ? Container(
                      padding: EdgeInsets.only(top: 50.0),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2.2, crossAxisCount: 2),
                        shrinkWrap: true,
                        itemCount: languagelist.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            // selectedCount == 0;

                            setState(() {
                              languagelist[index].isSelected =
                                  !languagelist[index].isSelected;

                              if (languagelist[index].isSelected)
                                selectedCount++;
                              else
                                selectedCount--;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.grey, width: 2),
                              color: languagelist[index].isSelected
                                  ? orangecolor
                                  : whitecolor,
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    languagelist[index].isSelected
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.center,
                                children: [
                                  //Container(width: 20,),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                        child: Text(
                                      languagelist[index].termText,
                                      style: TextStyle(
                                          color: languagelist[index].isSelected
                                              ? whitecolor
                                              : orangecolor,
                                          fontSize: 18),
                                    )),
                                  ),
                                  languagelist[index].isSelected
                                      ? Container(
                                          margin: EdgeInsets.all(7),
                                          // color: Colors.cyan.withAlpha(60),
                                          child: Center(
                                              child: Icon(
                                            Icons.check_circle,
                                            size: 25,
                                            color: whitecolor,
                                          )),
                                        )
                                      : Container()
                                ],
                              ),
                            ), //just for testing, will fill with image later
                          ),
                        ),
                      ))
                  : Container(),
            ),
            GestureDetector(
              onTap: () {
                if (selectedCount > 0) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChooseInterestCategoryScreen()));
                } else
                  showSnakbarWithGlobalKey(
                      _scafoldKey, "Selecte atleast one languge");

                // _sendToServer();
                // continuebtn();
                // onLoginBtn();
              },
              child: Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7), color: orangecolor),
                child: Center(
                  child: Text(
                    "CONTINUE (" + selectedCount.toString() + ")",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

Add_Josn() {
  var obj = '{ "name":"John", "age":30, "city":"New York"}';
  var convert = json.decode(obj);
}
