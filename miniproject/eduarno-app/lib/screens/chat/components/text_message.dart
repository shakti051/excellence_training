import 'package:flutter/material.dart';
import '../../../Utilities/constants.dart';
import 'chat_message.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    @required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(
            right: !message.isSender ? 42.0 : 0,
            left: message.isSender ? 42.0 : 0),
        child: Container(
          // width: MediaQuery.of(context).size.width - 100,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.text,
                style: TextStyle(
                    color: message.isSender ? kChatColor : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                softWrap: true,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Visibility(
                    visible: message.isSender,
                    child: Text(
                      "06:45 am",
                      style:
                          TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.right,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
