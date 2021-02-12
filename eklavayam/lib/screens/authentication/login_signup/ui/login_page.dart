import 'dart:convert';

import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/authentication/login_signup/utils/bubble_indication_painter.dart';
import 'package:eklavayam/screens/authentication/views/ForgotPasswordScreen.dart';
import 'package:eklavayam/screens/authentication/views/OTPScreen.dart';
import 'package:eklavayam/screens/onetimeinfo/ChooseLanguageScreen.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/StaticString.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eklavayam/screens/authentication/login_signup/style/theme.dart' as Theme;

import '../LoginModel.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  bool lemailvalidiate=false;
  bool lpassvalidiate=false;
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  bool semailvalidiate=false;
  bool snamevalidiate=false;
  bool smobilevalidiate=false;


  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupMobileController = new TextEditingController();


  GoogleSignIn _googleSignIn;
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;




  Future<void> validiateUser() async {
    var jsonstring=
    {
      "userType":userType,
      "userName":signupEmailController.text
    };
    var jsondata=jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(validiateUrl,jsondata);
    // var responsedata = await networkClient.postDatatest("v1/token",jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("access_token",responsedata['data']['accessToken'].toString());
      await sharedPreferences.setString("access_token1",responsedata['data']['accessToken'].toString());
      //showSnakbarWithGlobalKey(_scaffoldKey, "Validiate");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(signupMobileController.text,signupEmailController.text,signupNameController.text)));

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['message']);
    //print(responsedata['status']);
  }

  Future<void> loginUser() async {
    var jsonstring={
      "userType":userType,
      "userName":loginEmailController.text,
      "password":loginPasswordController.text
    };
    var jsondata=jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(loginUrl,jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {

      LoginModel loginModel=LoginModel.fromJson(responsedata);

      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      await sharedPreferences.setInt("uniqueId", loginModel.data.uniqueId?? "");
      await sharedPreferences.setString("mobile", loginModel.data.mobile??"");
      await sharedPreferences.setString("email", loginModel.data.email??"");
      await sharedPreferences.setString("fullName", loginModel.data.fullName??"");
      await sharedPreferences.setString("profileImg", loginModel.data.profileImg??"");
      await sharedPreferences.setString("token", loginModel.token??"");


      print(loginModel.status);
      // showSnakbarWithGlobalKey(_scaffoldKey, "Validiate");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChooseLanguageScreen()));

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['message']);

  }

  Future<void> socialValidiateUser() async {
    var jsonstring=
    {
      "userType": 1,
      "socialId": 46465465465654
    };
    var jsondata=jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(validiateSocialUrl,jsondata);
    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("access_token",responsedata['data']['accessToken'].toString());
      await sharedPreferences.setString("access_token1",responsedata['data']['accessToken'].toString());
      //showSnakbarWithGlobalKey(_scaffoldKey, "Validiate");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(signupMobileController.text,signupEmailController.text,signupNameController.text)));

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['message']);
    //print(responsedata['status']);
  }

  Future<void> socialSignup() async {
    var jsonstring={
      "loginFrom": "googleLogin",
      "email": "test123TETS123@gmail.com",
      "socialId": 56554654654654545,
      "fullName": "TEST",
      "userType": 1
    };
    var jsondata=jsonEncode(jsonstring);
    print(jsondata);

    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.postData(socialSignupUrl,jsondata);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {

      LoginModel loginModel=LoginModel.fromJson(responsedata);

      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      await sharedPreferences.setInt("uniqueId", loginModel.data.uniqueId?? "");
      await sharedPreferences.setString("mobile", loginModel.data.mobile??"");
      await sharedPreferences.setString("email", loginModel.data.email??"");
      await sharedPreferences.setString("fullName", loginModel.data.fullName??"");
      await sharedPreferences.setString("profileImg", loginModel.data.profileImg??"");
      await sharedPreferences.setString("token", loginModel.token??"");


      print(loginModel.status);
      // showSnakbarWithGlobalKey(_scaffoldKey, "Validiate");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChooseLanguageScreen()));

    } else
      showSnakbarWithGlobalKey(_scaffoldKey, responsedata['message']);

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.backGradientStart,
                    Theme.Colors.backGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: new Image(
                      width: 250.0,
                      height: 150.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/images/cre4.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      var res = await _googleSignIn.signIn();
      print("email>");
      if(res.email!=null)
      {
        print("social gmail validiate");
      }
      else{
        print("Please try another method");
      }
      print(res.email);
      print(res.displayName);
      print(res.id);
      print(res.photoUrl);
    } catch (error) {
      print(error);
    }
  }


  _loginWithFb() async {
    facebookSignIn.loginBehavior = FacebookLoginBehavior.nativeOnly;
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = jsonDecode(graphResponse.body);
        print(profile);


        if(profile['email']!=null)
        {
          print("social fb validiate");
        }
        else{
          print("Please try another method");
        }

        // try {
        //   Options options = Options(
        //     contentType: 'application/json',
        //   );
        //   var response = await dio.post('api/providerLogin',
        //       data: {
        //         "provider_user_id": accessToken.userId,
        //         "email": profile['email'],
        //         "provider": "facebook",
        //         "name": profile['name']
        //       },
        //       options: options);
        //   print(response.statusCode);
        //   if (response.statusCode == 200 || response.statusCode == 201) {
        //     var responseJson = jsonDecode(response.data);
        //     return responseJson;
        //   } else {
        //     setState(() {
        //       isLoadingFb = false;
        //     });
        //
        //     showInDialog(context, "Error", "Incorrect Credentials");
        //   }
        // } on DioError catch (exception) {
        //   if (exception == null ||
        //       exception.toString().contains('SocketException')) {
        //     setState(() {
        //       isLoadingFb = false;
        //     });
        //     showInDialog(context, "Error", "Network Error");
        //   } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
        //       exception.type == DioErrorType.CONNECT_TIMEOUT) {
        //     setState(() {
        //       isLoadingFb = false;
        //     });
        //     showInDialog(context, "Error",
        //         "Could'nt connect, please ensure you have a stable network.");
        //   } else {
        //     showInDialog(context, "Error", exception.toString());
        //     setState(() {
        //       isLoadingFb = false;
        //     });
        //     return null;
        //   }
        // }

        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancel by user");
        // setState(() {
        //   isLoadingFb = false;
        // });
        return null;
        break;
      case FacebookLoginStatus.error:
        print("error");
        // setState(() {
        //   isLoadingFb = false;
        // });
        return null;
        break;
    }
  }


  // Future<FirebaseUser> signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount =
  //   await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   final AuthResult authResult =
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //   final FirebaseUser user = authResult.user;
  //
  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);
  //
  //   final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  //   assert(user.uid == currentUser.uid);
  //
  //   return currentUser;
  // }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: orangecolor,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(

        gradient: new LinearGradient(
            colors: [
              Theme.Colors.loginGradientEnd,
              Theme.Colors.loginGradientEnd
            ],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),

      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Sign in",
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 250.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(

                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            errorText: lemailvalidiate ? 'Enter Valid Email' : null,
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorText: lpassvalidiate ? 'Enter Valid Password' : null,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 230.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Theme.Colors.loginGradientStart,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 5.0,
                      ),
                      BoxShadow(
                        color: Theme.Colors.loginGradientEnd,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 5.0,
                      ),
                    ],
                    gradient: new LinearGradient(
                        colors: [
                          Theme.Colors.loginGradientEnd,
                          Theme.Colors.loginGradientEnd
                        ],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: (){

                      setState(() {
                        lemailvalidiate= loginEmailController.text.isEmpty ?true : false;
                        lpassvalidiate= loginPasswordController.text.isEmpty ?true : false;
                      });
                      if(!lemailvalidiate && !lpassvalidiate)
                        loginUser();
                    },
                  )
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontFamily: "WorkSansMedium"),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.grey,
                          Colors.white,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    "Or",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontFamily: "WorkSansMedium"),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.grey,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 40.0),
                child: GestureDetector(
                  onTap: ()  {
                    _loginWithFb();
                    // showInSnackBar("Facebook button pressed");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      FontAwesomeIcons.facebookF,
                      color: orangecolor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () => {
                    _handleGoogleSignIn(),
                    //showInSnackBar("Google button pressed")
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      FontAwesomeIcons.google,
                      color: orangecolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 360.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(

                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            errorText: snamevalidiate ? 'Enter Valid Name' : null,
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmail,
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(

                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorText: semailvalidiate ? 'Enter Valid Email Address' : null,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmail,
                          controller: signupMobileController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(

                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorText: smobilevalidiate ? 'Enter Valid Phone Number' : null,
                            icon: Icon(
                              FontAwesomeIcons.mobile,
                              color: Colors.black,
                            ),

                            hintText: "Mobile Number",
                            hintStyle: TextStyle(
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                      //   child: TextField(
                      //     focusNode: myFocusNodePassword,
                      //     controller: signupPasswordController,
                      //     obscureText: _obscureTextSignup,
                      //     style: TextStyle(
                      //         fontFamily: "WorkSansSemiBold",
                      //         fontSize: 16.0,
                      //         color: Colors.black),
                      //     decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       icon: Icon(
                      //         FontAwesomeIcons.lock,
                      //         color: Colors.black,
                      //       ),
                      //       hintText: "Password",
                      //       hintStyle: TextStyle(
                      //           fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                      //       suffixIcon: GestureDetector(
                      //         onTap: _toggleSignup,
                      //         child: Icon(
                      //           _obscureTextSignup
                      //               ? FontAwesomeIcons.eye
                      //               : FontAwesomeIcons.eyeSlash,
                      //           size: 15.0,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   width: 250.0,
                      //   height: 1.0,
                      //   color: Colors.grey[400],
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                      //   child: TextField(
                      //     controller: signupConfirmPasswordController,
                      //     obscureText: _obscureTextSignupConfirm,
                      //     style: TextStyle(
                      //         fontFamily: "WorkSansSemiBold",
                      //         fontSize: 16.0,
                      //         color: Colors.black),
                      //     decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       icon: Icon(
                      //         FontAwesomeIcons.lock,
                      //         color: Colors.black,
                      //       ),
                      //       hintText: "Confirmation",
                      //       hintStyle: TextStyle(
                      //           fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                      //       suffixIcon: GestureDetector(
                      //         onTap: _toggleSignupConfirm,
                      //         child: Icon(
                      //           _obscureTextSignupConfirm
                      //               ? FontAwesomeIcons.eye
                      //               : FontAwesomeIcons.eyeSlash,
                      //           size: 15.0,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 340.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 5.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 5.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientEnd
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () {


                      setState(() {
                        snamevalidiate= signupNameController.text.isEmpty ?true :  false;
                        semailvalidiate= signupEmailController.text.isEmpty ?true :  false;
                        smobilevalidiate= signupMobileController.text.isEmpty ?true :  false;
                      });
                      if(!snamevalidiate && !semailvalidiate && !smobilevalidiate)
                        validiateUser();
                    }
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
}
