import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey))),
        FlatButton(onPressed: () {}, child: Text('data'))
      ],
    );
  }
}
