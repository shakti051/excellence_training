import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  void ChangeDiceFace() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1; // for num 1-6
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: () {
              ChangeDiceFace();
              print('Left dice no $leftDiceNumber');
            },
            child: Image.asset('images/dice$leftDiceNumber.png'),
          ),
        ),
        Expanded(
          child: FlatButton(
            onPressed: () {
              ChangeDiceFace();
              print('Right dice no $rightDiceNumber');
            },
            child: Image.asset('images/dice$rightDiceNumber.png'),
          ),
        ),
      ]),
    );
  }
}
