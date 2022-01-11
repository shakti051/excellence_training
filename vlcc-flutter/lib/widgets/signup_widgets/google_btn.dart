import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/screens/bottom_bar/bottom_bar.dart';

class GoogleBtn extends StatefulWidget {
  const GoogleBtn({Key? key}) : super(key: key);

  @override
  _GoogleBtnState createState() => _GoogleBtnState();
}

class _GoogleBtnState extends State<GoogleBtn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          var userData = await _googleSignIn.signIn();
          var _ = await userData!.authentication;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConsumerBottomBar(
                      selectedPage: 0,
                    )),
          );
        } catch (e) {
          log('', name: 'google error', error: e);
        }
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 15,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(SVGAsset.google),
              ),
              SizedBox(width: 8),
              Text(
                "Google",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
