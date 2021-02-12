import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Timer'),
          backgroundColor: Colors.red,
        ),
        body: TimerWidget(),
      ),
    ),
  );
}

class TimerWidget extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<TimerWidget> {
  static const timeout = const Duration(seconds: 3);
  static const ms = const Duration(milliseconds: 1);
  int _timer = 0;
  bool timerRunning = false;
  Timer _timerObj;

  _TimerState() {
    _timerObj = startTimeout();
  }

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    timerRunning = true;
    return new Timer.periodic(duration, _increaseTimer);
  }

  void _increaseTimer(Timer timer) {
    setState(() {
      print(_timer);
      _timer++;
    });
  }

  void _stopTimer() {
    print("stop timer");
    _timerObj.cancel();
    setState(() {
      timerRunning = false;
    });
  }

  void _startTimer() {
    print("start timer");
    if (!_timerObj.isActive) {
      setState(() {
        timerRunning = true;
      });
      startTimeout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Text(
            "Timer $_timer",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.black38, fontSize: 15),
          ),
          !timerRunning
              ? MyButton(buttonText: "Start", onTap: _startTimer)
              : Container(),
          timerRunning
              ? MyButton(buttonText: "Stop", onTap: _stopTimer)
              : Container(),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton({this.buttonText = "", this.onTap});

  final VoidCallback onTap;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text(
            buttonText,
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}
