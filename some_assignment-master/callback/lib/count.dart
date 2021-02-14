import 'package:flutter/material.dart';

class Count extends StatelessWidget {
  final int count;
  final Function(int) onCountChange;

  Count({
    @required this.count,
    @required this.onCountChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            onCountChange(1);
          },
        ),
        FlatButton(
          child: Text("$count"),
          onPressed: () => null,
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            onCountChange(-1);
          },
        ),
      ],
    );
  }
}
