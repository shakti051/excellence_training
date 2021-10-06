import 'package:eduarno/Utilities/constants.dart';
import 'package:flutter/material.dart';

class EduarnoTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      dividerTheme: DividerThemeData(
        color: Color(0xffEEEEEE),
        space: 30,
        thickness: 2,
        // indent: 40,
        // endIndent: 30,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kPrimaryGreenColor),
        ),
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: kPrimaryGreenColor),
      appBarTheme: AppBarTheme(
          foregroundColor: kChatColor,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          centerTitle: true,
          backwardsCompatibility: true,
          // color: Colors.white,
          iconTheme: IconThemeData(color: kChatColor),
          textTheme: TextTheme(
            headline6: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xff303030),
                fontSize: 18),
          )));
}
