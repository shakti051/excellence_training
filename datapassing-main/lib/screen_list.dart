import 'package:flutter/material.dart';

class ScreenList extends StatefulWidget {
  List value;
  //String value;
  ScreenList({Key key, @required this.value}) : super(key: key);

  @override
  _ScreenStateState createState() => _ScreenStateState(value);
}

class _ScreenStateState extends State<ScreenList> {
  List value;
  // String value;
  _ScreenStateState(this.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 2')),
      body: Center(child: Text(value[1])),
    );
  }
}
