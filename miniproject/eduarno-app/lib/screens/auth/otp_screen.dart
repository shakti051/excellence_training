// import 'package:eduarno/constants.dart';
// import 'package:eduarno/repo//bloc/user.dart';
// import 'package:eduarno/repo/bloc/auth/login.dart';
// import 'package:eduarno/screens/assessment/filtering_screen.dart';
// import 'package:eduarno/screens/auth/create_password.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/services.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:pinput/pin_put/pin_put.dart';
// import 'package:provider/provider.dart';

// class OTP extends StatefulWidget {
//   final bool isSignUp;
//   final String email;

//   const OTP({Key key, this.isSignUp = false, this.email}) : super(key: key);

//   @override
//   _OTPState createState() => _OTPState();
// }

// class _OTPState extends State<OTP> {
//   final TextEditingController _pinPutController = TextEditingController();
//   final FocusNode _pinPutFocusNode = FocusNode();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;

//   BoxDecoration get _pinPutDecoration {
//     return BoxDecoration(
//       color: Colors.white.withOpacity(0.8),
//       border: Border(bottom: BorderSide(color: Colors.white60)),
//       borderRadius: BorderRadius.circular(10),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // backgroundColor: kBlueColor,

//         // resizeToAvoidBottomInset: false,
//         backgroundColor: Color(0xff2442E2),
//         appBar: AppBar(
//           backgroundColor: Color(0xff2C34DB),
//           backwardsCompatibility: false,
//           systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: kBlueColor),
//           elevation: 0,
//           title: Text(
//             "OTP",
//             style: TextStyle(fontSize: 25.0),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(Icons.keyboard_backspace, color: Colors.white),
//             onPressed: () => Navigator.of(context).pop(),
//             // Navigator.pushReplacement(
//             // context, MaterialPageRoute(builder: (_) => ForgotPassword())),
//           ),
//         ),
//         body: Container(
//           // constraints: BoxConstraints.expand(),
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("assets/Eduarno_bg.png"),
//                   fit: BoxFit.cover)),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ///message
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           'To continue with the process, please check your email for the one time passcode. If you don\'t receive the OTP in 5 minutes, please check you spam folder',
//                           textAlign: TextAlign.center,
//                           maxLines: 5,
//                           style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300),
//                         ),
//                       ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.center,
//                       //   children: [
//                       //     Expanded(
//                       //       flex: 3,
//                       //       child: Text(
//                       //         '${widget.email}',
//                       //         textAlign: TextAlign.center,
//                       //         style: TextStyle(
//                       //             color: Colors.white70,
//                       //             fontSize: 16,
//                       //             fontWeight: FontWeight.w300),
//                       //       ),
//                       //     ),
//                       //     Expanded(
//                       //       child: Align(
//                       //         alignment: Alignment.centerLeft,
//                       //         child: Padding(
//                       //           padding: const EdgeInsets.only(bottom: 12.0),
//                       //           child: InkWell(
//                       //             onTap: () {
//                       //               Navigator.pop(context);
//                       //             },
//                       //             child: Padding(
//                       //               padding: const EdgeInsets.only(top: 20.0),
//                       //               child: Icon(
//                       //                 Icons.edit,
//                       //                 size: 18.0,
//                       //                 color: Colors.white,
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     )
//                       //   ],
//                       // ),
//                       SizedBox(
//                         height: 10,
//                       ),

