import 'package:eduarno/Utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_message.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    Key key,
  }) : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  bool isAttached = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatMessageNotifier>(
      builder: (context, data, child) {
        final chatNotifier = context.watch<ChatMessageNotifier>();
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          decoration: BoxDecoration(
            color: Color(0xffF2FFF6),
          ),
          child: SafeArea(
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    minLines: 1,
                    maxLines: 8,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      // suffixIconConstraints: BoxConstraints(maxWidth: 100),
                      suffixIcon: IconButton(
                          onPressed: () {
                            chatNotifier.isActive = !chatNotifier.isActive;
                          },
                          icon: Icon(
                            Icons.attach_file_rounded,
                            color: Color(0xff5E6871),
                          )),
                      hintText: "Type your message...",
                      hintStyle: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      // border: InputBorder.none
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Card(
                      elevation: 1,
                      color: kPrimaryColor,
                      child: Icon(
                        CupertinoIcons.paperplane,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
