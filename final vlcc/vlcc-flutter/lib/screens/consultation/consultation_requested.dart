import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/consultation/approve_consultation.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class ConsultationRequested extends StatelessWidget {
  const ConsultationRequested({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                SvgPicture.asset(SVGAsset.appointment, fit: BoxFit.cover),
                SizedBox(height: 56),
                Text("Consultation Requested",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.extraLarge)),
                SizedBox(height: 16),
                Text('Your consultation request has been sent to',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        fontSize: FontSize.large)),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Safe health clinic",
                        style: TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                    Text(" for ",
                        style: TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400)),
                    Text("Dermatalogy",
                        style: TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("On",
                        style: TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400)),
                    Text(" Aug 24,2021",
                        style: TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                    Text(" at ",
                        style: TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400)),
                    Text("09:45 am",
                        style: TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(height: 32),
                GradientButton(
                    child: Text(
                      "Go to Dashboard",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.large,
                          color: Colors.white),
                    ),
                    onPressed: () {}),
                SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ApproveConsultation()),
                    );
                  },
                  child: Text("View upcoming consultations",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.large)),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
