import 'dart:async';

import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/assessment/assessment_data.dart';
import 'package:eduarno/repo/bloc/assessment/model/assessment_details.dart';
import 'package:eduarno/screens/assessment/assesment_listing.dart';
import 'package:eduarno/screens/assessment/quiz_result.dart';
import 'package:eduarno/widgets/bottom_app_bar.dart';
import 'package:eduarno/widgets/overlays/overlay.dart';
import 'package:eduarno/widgets/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radio_button_form_field/radio_button_form_field.dart';

class Quiz extends StatefulWidget {
  final String timer;
  // final String id;
  final int noOfQuestions;
  final AssessmentDetailsResponse details;

  const Quiz(
      {Key key,
      @required this.timer,
      // this.id,
      this.noOfQuestions,
      this.details})
      : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> with SingleTickerProviderStateMixin {
  int tabLength = 0;
  TabController _tabController;
  List<QuestionBody> questions;
  String timeToDisplay = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.noOfQuestions, vsync: this);
    _startTimer();
    // assesment.assessment = details.assessment;
    //Api Calls
  }

  //Working Properly (Issue Timer Not getting cancelled state leak)
  Timer _timer;
  int _counter = 0;
  int timeForTimer = 0;
  void _startTimer() {
    _counter = int.parse(widget.timer);
    timeForTimer = _counter * 60;
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        if (timeForTimer < 1) {
          t.cancel();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => QuizResult()));
          timeToDisplay = '';
        } else if (timeForTimer < 60) {
          timeToDisplay = timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
        } else if (timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60 * m);
          timeToDisplay = m.toString() + ':' + s.toString();
          timeForTimer = timeForTimer - 1;
        } else {
          timeForTimer = timeForTimer - 1;
        }
        //timeToDisplay = timeForTimer.toString();
      });
    });
  }

//Working
  void toggleTab() {
    tabLength = _tabController.index + 1;
    _tabController.animateTo(tabLength);
  }

//Working
  void togglePrevious() {
    tabLength = _tabController.index - 1;
    _tabController.animateTo(tabLength);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    _tabController.dispose();
  }

  // List<Map> mcqList = AssessmentProvider().my_questions[index].mcq;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AssessmentProvider()
              .myQuestions
              .isNotEmpty //If the first section is empty it will not load.....
          ? getBody()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  //Function to map mcq questions to each question..
  List<Map<String, dynamic>> getData2({int index}) {
    List<Map<String, dynamic>> mcqElement = [];
    List<dynamic> mcqList = AssessmentProvider().myQuestions[index].mcq;
    for (var i = 0; i < mcqList.length; i++) {
      mcqElement.add({
        'isanswer': AssessmentProvider().myQuestions[index].mcq[i]['isanswer'],
        'answer': AssessmentProvider().myQuestions[index].mcq[i]['answer'],
        // 'isSelected': AssessmentProvider().myQuestions[index].mcq[i]
        //     ['isSelected'],
        'isSelected': false,
        'value': i
      });
    }
    return mcqElement;
  }

  // void _showOverlay(BuildContext context, {int index}) {
  //   Navigator.of(context)
  //       .push(TutorialOverlay(widget.details, togglePrevious, index));
  // }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    // _showOverlay(context, index: 0);
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: List.generate(widget.noOfQuestions, (index) {
        return QuestionBody(
          size: size,
          questionImage: '',
          index: index,
          onNext: () => toggleTab(),
          onPrevious: () => togglePrevious(),
          data2: AssessmentProvider()
                          .myQuestions[index]
                          .questionType
                          .toLowerCase() ==
                      'choice' ||
                  AssessmentProvider()
                          .myQuestions[index]
                          .questionType
                          .toLowerCase() ==
                      'response'
              ? getData2(index: index)
              : null,
          assessmentResponse: widget.details,
          totalNoOfQuestions: widget.noOfQuestions,
          timeTodisplay: timeToDisplay,
          // questionResponse: quizScreenAssessment,
        );
      }),
    );
  }
}

