import 'package:flutter/material.dart';

class ScreenState extends StatefulWidget {
  String value;
  ScreenState({this.value});

  @override
  _ScreenStateState createState() => _ScreenStateState(value);
}

class _ScreenStateState extends State<ScreenState> {
  String value;
  _ScreenStateState(this.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 2')),
      body: Center(child: Text(value)),
    );
  }
}
