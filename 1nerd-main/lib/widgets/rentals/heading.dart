import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: MediaQuery.of(context).size.width < 1050
            ? EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16)
            : EdgeInsets.only(right: 16, bottom: 16),
        child: Text(
          'BILLING',
          style: TextStyle(
              color: AppColors.BACKGROUND_COLOR,
              fontSize: MediaQuery.of(context).size.width < 1050 ? 20 : 25,
              fontFamily: 'Lato'),
        ));
  }
}
