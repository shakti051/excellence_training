import 'package:flutter/material.dart';
import 'package:g_login/home_page.dart';

void main() {
  runApp(MyApp());
}
//83:DE:5B:6C:AE:2D:25:DE:0B:B4:D6:1B:33:74:63:27:A1:8C:AA:06
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
