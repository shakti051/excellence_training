import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color backGradientStart = const Color(0xD3D3D3);
  static const Color backGradientEnd = const Color(0xC0C0C0);



  static const Color loginGradientStart = const Color(0xFFfbab66);
  static const Color loginGradientEnd = const Color.fromARGB(255, 0, 163, 199);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientEnd, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}