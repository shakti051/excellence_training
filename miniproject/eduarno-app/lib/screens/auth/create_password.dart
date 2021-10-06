import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/auth/login.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/repo/utils/validator.dart';
import 'package:eduarno/screens/assessment/assesment_listing.dart';
import 'package:eduarno/screens/auth/sign_in.dart';
import 'package:eduarno/widgets/custom_button.dart';
import 'package:eduarno/widgets/custom_text_field.dart';
import 'package:eduarno/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'forgot_password.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({Key key}) : super(key: key);

  @override
  _CreatePasswordState createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
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
                          "Reset password",
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
                        padding: const EdgeInsets.only(top: 4, left: 24),
                        child: Text(
                          "Let’s create a new password for your\naccount.",
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        CustomPasswordTextField(
                          validator: (value) =>
                              Validators.validatePassword(value.trim()),
                          isRequired: true,
                          title: "",
                          label: 'New password',
                          hint: "New password",
                          // val: "password",
                          // obscureText: true,
                          controller: _passwordController,
                        ),
                        CustomPasswordTextField(
                          validator: (value) =>
                              Validators.validatePassword(value.trim()),
                          hintColor: Colors.black,
                          titleColor: Colors.black,
                          hint: "Confirm password",
                          controller: _confirmPasswordController,
                          title: '',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 28),
                    child: Container(
                      // margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Button(
                              isLoading: _isLoading,
                              formKey: _formKey,
                              title: "Change password",
                              bgColor: kPrimaryColor,
                              textColor: Colors.white,
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  FocusScope.of(context).unfocus();
                                  // setState(() {
                                  //   _isLoading = false;
                                  // });
                                  if (_confirmPasswordController.text ==
                                      _passwordController.text.trim()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    AuthProvider.createPassword(User().userId,
                                            _confirmPasswordController.text)
                                        .then((value) {
                                      if (value)
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => SignIn()));
                                    });
                                  } else {
                                    ShowToast.show('Passwords do not match!');
                                  }
                                }

                                print(
                                    'Password - ${_passwordController.text.trim()}, Confirm Password - ${_confirmPasswordController.text.trim()}');
                                // Navigator.pushReplacement(context,
                                //     MaterialPageRoute(builder: (_) => SignIn()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Back to",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Color(0xff303030)),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: Text(
                          " Sign in",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              color: Color(0xff41C36C)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// resizeToAvoidBottomInset: false,
// // appBar: AppBar(
// //   backgroundColor: Color(0xff2C34DB),
// //   backwardsCompatibility: false,
// //   systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: kBlueColor),
// //   elevation: 0,
// //   title: Text(
// //     "Create Password",
// //     style: TextStyle(fontSize: 25.0),
// //   ),
// //   centerTitle: true,
// //   leading: IconButton(
// //     icon: Icon(Icons.keyboard_backspace, color: Colors.white),
// //     onPressed: () => Navigator.pushReplacement(
// //         context, MaterialPageRoute(builder: (_) => ForgotPassword())),
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
//             "Create Password",
//             style: TextStyle(
//                 color: kPrimaryColor,
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.w800),
//           ),
//           Container(
//             child: Column(
//               children: [
//                 CustomPasswordTextField(
//                   title: "Password ",
//                   hint: '********',
//                   titleColor: kSubHeadingColor,
//                   controller: _passwordController,
//                   obscureText: true,
//                   validator: (value) =>
//                       Validators.validatePassword(value.trim()),
//                 ),
//                 // SizedBox(height: 10.0),
//                 CustomPasswordTextField(
//                   title: "Confirm Password ",
//                   hint: '********',
//                   titleColor: kSubHeadingColor,
//                   controller: _confirmPasswordController,
//                   obscureText: true,
//                   validator: (value) =>
//                       Validators.validatePassword(value.trim()),
//                 ),
//                 // SizedBox(height: 10),
//               ],
//             ),
//           ),
//           //Footer
//           SizedBox(height: 20,),
//           Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Button(
//                   isLoading: _isLoading,
//                   formKey: _formKey,
//                   title: "Continue",
//                   bgColor: kPrimaryColor,
//                   textColor: Colors.white,
//                   onTap: () {
//                     if (_formKey.currentState.validate()) {
//                       FocusScope.of(context).unfocus();
//                       setState(() {
//                         _isLoading = true;
//                       });
//                       if (_confirmPasswordController.text ==
//                           _passwordController.text.trim()) {
//                         AuthProvider.createPassword(User().userId,
//                                 _confirmPasswordController.text)
//                             .then((value) {
//                           setState(() {
//                             _isLoading = false;
//                           });

//                           if (value)
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => SignIn()));
//                         });
//                       } else {
//                         ShowToast.show('Passwords are not same!');
//                       }
//                     }

//                     print(
//                         'Password - ${_passwordController.text.trim()}, Confirm Password - ${_confirmPasswordController.text.trim()}');
//                     // Navigator.pushReplacement(context,
//                     //     MaterialPageRoute(builder: (_) => SignIn()));
//                   },
//                 ),
//                 SizedBox(height: 10),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   ),
// )
