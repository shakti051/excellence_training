import 'package:eduarno/repo/bloc/assessment/assessment_data.dart';
import 'package:eduarno/repo/bloc/assessment/assessment_list_service.dart';
import 'package:eduarno/repo/bloc/assessment/model/assessment_item.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/screens/assessment/assesment_listing.dart';
import 'package:eduarno/screens/assessment/quiz_screen.dart';
import 'package:eduarno/widgets/bottom_app_bar.dart';
import 'package:eduarno/widgets/overlays/overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../Utilities/constants.dart';

class AssessmentDetail extends StatefulWidget {
  AssessmentListService api;
  AssessmentItem assessmentItem;
  int index;
  AssessmentDetail({this.api, this.assessmentItem, this.index});
  @override
  _AssessmentDetailState createState() => _AssessmentDetailState(
      api: api, assessmentItem: assessmentItem, index: index);
}

class _AssessmentDetailState extends State<AssessmentDetail> {
  bool liked = false;
  AssessmentListService api = AssessmentListService();
  AssessmentItem assessmentItem;
  int index;
  _AssessmentDetailState({this.api, this.assessmentItem, this.index});

  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool loading = true;
    return WillPopScope(
      onWillPop: () => User().isNewUser
          ? Future.value(true)
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => MyBottomBar(
                        isSignup: true,
                      ))),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          backwardsCompatibility: true,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          elevation: .6,
          title: Text("Assessment Details",
              style: TextStyle(
                fontSize: 22.0,
                // color: Colors.black,
                // fontWeight: FontWeight.w600,
              )),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left, color: kLightGreen),
            onPressed: () => {
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => MyBottomBar(
              //               isSignup: true,
              //             ))),
              Navigator.pop(context)
            },
          ),
          actions: [
            // IconButton(
            //   icon: Icon(
            //     liked ? Icons.favorite : Icons.favorite_border,
            //     color: liked ? Colors.green : kLightGreen,
            //   ),
            //   onPressed: _pressed,
            // )
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 56,
              child: ElevatedButton(
                  onPressed: () {
                    _pressed();
                    // setState(() {
                    //   liked = true;
                    // });
                    AssessmentProvider()
                        .getAssessment(id: assessmentItem.data[index].sId)
                        .then((assessmentDetailsResponseValue) {
                      setState(() {
                        // liked = true;

                        Navigator.of(context).push(TutorialOverlay(
                            assessmentDetailsResponseValue,
                            () => Navigator.pop(context),
                            0,
                            isFirst: true,
                            timer:
                                assessmentItem.data[index].totalTimeQuestions));
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => Quiz(
                        //               noOfQuestions: noOfQuestions,
                        //               timer: assessmentItem
                        //                   .data[index].totalTimeQuestions,
                        //               id: assessmentItem.data[index].sId,
                        //               details: assessmentDetailsResponseValue,
                        //             )));
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: btnGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: liked
                        ? Container(
                            height: 40,
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : Text(
                            "Start Test",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                  )),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    assessmentItem.data[index].imgUrl == null ||
                            assessmentItem.data[index].imgUrl == ""
                        ? Image.asset(
                            "assets/assessment_default_image.png",
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )
                        : Image.network(assessmentItem.data[index].imgUrl,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.grey.withOpacity(0.0),
                                Colors.black.withOpacity(0.8),
                              ],
                              stops: [
                                0.0,
                                1.0
                              ])),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 20,
                        child: Container(
                          padding: EdgeInsets.only(left: 4),
                          height: 30,
                          decoration: BoxDecoration(
                              color: lightOrange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          width: 100,
                          child: Center(
                            child: Text(
                              'Level  ' + assessmentItem.data[index].level,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),
                            ),
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Text(
                    assessmentItem.data[index].testName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: kChatColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 24, right: 15),
                    child: Row(children: [
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                          decoration: BoxDecoration(
                              color: lightGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(assessmentItem.data[index].topic,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500))),
                      SizedBox(width: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        decoration: BoxDecoration(
                            color: Color(0xff0082CD),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(assessmentItem.data[index].specialisation,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            )),
                      )
                    ])),
                SizedBox(
                  height: 10,
                ),
                //Question details
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/avatar.png",
                              width: 50, height: 70),
                          SizedBox(width: 8),
                          Text(
                              assessmentItem.data[index].totalMarks.toString() +
                                  " Marks",
                              style: TextStyle(
                                  color: lightOrange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'))
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                          Column(children: [
                            Container(
                                margin: EdgeInsets.only(right: 16),
                                child: Text(
                                    "Question : " +
                                        assessmentItem
                                            .data[index].numberOfQuestions,
                                    style: TextStyle(color: Colors.black54))),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.black54,
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                        assessmentItem.data[index]
                                                .totalTimeQuestions +
                                            " min",
                                        style:
                                            TextStyle(color: Colors.black54)))
                              ]),
                            )
                          ])
                        ]))
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 8, 8),
                  child: Text(
                    "General Instruction",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 8, 8),
                    child: Html(
                      data: assessmentItem.data[index].instruction == ''
                          ? "A computer is a machine that can be programmed to carry out sequences of arithmetic or logical operations automatically. Modern computers can perform generic sets of operations known as programs. These programs enable computers to perform a wide range of tasks."
                          : assessmentItem.data[index].instruction,
                    )
                    // Text(
                    //   assessmentItem.data[index].instruction == ''
                    //       ? "A computer is a machine that can be programmed to carry out sequences of arithmetic or logical operations automatically. Modern computers can perform generic sets of operations known as programs. These programs enable computers to perform a wide range of tasks."
                    //       : assessmentItem.data[index].instruction,
                    //   style: TextStyle(fontSize: 14, color: Colors.black54),
                    // ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
