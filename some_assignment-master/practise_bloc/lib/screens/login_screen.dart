import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_bloc/blocs/loginbloc/loginbloc.dart';
import 'package:practise_bloc/blocs/loginbloc/loginevent.dart';
import 'package:practise_bloc/blocs/loginbloc/loginstate.dart';

final _loginFormKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _obscuretext = true;
  void showPassword() {
    setState(() {
      _obscuretext = !_obscuretext;
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: usernameController,
      obscureText: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: new Icon(Icons.mail),
        hintText: "E-Mail",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter Credentials';
        }
        return null;
      },
    );
    final passwordField = TextFormField(
      controller: passwordController,
      obscureText: _obscuretext,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hoverColor: Colors.grey,
          hintText: "Password",
          prefixIcon: new Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              showPassword();
            },
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter Credentials';
        }
        return null;
      },
    );

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
     // print("state is >>>>>>>>>>>>>>>> $state");
      return Form(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: <Widget>[
                    //WelcomeScreen(),
                    SizedBox(height: 100),
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Card(
                                shadowColor: Colors.black,
                                elevation: 8,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                  color: Colors.transparent,
                                )),
                                child: emailField,
                                key: Key('email')),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Card(
                              shadowColor: Colors.black,
                              elevation: 8,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                color: Colors.transparent,
                              )),
                              child: passwordField,
                              key: Key('password'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          'ForgotPassword',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45.0),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.teal[800],
                                Colors.teal[700],
                                Colors.teal[700],
                                Colors.teal[800],
                              ])),
                      child: FlatButton(
                        key: Key('button'),
                        padding: EdgeInsets.symmetric(horizontal: 153),
                        child: Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        textColor: Colors.white,
                        onPressed: () {
                          print(_loginFormKey.currentState.validate());
                          if (_loginFormKey.currentState.validate()) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Login....'),
                            ));
                            context.bloc<LoginBloc>().add(LoginWithCredentials(
                                usernameController.text,
                                passwordController.text));
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 24),
//                    BottomList('About Excellence HRMS'),
//                    BottomFeature(
                    //                       'Say goodbye to cluttered spreadsheets From attendence to timesheets and performance, run HR on the cloud. Get more done with a simple user interface, effortless automation, and efficient processing.'),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
