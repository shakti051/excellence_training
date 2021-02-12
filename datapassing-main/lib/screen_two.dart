import 'package:flutter/material.dart';

class ScreenTwo extends StatelessWidget {
  String value;
  ScreenTwo({this.value});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 2')),
      body: Center(child: Text(value)),
    );
  }
}
