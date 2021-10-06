import 'package:eduarno/Utilities/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Text("Agent"),
          leadingWidth: 70,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Card(
                elevation: 1,
                color: Color(0xffF6F7FA),
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Body(),
    );
  }
}
