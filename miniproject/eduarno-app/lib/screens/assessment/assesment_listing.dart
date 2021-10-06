import 'package:eduarno/repo/bloc/assessment/assessment_data.dart';
import 'package:eduarno/repo/bloc/assessment/assessment_list_service.dart';
import 'package:eduarno/repo/bloc/assessment/interest_service.dart';
import 'package:eduarno/repo/bloc/assessment/model/assessment_item.dart';
import 'package:eduarno/repo/bloc/assessment/model/interest_mode.dart';
import 'package:eduarno/repo/bloc/assessment/model/specilization_model.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/screens/assessment/NoAssessmentFound.dart';
import 'package:eduarno/screens/assessment/assessment_detail.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Utilities/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AssessmentListing extends StatefulWidget {
  final bool isNewUser;
  final String specialization;
  final List<Map<String, dynamic>> topicList;
  final VoidCallback openDrawer;

  AssessmentListing(
      {Key key,
      this.specialization,
      this.topicList,
      this.openDrawer,
      this.isNewUser = false})
      : super(key: key);

  @override
  _AssessmentListingState createState() => _AssessmentListingState();
}

class _AssessmentListingState extends State<AssessmentListing> {
  AssessmentListService api = AssessmentListService();
  AssessmentItem assessmentItem;
  AllSpecialisation allSpecialisation;
  InterestService apiInterest = InterestService();
  InterestModel interestModel;
  List specialiazionList;
  bool testInfo = false;
  int testArray;

  // Future<AllSpecialisation> getAllSpecilasation() async {
  //   var api = "https://eduarno1.herokuapp.com/get_specialisations";
  //   var data = await http.get(Uri.parse(api));
  //   allSpecialisation = AllSpecialisation.fromJson(json.decode(data.body));
  //   return allSpecialisation;
  // }

  // _getInterestList() async {
  //   var interest = await apiInterest.getInterest();
  //   setState(() {
  //     interestModel = interest;
  //   });
  //   return interest;
  // }

  Future<AssessmentItem> _getTestList() async {
    var testList = await api.getTest();
    // setState(() {
    // });
    assessmentItem = testList;
    return testList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        'Get interest added bool value ----->>> at assessment listing ${User().interestAdded}');
    print(
        'Get new user bool value ----->>> at assessment listing${User().isNewUser}');
    print('Get name bool value ----->>> at assessment listing${User().name}');
    print(
        'Get assessment taken value ----->>> at assessment listing${User().isAssessment}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          backwardsCompatibility: true,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          elevation: .6,
          title: Text(
            "Assessment",
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.black,
              // fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: widget.isNewUser
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(CupertinoIcons.back),
                  color: kChatColor,
                )
              : IconButton(
                  icon: Icon(Icons.menu_open, color: Color(0xff303030)),
                  onPressed: widget.openDrawer,
                ),
          actions: [
            // IconButton(
            //   icon: Image.asset("assets/filter.png", color: Color(0xff303030)),
            //   onPressed: () => ShowToast.show("Filter"),
            // ),
          ],
        ),
        body: FutureBuilder(
            future: _getTestList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                int assessementItemLength = assessmentItem.data?.length ?? 0;
                if (assessementItemLength != 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 0),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                              itemCount: assessementItemLength,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AssessmentDetail(
                                                  api: api,
                                                  assessmentItem:
                                                      assessmentItem,
                                                  index: index,
                                                )));
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.red,
                                    margin: EdgeInsets.fromLTRB(16, 6, 15, 6),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 250,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: assessmentItem
                                                                .data[index]
                                                                .imgUrl ==
                                                            null ||
                                                        assessmentItem
                                                                .data[index]
                                                                .imgUrl ==
                                                            ""
                                                    ? AssetImage(
                                                        "assets/assessment_default_image.png")
                                                    : NetworkImage(
                                                        assessmentItem
                                                            .data[index]
                                                            .imgUrl),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 250,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                gradient: LinearGradient(
                                                    begin: FractionalOffset
                                                        .topCenter,
                                                    end: FractionalOffset
                                                        .bottomCenter,
                                                    colors: [
                                                      Colors.grey
                                                          .withOpacity(0.0),
                                                      Colors.black
                                                          .withOpacity(0.8),
                                                    ],
                                                    stops: [
                                                      0.0,
                                                      1.0
                                                    ])),
                                          ),
                                          Positioned(
                                              top: 16,
                                              left: 16,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 12, right: 12),
                                                height: 32,
                                                decoration: BoxDecoration(
                                                    color: AppColors.orange,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Center(
                                                  child: Text(
                                                    assessmentItem.data[index]
                                                        .specialisation,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              )),
                                          Positioned(
                                              bottom: 90,
                                              left: 16,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 8, right: 8),
                                                height: 24,
                                                decoration: BoxDecoration(
                                                    color: AppColors.tosqa,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                child: Center(
                                                  child: Text(
                                                    "level " +
                                                        assessmentItem
                                                            .data[index].level,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              )),
                                          Positioned(
                                              bottom: 90,
                                              left: 80,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 8, right: 8),
                                                height: 24,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                child: Center(
                                                  child: Text(
                                                    assessmentItem
                                                        .data[index].topic,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              )),
                                          Positioned(
                                              bottom: 90,
                                              right: 16,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    assessmentItem.data[index]
                                                            .totalTimeQuestions +
                                                        " min",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              )),
                                          Positioned(
                                              left: 16,
                                              bottom: 30,
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  margin:
                                                      EdgeInsets.only(left: 4),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          assessmentItem
                                                              .data[index]
                                                              .testName,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800))))),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                } else {
                  return NoAssessmentFound(
                    message: 'No asessments found',
                  );
                }
              }
              return MyShimmer();
            }));
  }
}
