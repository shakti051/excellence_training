import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const Buttons({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  onChanged("Button 1 here");
                },
                child: Text("Button 1"),
                color: Colors.pink),
            FlatButton(
                onPressed: () {
                  onChanged("Button 2 here");
                },
                child: Text("Button 2"),
                color: Colors.pink),
            FlatButton(
                onPressed: () {
                  onChanged("Button 3 here");
                },
                child: Text("Button 3"),
                color: Colors.pink),
          ]),
    );
  }
}
