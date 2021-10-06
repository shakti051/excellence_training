import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/assessment/assessment_data.dart';
import 'package:eduarno/repo/bloc/assessment/model/assessment_details.dart';
import 'package:eduarno/screens/assessment/quiz_screen.dart';
import 'package:eduarno/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TutorialOverlay extends ModalRoute<void> {
  final AssessmentDetailsResponse _assessmentResponse;
  final void Function() onPrevious;
  final int index;
  final String timer;
  // final int noOfQuestions;
  final bool isFirst;
  int noOfQuestions = (AssessmentProvider().myQuestions.length);

  TutorialOverlay(
    this._assessmentResponse,
    this.onPrevious,
    this.index, {
    this.isFirst = false,
    this.timer,
  });
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.white;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context, _assessmentResponse, onPrevious),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context,
      AssessmentDetailsResponse response, void Function() onPrevious) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Flexible(
                  child: Text(
                    response.sections[index].sectionTitle,
                    style: TextStyle(
                        color: Color(0xff303030),
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff4DC9D1)),
                      ),
                      child: Text(
                        response.sections[index].sectionQuestionLevel,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "Instructions",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text(
            //     response.sections[index].sectionInstruction,
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Html(data: response.sections[index].sectionInstruction),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.back,
                      color: Colors.black,
                      size: 18,
                    ),
                    TextButton(
                        onPressed: () {
                          onPrevious();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Go back",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ), //fdsdf
                ElevatedButton(
                    onPressed: () {
                      isFirst
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Quiz(
                                        noOfQuestions: noOfQuestions,
                                        timer: timer,
                                        // id: assessmentItem.data[index].sId,
                                        details: _assessmentResponse,
                                      )))
                          : Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kPrimaryGreenColor),
                    ),
                    child: Text("Approve")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
