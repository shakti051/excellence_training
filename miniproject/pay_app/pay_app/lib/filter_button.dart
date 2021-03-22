import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String title;
  final Function onPressedFunction;
  final Color buttonColor;

  FilterButton({@required this.title, @required this.onPressedFunction, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: onPressedFunction,
        child: Text(title),
      ),
    );
  }
}
