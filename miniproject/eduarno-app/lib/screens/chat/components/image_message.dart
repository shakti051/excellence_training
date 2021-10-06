import 'package:flutter/material.dart';

import '../../../Utilities/constants.dart';
import 'chat_message.dart';

class ImageMessage extends StatelessWidget {
  final ChatMessage message;
  const ImageMessage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: message.isSender ? kNeutralGray : kPrimaryGreenColor,
        borderRadius: BorderRadius.only(
          topLeft: message.isSender ? Radius.circular(10) : Radius.zero,
          topRight: message.isSender ? Radius.zero : Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset("assets/assessment_list_bg.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Visibility(
                visible: message.isSender,
                child: Text(
                  "06:45 am",
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.right,
                )),
          )
        ],
      ),
    );
  }
}
