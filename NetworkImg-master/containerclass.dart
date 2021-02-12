import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Container(
              color: Colors.teal,
              child: Text('Hellow'),
              padding: EdgeInsets.fromLTRB(25, 40, 0, 0),
              height: 100,
              width: 100,
              margin: EdgeInsets.all(10),
            ),
          ),
        ),
      ),
    ),
  );
}


/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.amber[600],
        width: 48.0,
        height: 48.0,
      ),
    );
  }
}
*/