import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(1.2, 0.3),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, top: 8),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/female.png'),
            radius: 30,
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 7,
          backgroundImage: AssetImage('assets/images/camera.png'),
        )
      ],
    );
  }
}
