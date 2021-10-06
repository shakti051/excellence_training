import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/profile/interest_detail_data.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/screens/profile/add_specilisation.dart';
import 'package:eduarno/screens/profile/interest_screen.dart';
import 'package:flutter/material.dart';

class NoAssessmentFound extends StatefulWidget {
  final String message;
  final VoidCallback callback;

  const NoAssessmentFound(
      {Key key, this.message = 'No data found', this.callback})
      : super(key: key);

  @override
  _NoAssessmentFound createState() => _NoAssessmentFound();
}

class _NoAssessmentFound extends State<NoAssessmentFound> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              child: Image.asset(
                'assets/no_data_found.png',
                height: 200,
                width: 500,
              ),
            ),
          ),
          Center(
              child: Text(
            widget.message,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          SizedBox(height: 48),
          // Center(
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return InterestScreen();
          //       }));
          //     },
          //     child: Container(
          //       height: 40,
          //       width: 240,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(30),
          //         color: AppColors.primaryColor,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             Icons.add,
          //             color: Colors.white,
          //           ),
          //           Text(
          //             "Add new specialisation",
          //             style: TextStyle(
          //                 fontFamily: "Poppins",
          //                 fontSize: 16,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.w500),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
