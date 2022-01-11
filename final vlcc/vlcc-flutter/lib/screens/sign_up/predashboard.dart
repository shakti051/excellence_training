import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/bottom_bar/bottom_bar.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class PreDashboard extends StatefulWidget {
  const PreDashboard({Key? key}) : super(key: key);

  @override
  State<PreDashboard> createState() => _PreDashboardState();
}

class _PreDashboardState extends State<PreDashboard> {
  final VlccShared _vlccSharedPrefs = VlccShared();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 8),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.all(PaddingSize.small),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.backBorder),
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.keyboard_backspace,
                            size: 24,
                          )),
                    ),
                  ),
                  SizedBox(height: 80),
                  Center(
                      child: SvgPicture.asset("assets/images/shopping.svg",
                          cacheColorFilter: true)),
                  SizedBox(height: 50),
                  Text(
                    "Hi ${_vlccSharedPrefs.name}",
                    style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.heading),
                  ),
                  SizedBox(height: 20),
                  Text(
                    """Welcome to VLCC. Our new journey starts here.\n Let’s keep you healthy and beautiful.""",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        fontSize: FontSize.normal),
                  ),
                  SizedBox(height: 60),
                  GradientButton(
                      child: Text(
                        "Take me to my Dashboard",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.large,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ConsumerBottomBar(
                              selectedPage: 0,
                            ),
                          ),
                          (route) => false,
                        );
                      }),
                  SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