//                       ///pin
//                       // Padding(
//                       //   padding: const EdgeInsets.all(8.0),
//                       //   child: _pin(),
//                       // ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: OTPTextField(
//                           length: 4,
//                           width: MediaQuery.of(context).size.width,
//                           textFieldAlignment: MainAxisAlignment.spaceAround,
//                           fieldWidth: 55,
//                           otpFieldStyle: OtpFieldStyle(
//                               enabledBorderColor: Colors.white,
//                               borderColor: Colors.white,
//                               focusBorderColor: Colors.white),
//                           fieldStyle: FieldStyle.underline,
//                           style: TextStyle(fontSize: 25, color: Colors.white),
//                           onChanged: (pin) {
//                             print("Changed: " + pin);
//                           },
//                           onCompleted: (pin) {
//                             print("Completed: " + pin);
//                             AuthProvider.verifyOtp(
//                                     pin,
//                                     Provider.of<User>(context, listen: false)
//                                         .userId)
//                                 .then((value) {
//                               setState(() {
//                                 _isLoading = false;
//                               });
//                               if (value) if (widget.isSignUp) {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => Filtering()));
//                               } else {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => CreatePassword()));
//                               }
//                             });
//                           },
//                         ),
//                       ),
//                       // SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             TextButton(
//                               style: TextButton.styleFrom(
//                                 textStyle: TextStyle(
//                                     fontSize: 14,
//                                     decoration: TextDecoration.underline),
//                               ),
//                               onPressed: () {
//                                 resendOTP(widget.email);
//                               },
//                               child: Text(
//                                 'Resend',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //Footer
//                 // Container(
//                 //   child: Column(
//                 //     children: [
//                 //       Button(
//                 //         isLoading: _isLoading,
//                 //         formKey: _formKey,
//                 //         title: "Continue",
//                 //         onTap: () {
//                 //           if (_formKey.currentState.validate()) {
//                 //             print('OTP - ${_pinPutController.text.trim()}');
//                 //             setState(() {
//                 //               _isLoading = true;
//                 //             });
//                 //             AuthProvider.verifyOtp(
//                 //                     _pinPutController.text.trim(),
//                 //                     Provider.of<User>(context, listen: false)
//                 //                         .userId)
//                 //                 .then((value) {
//                 //               setState(() {
//                 //                 _isLoading = false;
//                 //               });
//                 //               if (value) if (widget.isSignUp) {
//                 //                 Navigator.pushReplacement(
//                 //                     context,
//                 //                     MaterialPageRoute(
//                 //                         builder: (_) => Filtering()));
//                 //               } else {
//                 //                 Navigator.pushReplacement(
//                 //                     context,
//                 //                     MaterialPageRoute(
//                 //                         builder: (_) => CreatePassword()));
//                 //               }
//                 //             });
//                 //           }
//                 //         },
//                 //       ),
//                 //       SizedBox(height: 10),
//                 //       // Center(
//                 //       //   child: RichText(
//                 //       //     textAlign: TextAlign.center,
//                 //       //     text: TextSpan(
//                 //       //       text: 'New to Eduarno?  ',
//                 //       //       style: TextStyle(
//                 //       //           color: Colors.white,
//                 //       //           fontWeight: FontWeight.w400,
//                 //       //           fontFamily: 'MontserratAlternates'),
//                 //       //       children: [
//                 //       //         TextSpan(
//                 //       //           text: "SIGN UP",
//                 //       //           style: TextStyle(
//                 //       //             color: Colors.white,
//                 //       //             fontWeight: FontWeight.w400,
//                 //       //             fontSize: 14,
//                 //       //           ),
//                 //       //           recognizer: TapGestureRecognizer()
//                 //       //             ..onTap = () {
//                 //       //               Navigator.pushReplacement(
//                 //       //                   context,
//                 //       //                   MaterialPageRoute(
//                 //       //                       builder: (_) => SignUp()));
//                 //       //             },
//                 //       //         ),
//                 //       //       ],
//                 //       //     ),
//                 //       //   ),
//                 //       // ),
//                 //     ],
//                 //   ),
//                 // )
//               ],
//             ),
//           ),
//         ));
//   }

//   resendOTP(String email) {
//     AuthProvider.forgotPassword(email).then((value) {
//       print('OTP Sent Successfully!');
//     });
//   }

//   Widget _pin() {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 20),
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: Form(
//         key: _formKey,
//         child: PinPut(
//           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//           fieldsCount: 4,
//           validator: (value) => (value == null || _pinPutController.text == '')
//               ? '\n\nPlease enter valid OTP'
//               : null,
//           focusNode: _pinPutFocusNode,
//           controller: _pinPutController,
//           eachFieldHeight: 62,
//           eachFieldWidth: 50,
//           submittedFieldDecoration: _pinPutDecoration.copyWith(
//             // color: Colors.white,
//             // border: Border.all(color: Colors.red),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           selectedFieldDecoration: _pinPutDecoration,
//           followingFieldDecoration: _pinPutDecoration,
//           textStyle: TextStyle(
//             // color: kBlueColor,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 26,
//           ),
//           // followingFieldDecoration: _pinPutDecoration.copyWith(
//           //   borderRadius: BorderRadius.circular(10),
//           //   color: kOrangeColor.withOpacity(0.2),
//           //   border: Border.all(
//           //     color: kOrangeColor.withOpacity(.5),
//           //   ),
//           // ),
//         ),
//       ),
//     );
//   }

//   Widget _pinField() {
//     return OTPTextField(
//       length: 4,
//       width: MediaQuery.of(context).size.width,
//       textFieldAlignment: MainAxisAlignment.spaceAround,
//       fieldWidth: 55,
//       fieldStyle: FieldStyle.box,
//       outlineBorderRadius: 15,
//       style: TextStyle(fontSize: 17),
//       onChanged: (pin) {
//         print("Changed: " + pin);
//       },
//       onCompleted: (pin) {
//         print("Completed: " + pin);
//       },
//     );
//   }
// }
