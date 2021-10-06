import 'package:eduarno/Utilities/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_message.dart';
import 'image_message.dart';
import 'text_message.dart';

class Message extends StatelessWidget {
  final ChatMessage message;
  const Message({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget messageContent(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
          break;
        case ChatMessageType.document:
          return DocumentMessage(message: message);
          break;
        case ChatMessageType.image:
          return ImageMessage(
            message: message,
          );
          break;
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/logo.png"),
                radius: 16,
              ),
            ),
          ],
          messageContent(message),
        ],
      ),
    );
  }
}

class DocumentMessage extends StatefulWidget {
  final ChatMessage message;

  const DocumentMessage({Key key, @required this.message}) : super(key: key);

  @override
  _DocumentMessageState createState() => _DocumentMessageState();
}

class _DocumentMessageState extends State<DocumentMessage> {
  bool isDownload = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isDownload = !isDownload;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: widget.message.isSender ? kNeutralGray : kPrimaryGreenColor,
          borderRadius: BorderRadius.only(
            topLeft:
                widget.message.isSender ? Radius.circular(10) : Radius.zero,
            topRight:
                widget.message.isSender ? Radius.zero : Radius.circular(10),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                    height: 18,
                    width: 18,
                    decoration: isDownload
                        ? null
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: kChatColor)),
                    child: isDownload
                        ? Stack(
                            children: [
                              CircularProgressIndicator(
                                color: kPrimaryGreenColor,
                                strokeWidth: 1,
                              ),
                              Center(
                                child: Icon(
                                  Icons.close,
                                  size: 10,
                                ),
                              )
                            ],
                          )
                        : Icon(
                            CupertinoIcons.arrow_down,
                            size: 10,
                          )),
                SizedBox(width: 8),
                // Text(
                //   "Document.pdf",
                //   style: TextStyle(
                //       color:
                //           widget.message.isSender ? kChatColor : Colors.white,
                //       fontSize: 14,
                //       fontWeight: FontWeight.w400),
                // ),
                RichText(
                    text: TextSpan(
                        text: "Document.pdf\n",
                        style: TextStyle(
                            color: widget.message.isSender
                                ? kChatColor
                                : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                      TextSpan(
                          text: "145.65 kb",
                          style: TextStyle(color: kChatColor, fontSize: 8))
                    ]))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Visibility(
                  visible: widget.message.isSender,
                  child: Text(
                    "06:45 am",
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.right,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
