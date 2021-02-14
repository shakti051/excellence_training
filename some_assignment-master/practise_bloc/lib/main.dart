import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_bloc/blocs/loginbloc/loginstate.dart';
import 'package:practise_bloc/blocs/profilebloc/profile_bloc.dart';
import 'package:practise_bloc/screens/homescreen.dart';
import 'package:practise_bloc/screens/login_screen.dart';
import 'package:practise_bloc/services/loginservice.dart';
import 'blocs/loginbloc/loginbloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
      ], child: HrApp()),
    );
  }
}

class HrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
//        print("state in main>>>>>>>>>>>>> $state");
       //     getprofile();
            return ShowProfile();
          }
          return LoginScreen();
        },
      ),
    );
  }
}