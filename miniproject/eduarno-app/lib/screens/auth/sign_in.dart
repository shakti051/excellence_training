import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo//utils/validator.dart';
import 'package:eduarno/repo/bloc/auth/login.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/Utilities/routes.dart';
import 'package:eduarno/screens/assessment/assesment_listing.dart';
import 'package:eduarno/screens/auth/otp.dart';
import 'package:eduarno/screens/auth/sign_up.dart';
import 'package:eduarno/widgets/bottom_app_bar.dart';
import 'package:eduarno/widgets/custom_button.dart';
import 'package:eduarno/widgets/custom_text_field.dart';
import 'package:eduarno/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  final emailAdress;
  final bool isSignup;
  const SignIn({Key key, this.emailAdress, this.isSignup = false})
      : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isFilled = false;
  // String title;

  @override
  void dispose() {
    _userEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.isSignup) {
      _userEmailController.text = widget.emailAdress;
    }
    print(
        'Get interest added bool value ----->>> at signin ${User().interestAdded}');
    print('Get new user bool value ----->>> at signin${User().isNewUser}');
    print('Get name bool value ----->>> at signin${User().name}');
    print(
        'Get assessment taken value ----->>> at signin${User().isAssessment}');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _isFilled,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: ListView(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                    ),
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
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 32,
                      left: 24,
                    ),
                    child: Text(
                      "Welcome back",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 24),
                    child: Text(
                      "Sign in to your account",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8C8C8C)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 24, right: 24),
                    child: Container(
                      child: Column(
                        children: [
                          CustomTextField(
                            // validator: ,
                            val: "Email",
                            isRequired: true,
                            textInputType: TextInputType.emailAddress,
                            title: "",
                            label: 'Email',
                            hint: "Email",
                            controller: _userEmailController,
                            validator: (value) =>
                                Validators.validateEmail(value.trim()),
                          ),
                          CustomPasswordTextField(
                            hintColor: Colors.black,
                            titleColor: Colors.black,
                            hint: "Password",
                            textInputType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            title: '',
                            label: "Password",
                            validator: (value) =>
                                Validators.validatePassword(value.trim()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 25),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ForgotPassword()));
                                  },
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                        color: Color(0xff41C36C),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Container(
                      // margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Button(
                              isLoading: _isLoading,
                              formKey: _formKey,
                              title: "Sign in",
                              bgColor: kPrimaryColor,
                              textColor: Colors.white,
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  AuthProvider.signIn(
                                          _userEmailController.text.trim(),
                                          _passwordController.text.trim(),
                                          context)
                                      .then(
                                    (value) {
                                      setState(() {
                                        User().email =
                                            _userEmailController.text.trim();
                                        _isLoading = false;
                                      });

                                      switch (value) {
                                        case 200:
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              MyBottomBar()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                          break;
                                        case 202:
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              Routes.signUpInterest,
                                              (Route<dynamic> route) => false);
                                          break;
                                        case 201:
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Otp()),
                                              (Route<dynamic> route) => false);
                                          break;
                                        case 203:
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              Routes.signUpInterest,
                                              (Route<dynamic> route) => false);
                                          break;
                                        default:
                                          ShowToast.show(
                                              'Something Went wrong');
                                      }

                                      // if (value) {
                                      //   Navigator.of(context)
                                      //       .pushAndRemoveUntil(
                                      //           MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   MyBottomBar()),
                                      //           (Route<dynamic> route) =>
                                      //               false);
                                      // }
                                    },
                                  );
                                  // } else if (User().isVerifiedOtp == true &&
                                  //     User().interestAdded == false) {
                                  //   Navigator.pushReplacementNamed(
                                  //       context, Routes.interestPage);
                                  // } else if (User().isVerifiedOtp == false) {
                                  //   Navigator.pushReplacementNamed(
                                  //       context, Routes.welcomePage);
                                  // } else {
                                  //   setState(() {
                                  //     _isFilled = true;
                                  //   });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'New to Eduarno?  ',
                          style: TextStyle(
                              color: Color(0xff9D9FA0),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontFamily: 'Poppins'),
                          children: [
                            TextSpan(
                              text: "Sign up",
                              style: TextStyle(
                                color: Color(0xff41C36C),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()),
                                      (Route<dynamic> route) => false);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // Container(
    //   decoration: BoxDecoration(
    //       image: DecorationImage(
    //           image: AssetImage("assets/bg_image.jpeg"),
    //           fit: BoxFit.cover)),
    //   child:
    // ));
  }
}
// resizeToAvoidBottomInset: false,
// // backgroundColor: Color(0xff2aaf56),
// body: Stack(
//   children: [
// Container(
//   height: MediaQuery.of(context).size.height,
//   width: MediaQuery.of(context).size.width,
//   decoration: BoxDecoration(
//       image: DecorationImage(
//           image: AssetImage('assets/bg_image.jpeg'),
//           fit: BoxFit.cover)),
// ),
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
//       // padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
//       child: Form(
//         key: _formKey,
//         autovalidate: _isFilled,
//         child: ListView(
//           // mainAxisAlignment: MainAxisAlignment.start,
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 100,
//             ),
//             Text(
//               "Sign in",
//               style: TextStyle(
//                   color: kPrimaryColor,
//                   fontSize: 30.0,
//                   fontWeight: FontWeight.w800),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(
//               "Welcome back",
//               style: TextStyle(
//                   color: kSubHeadingColor,
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Container(
//               child: Column(
//                 children: [
//                   CustomTextField(
//                     title: "Email",
//                     hint: 'johndeo@gmail.com',
//                     titleColor: kSubHeadingColor,
//                     textColor: kTitleColor,
//                     controller: _userEmailController,
//                     validator: (value) =>
//                         Validators.validateEmail(value.trim()),
//                   ),
//                   // SizedBox(height: 10.0),
//                   CustomPasswordTextField(
//                     title: "Password ",
//                     hint: '********',
//                     titleColor: kSubHeadingColor,
//                     controller: _passwordController,
//                     obscureText: true,
//                     validator: (value) =>
//                         Validators.validatePassword(value.trim()),
//                   ),
//                   // SizedBox(height: 10),
//                   // Container(
//                   //   width: MediaQuery.of(context).size.width,
//                   //   child: Align(
//                   //     alignment: Alignment.topRight,
//                   //     child: TextButton(
//                   //       style: TextButton.styleFrom(
//                   //         textStyle: TextStyle(
//                   //             fontSize: 14,
//                   //             decoration: TextDecoration.underline),
//                   //       ),
//                   //       onPressed: () {
//                   //         Navigator.pushReplacement(
//                   //             context,
//                   //             MaterialPageRoute(
//                   //                 builder: (_) => ForgotPassword()));
//                   //       },
//                   //       child: Text(
//                   //         'Forgot password?',
//                   //         style: TextStyle(color: Colors.black),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             //Footer
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Button(
//                       isLoading: _isLoading,
//                       formKey: _formKey,
//                       title: "Sign in",
//                       bgColor: kPrimaryColor,
//                       textColor: Colors.white,
//                       onTap: () {
//                         if (_formKey.currentState.validate()) {
//                           FocusScope.of(context).unfocus();
//                           setState(() {
//                             _isLoading = true;
//                           });
//                           AuthProvider.signIn(
//                                   _userEmailController.text.trim(),
//                                   _passwordController.text.trim(),
//                                   context)
//                               .then((value) {
//                             setState(() {
//                               _isLoading = false;
//                             });

//                             if (value)
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) =>
//                                           AssessmentListing()));
//                           });
//                         } else {
//                           setState(() {
//                             _isFilled = true;
//                           });
//                         }
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       child: Align(
//                         alignment: Alignment.topRight,
//                         child: TextButton(
//                           style: TextButton.styleFrom(
//                             textStyle: TextStyle(
//                               fontSize: 14,
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => ForgotPassword()));
//                           },
//                           child: Text(
//                             'Forgot password?',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Center(
//                   //   child: RichText(
//                   //     textAlign: TextAlign.center,
//                   //     text: TextSpan(
//                   //       text: 'New to Eduarno?  ',
//                   //       style: TextStyle(
//                   //           color: Colors.black,
//                   //           fontWeight: FontWeight.w300,
//                   //           fontFamily: 'MontserratAlternates'),
//                   //       children: [
//                   //         TextSpan(
//                   //           text: "Sign up",
//                   //           style: TextStyle(
//                   //             color: Colors.black,
//                   //             fontWeight: FontWeight.bold,
//                   //             fontSize: 14,
//                   //           ),
//                   //           recognizer: TapGestureRecognizer()
//                   //             ..onTap = () {
//                   //               Navigator.pushReplacement(
//                   //                   context,
//                   //                   MaterialPageRoute(
//                   //                       builder: (_) => SignUp()));
//                   //             },
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             // Expanded(
//             //   child:
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'New Member?',
//                     style: TextStyle(
//                         color: kSubHeadingColor,
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (_) => SignUp()));
//                     },
//                     child: Text('Sign up',
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           color: kPrimaryColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         )),
//                   ),
//                   SizedBox(
//                     height: 29,
//                   )
//                 ],
//               ),
//               // RichText(
//               //   textAlign: TextAlign.center,
//               //   text: TextSpan(
//               //     text: 'New to Eduarno?  ',
//               //     style: TextStyle(
//               //         color: Colors.black,
//               //         fontWeight: FontWeight.w300,
//               //         fontFamily: 'MontserratAlternates'),
//               //     children: [
//               //       TextSpan(
//               //         text: "\nSign up",
//               //         style: TextStyle(
//               //           color: Colors.black,
//               //           fontWeight: FontWeight.bold,
//               //           fontSize: 14,
//               //         ),
//               //         recognizer: TapGestureRecognizer()
//               //           ..onTap = () {
//               //             Navigator.pushReplacement(
//               //                 context,
//               //                 MaterialPageRoute(
//               //                     builder: (_) => SignUp()));
//               //           },
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ),
//             // ),
//           ],
//         ),
//       ),
//     ),
//   ],
// ),
