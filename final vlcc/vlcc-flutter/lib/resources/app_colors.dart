import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static List<Color> aquaGradient = [
    Color(0xff00E6FF),
    Color(0xff006AFF),
  ];
  // static Color aquaPurple =
  //     aquaPurpleGreen[Random().nextInt(aquaPurpleGreen.length)];
  static Color randomColor = Colors
      .primaries[Random().nextInt(Colors.primaries.length)]
      .withOpacity(0.5);
  static const Color appBarColor = Colors.white;
  static const Color backgroundColor = Color(0xfffafafa);
  static const Color orange1 = Color(0xfff4922e);
  static const Color orange = Color(0xffff6924);
  static const Color logoOrange = Color(0xffF37021);

  static const Color orangeCategoryTextBackground = Color(0xffF8862B);

  static const Color orangeDark = Color(0xfff56c27);
  static const Color facebookBlue = Color(0xff3a5998);
  static const Color orangeProfile = Color(0xfff3972f);
  static const Color pink = Color(0xffff6188);
  static const Color expertBar = Color(0xfffff0e9);
  static const Color pistaGreen = Color(0xffDDFFEB);

  static const Color blue = Color(0xff12b2b3);
  static const Color marineBlue = Color(0xff00F9B4);
  static const Color grey = Color(0xff9393aa);
  static const Color greyBackground = Color(0xfff0f0f0);
  static const Color aquaGreen = Color(0xff12B2B3);
  static const Color backBorder = Color(0xffe0e0e0);
  static const Color disabled = Color(0xff020433);
  static const Color disabledBackground = Color(0xff9393aa);
  static const Color profileEnabled = Color(0xff1E1F20);
  static const Color divider = Color(0xffE5E5E5);
  static const Color avatarBackground = Color(0xffE1DAD1);
  static const Color greyShadow = Color.fromRGBO(0, 0, 0, 0.1);
  static const Color orangeShadow = Color.fromRGBO(229, 103, 18, 0.3);
  static const Color calanderColor = Color(0xfff56726);
  static const Color yello = Color(0xffEE9A61);
  static const Color pending = Color(0xffFC9700);
  static const Color markShadow = Color.fromRGBO(0, 0, 0, 0.25);
  static const Color whiteShodow = Color(0xfff4f5f5); //rgba(255, 255, 255, 1)
  static const Color shadowBlue = Color.fromRGBO(255, 255, 255, 1); //#1E1F20
  static const Color selectedTab = Color(0xff1E1F20);
  static const Color navyBlue = Color(0xff9393aa); //#9393AA  292D32
  static const Color cameraColor = Color(0xff292D32);
}
