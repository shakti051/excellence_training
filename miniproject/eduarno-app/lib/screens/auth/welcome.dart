import 'package:eduarno/repo/bloc/auth/login.dart';
import 'package:eduarno/screens/assessment/assesment_listing.dart';
import 'package:eduarno/screens/auth/sign_in.dart';
import 'package:eduarno/screens/auth/sign_up.dart';
import 'package:eduarno/screens/cms/privacy_policy.dart';
import 'package:eduarno/screens/profile/t&c.dart';
import 'package:eduarno/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isFilled = false;
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        'Browse the app',
                        style: TextStyle(
                            color: Color(0xff41C36C),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    height: 240,
                    // width: 600,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/welcome.png',
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.8),
                  child: Text(
                    'Welcome to Eduarno',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 10),
                  child: Text(
                    'Learn useful knowledge everyday',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff8C8C8C)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 25, right: 25),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Button(
                            isLoading: _isLoading,
                            // formKey: _formKey,
                            title: 'Create an account',
                            bgColor: kPrimaryColor,
                            textColor: Colors.white,
                            onTap: () {
                              print('Tapps');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 8),
                        child: Container(
                          height: 1,
                          width: 135,
                          color: Color(0xffC7C9D9),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          'or',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff8C8C8C)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: Container(
                          height: 1,
                          width: 135,
                          color: Color(0xffC7C9D9),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text(
                      'Sign in instead',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff41C36C)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 50, bottom: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By signing up you accept the',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xff8C8C8C),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsandCondition()));
                        },
                        child: Text(
                          ' Terms of Service',
                          style: TextStyle(
                              color: Color(0xff41C36C),
                              fontSize: 14,
                              fontFamily: 'Poppins'),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'and  ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xff8C8C8C),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrivacyPolicy()));
                        },
                        child: Text(
                          'Privacy policy',
                          style: TextStyle(
                            color: Color(0xff41C36C),
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
