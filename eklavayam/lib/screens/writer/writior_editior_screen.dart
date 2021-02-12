import 'package:flutter/material.dart';

class WritiorEditiorScreen extends StatefulWidget {
  @override
  _WritiorEditiorScreenState createState() => _WritiorEditiorScreenState();
}

class _WritiorEditiorScreenState extends State<WritiorEditiorScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
