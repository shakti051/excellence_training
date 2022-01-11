import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/bottom_bar/bottom_bar.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class AppointmentRequested extends StatefulWidget {
  final String serviceName;
  final String centerName;
  final String date;
  final String time;
  final bool willConsultPrice;
  const AppointmentRequested(
      {Key? key,
      required this.date,
      required this.time,
      required this.serviceName,
      required this.centerName,
      this.willConsultPrice = false})
      : super(key: key);

  @override
  State<AppointmentRequested> createState() => _AppointmentRequestedState();
}

class _AppointmentRequestedState extends State<AppointmentRequested> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSize.extraLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  Stack(
                    children: [
                      Lottie.asset(
                        PNGAsset.lottieAnimation,
                        repeat: true,
                        frameRate: FrameRate.max,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),

                  // SizedBox(height: 56),
                  Text("Appointment Requested",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.extraLarge)),
                  SizedBox(height: 16),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Your appointment request has been sent to ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            fontSize: FontSize.defaultFont),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.centerName,
                            style: TextStyle(
                                fontSize: FontSize.large,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' for '),
                          TextSpan(
                            text: widget.serviceName,
                            style: TextStyle(
                                fontSize: FontSize.large,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '\n On '),
                          TextSpan(
                            text: widget.date,
                            style: TextStyle(
                                fontSize: FontSize.large,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' at '),
                          TextSpan(
                            text: widget.time,
                            style: TextStyle(
                                fontSize: FontSize.large,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: widget.willConsultPrice
                                ? '\n\nOur team will further provide assistance on pricing details for the ${widget.serviceName}.'
                                : '',
                            style: TextStyle(
                                fontSize: FontSize.large,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
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
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConsumerBottomBar(
                                      selectedPage: 2,
                                    )),
                            (route) => false);
                      }),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
