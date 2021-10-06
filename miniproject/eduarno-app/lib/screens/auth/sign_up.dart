import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/auth/login.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/repo/utils/validator.dart';
import 'package:eduarno/screens/auth/otp.dart';
import 'package:eduarno/screens/auth/sign_in.dart';
import 'package:eduarno/screens/cms/privacy_policy.dart';
import 'package:eduarno/screens/profile/t&c.dart';
import 'package:eduarno/widgets/custom_button.dart';
import 'package:eduarno/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // bool policyCheck = false;
  bool _isLoading = false;
  bool _isFilled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        'Get interest added bool value ----->>> at signup ${User().interestAdded}');
    print('Get new user bool value ----->>> at signup${User().isNewUser}');
    print('Get name bool value ----->>> at signup${User().name}');
    print(
        'Get assessment taken value ----->>> at signup${User().isAssessment}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        // autovalidate: _isFilled,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 62,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                'assets/eduarno_logo.png',
                              ),
                              fit: BoxFit.fill,
                            )),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24, top: 32),
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 4),
                          child: Text(
                            "Let’s create your account",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff8C8C8C),
                                fontFamily: "Poppins"),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              CustomTextField(
                                validator: (value) =>
                                    Validators.validateName(value, 'Name'),
                                isRequired: true,
                                textInputType: TextInputType.name,
                                title: "",
                                hint: 'Full name',
                                controller: _userNameController,
                                label: 'Full name',
                              ),
                              CustomTextField(
                                validator: (value) =>
                                    Validators.validateEmail(value.trim()),
                                isRequired: true,
                                textInputType: TextInputType.emailAddress,
                                title: "",
                                val: "Email",
                                hint: "Email",
                                controller: _userEmailController,
                                label: 'Email',
                              ),
                              CustomPasswordTextField(
                                validator: (value) =>
                                    Validators.validatePassword(value),
                                hintColor: Colors.black,
                                titleColor: Colors.black,
                                textInputType: TextInputType.visiblePassword,
                                hint: "Xyz@1234",
                                controller: _passwordController,
                                title: '',
                                label: "Password",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Button(
                                  isLoading: _isLoading,
                                  formKey: _formKey,
                                  title: "Sign up",
                                  bgColor: kPrimaryColor,
                                  textColor: Colors.white,
                                  onTap: () {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      AuthProvider.signUp(
                                              _userNameController.text.trim(),
                                              _userEmailController.text.trim(),
                                              _passwordController.text.trim(),
                                              context)
                                          .then((value) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        if (value) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  // SignIn(
                                                  //       isSignup: true,
                                                  //       emailAdress:
                                                  //           _userEmailController
                                                  //               .text,
                                                  //     )
                                                  Otp(
                                                isSignUp: true,
                                                email: _userEmailController.text
                                                    .trim(),
                                              ),
                                            ),
                                          );
                                        }
                                      });
                                    } else {
                                      setState(() {
                                        _isFilled = true;
                                      });
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Already have an account?  ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff9D9FA0),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign in",
                              style: TextStyle(
                                color: Color(0xff41C36C),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignIn()));
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "By signing up you accept the",
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
                                      builder: (context) =>
                                          TermsandCondition()));
                            },
                            child: Text(
                              " Terms of Service",
                              style: TextStyle(
                                  color: Color(0xff41C36C),
                                  fontSize: 14,
                                  fontFamily: "Poppins"),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "and  ",
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
                              "Privacy policy",
                              style: TextStyle(
                                color: Color(0xff41C36C),
                                fontFamily: "Poppins",
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
        ),
      ),
    );
  }
}