class QuestionBody extends StatefulWidget {
  // final AssessmentResultBody assessment;
  // final QuestionAssessmentResultBody questionResponse;
  final String timeTodisplay;
  final AssessmentDetailsResponse assessmentResponse;
  final int totalNoOfQuestions;
  final Size size;
  final List<Map> data2;
  final List responseLabel;
  final List responseValue;
  final void Function() onNext;
  final void Function() onPrevious;
  final int index;
  final String questionImage;
  const QuestionBody({
    Key key,
    @required this.size,
    this.questionImage,
    this.index,
    this.onNext,
    this.onPrevious,
    this.data2,
    this.responseLabel,
    this.responseValue,
    this.totalNoOfQuestions,
    this.assessmentResponse,
    this.timeTodisplay,
    // this.questionResponse,
  }) : super(key: key);

  @override
  _QuestionBodyState createState() => _QuestionBodyState();
}

List<Map<String, dynamic>> sectionS = [
  {'sectionId': ''},
];

class _QuestionBodyState extends State<QuestionBody> {
  AssessmentProvider userInstance = AssessmentProvider();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.assessmentResponse.sections[0].sectionTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(widget.assessmentResponse.sections[0].sectionInstruction),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                onPressed: () {
                  widget.onPrevious();
                  Navigator.of(context).pop();
                },
                child: Text('Go back'))
          ],
        );
      },
    );
  }

  Future<void> _showDiscardDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              // semanticContainer: false,
              height: 220,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      // child: Text(
                      //   "Discard Assessment ?\n If you discard now you will loose assessment?",
                      //   style: TextStyle(
                      //       fontSize: 16,
                      //       color: Color(0xff303030),
                      //       fontWeight: FontWeight.w700),
                      //   textAlign: TextAlign.center,
                      // ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Discard Assessment\n',
                            style: TextStyle(
                                color: kChatColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'If you discard now you will loose assessment?',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ]),
                      ),
                    ),
                    //SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: 110,
                            //flex: 1,
                            child: TextButton(
                              // style: ButtonStyle(
                              //     shape: MaterialStateProperty.all(
                              //       RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(50.0),
                              //       ),
                              //     ),
                              //     backgroundColor:
                              //         MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        // MyBottomBar(
                                        //   isSignup: true,
                                        // ),
                                        QuizResult(
                                      isDiscard: true,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Discard',
                                style: TextStyle(color: Colors.red),
                              ),
                            )),
                        SizedBox(
                            width: 110,
                            //flex: 1,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff41C36C))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Continue'),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showOverlay(BuildContext context, {int index}) {
    Navigator.of(context).push(
        TutorialOverlay(widget.assessmentResponse, widget.onPrevious, index));
  }

  TextEditingController _typeinanswer = TextEditingController();
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  // bool _ans = false;
  List<bool> isCheckboxSelected = [];

  Set _saved = Set();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showDiscardDialog(),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.index != 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40, left: 24),
                child: TextButton(
                    onPressed: () {
                      userInstance.removeQuestions();
                      // userInstance.resultQuestions
                      //     .remove(userInstance.myQuestions.last);
                      return widget.onPrevious();
                    },
                    child: Text(
                      'Previous',
                      style: TextStyle(color: Color(0xff41C36C), fontSize: 16),
                    )),
              ),
            ),
            if (widget.index == widget.totalNoOfQuestions - 1) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, right: 24),
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 5, horizontal: 25)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff41C36C))),
                    onPressed: () {
                      if (myFormKey.currentState.validate()) {
                        myFormKey.currentState.save();
                        userInstance.addresultQuestions(
                            userInstance.myQuestions[widget.index]);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => QuizResult(
                                      isDiscard: false,
                                    )));
                      }
                    },
                    child: Text(
                      'Submit',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )),
              )
            ],
            if (widget.index != widget.totalNoOfQuestions - 1) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, right: 24),
                child: Container(
                  // height: 56,
                  // width: 149,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 25)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff41C36C))),
                      onPressed: () {
                        if (myFormKey.currentState.validate()) {
                          print(AssessmentProvider().sectionZeroQuestions);
                          print('index-------------> ${widget.index + 1}');
                          if ((AssessmentProvider().sectionZeroQuestions ==
                                  widget.index + 1) &&
                              AssessmentProvider().sectionOneQuestions > 1) {
                            // _showMyDialog();
                            _showOverlay(context, index: 1);
                          } else if ((AssessmentProvider()
                                      .sectionOneQuestions ==
                                  widget.index + 1) &&
                              (AssessmentProvider().sectionTwoQuestions > 1)) {
                            // _showMyDialog();
                            _showOverlay(context, index: 2);
                          }
                        }
                        if (myFormKey.currentState.validate()) {
                          myFormKey.currentState.save();
                          userInstance.addresultQuestions(
                              userInstance.myQuestions[widget.index]);
                          print(
                              'Question check ${AssessmentProvider().myQuestions}');
                          // widget.onNext();
                          widget.onNext();
                        }
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                ),
              ),
            ]
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: kLightGray),
          elevation: 0,
          title: Text(
            // "$_counter",
            'Question ${(widget.index + 1)}/${widget.totalNoOfQuestions}',
            style: TextStyle(
              fontSize: 18.0,
              color: Color(0xff303030),
              // fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(
                Icons.timer,
                size: 16,
                color: Color(0xff41C36C),
              ),
            ),
            Container(
              width: 70,
              child: Center(
                child: Text(
                  widget.timeTodisplay + ' min',
                  style: TextStyle(color: Color(0xff41C36C)),
                ),
              ),
            ),
          ],
          leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: kPrimaryGreenColor,
                // size: 24,
              ),
              onPressed: () => {
                    _showDiscardDialog()
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (_) => AssessmentDetail())),
                  }),
        ),
        body: ListView(
          children: [
            // Image.asset(
            //   "assets/base.png",
            //   width: widget.size.width,
            //   fit: BoxFit.cover,
            // ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 24, right: 24),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      AssessmentProvider().myQuestions[widget.index].question,
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xff303030)),
                    ),
                  ),
                ),
              ],
            ),
            if (AssessmentProvider()
                    .myQuestions[widget.index]
                    .questionType
                    .toLowerCase() ==
                'choice') ...[
              Form(
                key: myFormKey,
                child: RadioButtonFormField(
                  focusColor: Colors.green,
                  titleStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff303030)),
                  tileColor: Colors.black,
                  activeColor: Color(0xff41C36C),
                  selectedTileColor: Color(0xff41C36C),
                  padding: const EdgeInsets.only(top: 20),
                  toggleable: true,
                  data: widget.data2,
                  // data: AssessmentProvider().myQuestions[widget.index].mcq,
                  // AssessmentProvider().my_questions[widget.index].mcq,
                  value: 'value',
                  display: 'answer',
                  context: context,
                  onSaved: (value) {
                    if (value == null) {
                      // ShowToast.show("enter");
                    } else {
                      setState(() {
                        var newVal = value;
                        print('Value ---------->${newVal.toString()}');
                        final newValue = !widget.data2[newVal]['isSelected'];
                        widget.data2[value]['isSelected'] = newValue;
                        AssessmentProvider()
                            .myQuestions[widget.index]
                            .mcq[value]['isSelected'] = newValue;
                      });
                    }
                    // Provider.of<AssessmentProvider>(context)
                    //     .myQuestions[widget.index]
                    //     .mcq[value]['isSelected'] = true;
                  },
                ),
              ),
            ],
            if (AssessmentProvider()
                    .myQuestions[widget.index]
                    .questionType
                    .toLowerCase() ==
                'answer') ...[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: myFormKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter an answer';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Color(0xffF5F5F5),
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF6F7FA), width: 0)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.red, width: 0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                      labelText: '',
                      labelStyle: TextStyle(
                          color: Color(0xff9D9FA0),
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      hintText: 'Type your answer here',
                      hintStyle: TextStyle(
                          color: Color(0xff9D9FA0),
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    controller: _typeinanswer,
                    onSaved: (value) {
                      String text = value;
                      AssessmentProvider().myQuestions[widget.index].mcq = text;
                    },
                  ),
                ),
              )
            ],
            if (AssessmentProvider()
                    .myQuestions[widget.index]
                    .questionType
                    .toLowerCase() ==
                'response') ...[
              // Padding(
              //   padding: const EdgeInsets.only(right: 110, top: 24),
              //   child: Container(
              //     // height: 192,
              //     // width: 93,
              //     child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: CustomCheckBoxGroup(
              //         height: 36,
              //         enableShape: true,
              //         customShape: RoundedRectangleBorder(
              //             side: BorderSide(color: Color(0xff41C36C)),
              //             borderRadius: BorderRadius.circular(10)),
              //         buttonTextStyle: ButtonTextStyle(
              //           selectedColor: Colors.white,
              //           unSelectedColor: Color(0xff303030),
              //           textStyle: TextStyle(
              //             fontSize: 16,
              //           ),
              //         ),
              //         unSelectedColor: Theme.of(context).canvasColor,
              //         buttonLables: widget.responseLabel,
              //         buttonValuesList: widget.responseValue,
              //         checkBoxButtonValues: (values) {
              //           print(values);
              //         },
              //         // spacing: 0,
              //         // defaultSelected: "Monday",
              //         horizontal: true,
              //         enableButtonWrap: false,
              //         // autoWidth: false,
              //         // width: 100,
              //         absoluteZeroSpacing: false,
              //         selectedColor: Color(0xff41C36C),
              //         padding: 10,
              //       ),
              //     ),
              //   ),
              // )
              Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Form(
                      key: myFormKey,
                      child: Container(
                        height: 250,
                        child: ListView.builder(
                          itemCount: widget.data2.length,
                          itemBuilder: (context, index) {
                            isCheckboxSelected.add(false);

                            final item = widget.data2[index];

                            var title = item['answer'];

                            return ListTile(
                              leading: Checkbox(
                                  activeColor: AppColors.primaryColor,
                                  value: isCheckboxSelected[index],
                                  onChanged: (value) {
                                    setState(() {
                                      isCheckboxSelected[index] = value;
                                      AssessmentProvider()
                                          .myQuestions[widget.index]
                                          .mcq[index]['isSelected'] = value;
                                    });
                                  }),
                              title: Text(title),
                            );
                          },
                        ),
                      )

                      // List.generate(widget.data2.length, (value) {
                      //   // bool _ans = false;
                      //   return buildCheckBox(
                      //       text: widget.data2[value]['answer'],
                      //       value: value,
                      //       groupValue: widget.data2[value]['isSelected'],
                      //       onClicked: () {
                      //         setState(() {
                      //           final newValue =
                      //               !widget.data2[value]['isSelected'];
                      //           widget.data2[value]['isSelected'] = newValue;
                      //           AssessmentProvider()
                      //               .myQuestions[widget.index]
                      //               .mcq[value]['isSelected'] = true;
                      //         });
                      //       });
                      // }),
                      )),
            ],
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCheckBox(
          {String text, int value, bool groupValue, VoidCallback onClicked}) =>
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          selectedTileColor: Color(0xff41C36C),
          // tileColor: Color(0xff303030),
          onTap: onClicked,
          leading: Checkbox(
            activeColor: Color(0xff41C36C),
            value: groupValue,
            onChanged: (value) => onClicked(),
          ),
          title: Text(text),
        ),
      );
}
