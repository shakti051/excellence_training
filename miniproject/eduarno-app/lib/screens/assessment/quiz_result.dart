import 'package:eduarno/repo/bloc/assessment/assessment_data.dart';
import 'package:eduarno/repo/bloc/profile/model/assessment_result.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/Utilities/routes.dart';
import 'package:eduarno/screens/assessment/fail_ovelay.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/material.dart';

class QuizResult extends StatefulWidget {
  // final QuestionAssessmentResultBody quizResult;
  final bool isDiscard;
  const QuizResult({
    Key key,
    this.isDiscard = false,
    // @required this.quizResult,
  }) : super(key: key);

  @override
  _QuizResultState createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  AssessmentResultResponse _result;
  bool apiHit = false;
  @override
  void initState() {
    super.initState();
    AssessmentProvider().getAssessmentResult(isDiscard: widget.isDiscard).then(
      (result) {
        setState(() {
          _result = result;
          apiHit = true;
          print(
              'Get interest added bool value ----->>> at quiz result ${User().interestAdded}');
          print(
              'Get new user bool value ----->>> at quiz result${User().isNewUser}');
          print('Get name bool value ----->>> at quiz result${User().name}');
          print(
              'Get assessment taken value ----->>> at quiz result${User().isAssessment}');
        });
      },
    );
  }

  void _showFailOverlay(BuildContext context) {
    Navigator.of(context).push(FailOverlay());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                onPressed: () {
                  if (_result.data.first.result == 'Pass') {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => MyBottomBar()));
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.bottomNav, (route) => false);
                  } else {
                    if (User().isAssessment == true) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.bottomNav, (route) => false);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.signUpInterest, (route) => false);
                    }
                    // _showFailOverlay(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff41C36C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // <-- Radius
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )),
          ),
        ),
        backgroundColor: Colors.white,
        body: apiHit
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Image.asset(
                        _result.data.first.result == 'Pass'
                            ? 'assets/party_emo.png'
                            : 'assets/sad_emo.png',
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    // Image.asset(
                    //   'assets/resultcup.png',
                    //   height: 300,
                    //   width: MediaQuery.of(context).size.width,
                    //   fit: BoxFit.fill,
                    // ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      _result.data.first.result == 'Pass'
                          ? 'Congratulations'
                          : 'Better luck next time',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff303030),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _result.data.first.correctQuestions.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 33,
                              color: Color(0xffFCD034)),
                        ),
                        Text(
                          '/${_result.data.first.totalQuestions}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        _result.data.first.result == 'Pass'
                            ? 'You have successfully completed this assessment.'
                            : 'You have not passed this assessment please try again after 3 months',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff303030),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 21,
                    ),

                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            : MyShimmer(),
      ),
    );
  }
}
