import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo//utils/validator.dart';
import 'package:eduarno/repo/bloc/auth/login.dart';
import 'package:eduarno/screens/auth/create_password.dart';
import 'package:eduarno/screens/auth/otp.dart';
import 'package:eduarno/screens/auth/sign_up.dart';
import 'package:eduarno/widgets/custom_button.dart';
import 'package:eduarno/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  final bool isUpdate;
  final String emailUpdate;
  const ForgotPassword({Key key, this.isUpdate = false, this.emailUpdate})
      : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.isUpdate
        ? _userNameController.text = widget.emailUpdate
        : _userNameController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Center(
                    child: Container(
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
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32, left: 24),
                      child: Text(
                        "Forgot password",
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
                      padding:
                          const EdgeInsets.only(top: 4, left: 24, bottom: 15),
                      child: Text(
                        "Please enter the email that you used for\ncreating your account.",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8C8C8C)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomTextField(
                    textInputType: TextInputType.emailAddress,
                    isRequired: true,
                    title: "",
                    label: 'Email',
                    val: "Email",
                    hint: "Email",
                    controller: _userNameController,
                    validator: (value) =>
                        Validators.validateEmail(value.trim()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: Button(
                      isLoading: _isLoading,
                      formKey: _formKey,
                      title: "Get OTP",
                      bgColor: kPrimaryColor,
                      textColor: Colors.white,
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            _isLoading = true;
                          });
                          AuthProvider.forgotPassword(
                                  _userNameController.text.trim())
                              .then((value) {
                            setState(() {
                              _isLoading = false;
                            });

                            if (value)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Otp(
                                            email:
                                                _userNameController.text.trim(),
                                          )));
                          });
                        }

                        // print(
                        //     'UserName - ${_userNameController.text.trim()}');
                      },
                    ),
                  ),
                ),
                // TextButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => CreatePassword()));
                //     },
                //     child: Text("Forgot password")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New to Eduarno? ',
                        style: TextStyle(
                            color: Color(0xff9D9FA0),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Poppins'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Color(0xff41C36C),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// backgroundColor: kBlueColor,
// resizeToAvoidBottomInset: false,
// // appBar: AppBar(
// //   backgroundColor: Color(0xff2C34DB),
// //   backwardsCompatibility: false,
// //   systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: kBlueColor),
// //   elevation: 0,
// //   title: Text(
// //     "Forgot password",
// //     style: TextStyle(fontSize: 25.0),
// //   ),
// //   centerTitle: true,
// //   leading: IconButton(
// //     icon: Icon(Icons.keyboard_backspace, color: Colors.white),
// //     onPressed: () => Navigator.pushReplacement(
// //         context, MaterialPageRoute(builder: (_) => SignIn())),
// //   ),
// // ),
// body: Container(
//   constraints: BoxConstraints.expand(),
//   decoration: BoxDecoration(
//       image: DecorationImage(
//           image: AssetImage("assets/bg_image.jpeg"),
//           fit: BoxFit.cover)),
//   child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
//     child: Form(
//       key: _formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 140,
//           ),
//           Text(
//             'Forgot password',
//             style: TextStyle(
//                 color: kPrimaryColor,
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.w800),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Container(
//             child: Column(
//               children: [
//                 CustomTextField(
//                   title: "Email",
//                   hint: 'johndeo@gmail.com',
//                   titleColor: kSubHeadingColor,
//                   textColor: kTitleColor,
//                   controller: _userNameController,
//                   validator: (value) =>
//                       Validators.validateEmail(value.trim()),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20,),
//           //Footer
//           Container(
//             child: Column(
//               children: [
//                 Button(
//                   isLoading: _isLoading,
//                   formKey: _formKey,
//                   title: "Send OTP",
//                   bgColor: kPrimaryColor,
//                   textColor: Colors.white,
//                   onTap: () {
//                     if (_formKey.currentState.validate()) {
//                       FocusScope.of(context).unfocus();
//                       setState(() {
//                         _isLoading = true;
//                       });
//                       AuthProvider.forgotPassword(
//                               _userNameController.text.trim())
//                           .then((value) {
//                         setState(() {
//                           _isLoading = false;
//                         });

//                         if (value)
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) => Otp(
//                                         email: _userNameController.text
//                                             .trim(),
//                                       )));
//                       });
//                     }

//                     print(
//                         'UserName - ${_userNameController.text.trim()}');
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 Center(
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       text: 'New to Eduarno? ',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: 'MontserratAlternates'),
//                       children: [
//                         TextSpan(
//                           text: "Sign up",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => SignUp()));
//                             },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   ),
// )
