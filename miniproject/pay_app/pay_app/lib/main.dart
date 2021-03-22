import 'package:flutter/material.dart';
import 'package:pay_app/custom_appbar.dart';

void main()
{
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomAppBar(),
    );
  }
}


