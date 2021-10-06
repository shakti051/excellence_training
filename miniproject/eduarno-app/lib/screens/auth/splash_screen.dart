import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/screens/assessment/assesment_listing.dart';
import 'package:eduarno/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: Provider.of<User>(context).name != null
            ? AssessmentListing()
            : SignIn(),
        image: Image.asset('assets/eduarno_logo.png'),
        backgroundColor: Colors.white,
        photoSize: 300.0,
        loaderColor: Colors.white);
  }
}
