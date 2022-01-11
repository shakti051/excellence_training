import 'dart:core';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/main.dart';
import 'package:vlcc/mixins/validation_mixin.dart';
import 'package:vlcc/models/signup_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/miscellaneous/privacy_policy.dart';
import 'package:vlcc/screens/miscellaneous/terms_condition.dart';
import 'package:vlcc/screens/sign_up/sign_up.dart';
import 'package:vlcc/screens/welcome_screen.dart';
import 'package:vlcc/services/signup_service.dart';
import 'package:vlcc/widgets/custom_loader.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with ValidationMixin {
  int? phoneNumberLength;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  SignupService api = SignupService();
  SignupModel? signupModel;
  bool _userRegistered = false;
  final formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';
  // final Services _services = Services();
  // OtpModel? _otpModel;
  // bool _loginSuccess = true;
  String? _sendOtp;
  bool emailValidate = false;
  bool loading = false;

  _registerUser() async {
    var registration = await api
        .getUserRegistered(
            name: (_nameController.text.split('')[0].toUpperCase() +
                    _nameController.text.substring(1))
                .trim(),
            mobile: _phoneController.text.trim(),
            email: _emailController.text.trim(),
            deviceID: Provider.of<VlccShared>(context, listen: false).deviceId)
        .then((value) {
      signupModel = value;
      if (signupModel!.status == 2000) {
        setState(() {
          loading = false;
          _userRegistered = false;
          _sendOtp = signupModel!.clientSignupInfo!.oTP;
          Fluttertoast.showToast(
              msg: "OTP ${_sendOtp!}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                    registerd: _userRegistered,
                    mobileNum: phone,
                    enterOtp: _sendOtp,
                    name: name)),
          );
        });
      }
      if (signupModel!.status == 2004) {
        Fluttertoast.showToast(
            msg: "User already registered",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          loading = false;
        });
      }
      if (signupModel!.status == 2003) {
        setState(() {
          loading = false;
          Fluttertoast.showToast(
              msg: "Technical issue try after some time",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    });
    return registration;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sharedPref = context.read<VlccShared>();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        margin: EdgeInsets.only(top: MarginSize.small),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelComeScreen()),
                      );
                    },
                    child: Container(
                        padding: const EdgeInsets.all(PaddingSize.small),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.keyboard_backspace,
                          size: 24,
                        )),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Welcome to VLCC!",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.heading),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelComeScreen()),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              color: AppColors.orangeDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 34),
                  Text(
                    "Name",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: FontSize.normal),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    // height: 50,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter name',
                        focusedBorder: OutlineInputBorder(
                            borderSide: _nameController.text.length >= 4
                                ? BorderSide(color: Colors.green)
                                : BorderSide(color: AppColors.orangeProfile),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      validator: (String? name) {
                        if (validateName(name!)) {
                          return null;
                        } else {
                          return 'Enter name';
                        }
                      },
                      onChanged: (text) {
                        setState(() {});
                      },
                      onSaved: (text) {
                        name = text!;
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Phone number",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: FontSize.normal),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    //height: 50,
                    child: TextFormField(
                      controller: _phoneController,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      maxLines: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        suffixIcon: Icon(
                            phoneNumberLength == 10
                                ? Icons.check_circle_outline
                                : null,
                            color:
                                phoneNumberLength == 10 ? Colors.green : null),
                        hintText: 'Enter phone number',
                        focusedBorder: OutlineInputBorder(
                            borderSide: phoneNumberLength == 10
                                ? BorderSide(color: Colors.green)
                                : BorderSide(color: AppColors.orange),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      validator: (String? mobNum) {
                        if (validateMobile(mobNum!)) {
                          return null;
                        } else {
                          return 'Enter number';
                        }
                      },
                      onChanged: (text) {
                        setState(() {
                          phoneNumberLength = text.length;
                        });
                      },
                      onSaved: (text) {
                        phone = text!;
                        Provider.of<VlccShared>(context, listen: false)
                            .setMobileNum(phone);
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Email (Optional)",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: FontSize.normal),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    child: TextFormField(
                      controller: _emailController,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter email address',
                        focusedBorder: OutlineInputBorder(
                            borderSide: _emailController.text.contains(RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                                ? BorderSide(color: Colors.green)
                                : BorderSide(color: AppColors.orangeProfile),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                      onSaved: (text) {
                        email = text!;
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  loading
                      ? CustomLoader(
                          customLoaderType: CustomLoaderType.defaultCupertino)
                      : InkWell(
                          highlightColor: Colors.blue.withOpacity(0.4),
                          splashColor: AppColors.orangeProfile.withOpacity(0.5),
                          // ignore: unnecessary_lambdas
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              sharedPref.name = _nameController.text.trim();
                              formKey.currentState!.save();
                              formKey.currentState!.reset();
                              log("object");
                              if (email.isNotEmpty &&
                                  !email.contains(RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                                Fluttertoast.showToast(
                                    msg: "Enter valid email",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                setState(() {
                                  _registerUser();
                                  loading = true;
                                });
                              }
                            }
                          },
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              padding: EdgeInsets.only(top: 14),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: const [
                                        AppColors.orange,
                                        AppColors.orangeProfile
                                      ])),
                              child: Text(
                                "Sign up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.large,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "By clicking sign up you are agreeing to the ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.normal),
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsAndConditions()));
                        },
                        child: Text(
                          "Terms of use ",
                          style: TextStyle(
                              color: AppColors.orangeDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal),
                        ),
                      ),
                      Text(
                        "and the ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal),
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
                              color: AppColors.orangeDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 37),
                ],
              ),
            )),
      ))),
    );
  }
}
