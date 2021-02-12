import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class HeadingProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: (MediaQuery.of(context).size.width < 1000 ||
                    MediaQuery.of(context).size.height < 650)
                ? EdgeInsets.only(left: 16, right: 16, bottom: 8)
                : EdgeInsets.only(right: 16, bottom: 8),
            child: Text(
              'PERSONAL PROFILE',
              style: TextStyle(
                  color: AppColors.BACKGROUND_COLOR,
                  fontSize: 16,
                  fontFamily: 'Lato'),
            )),
      ],
    );
  }
}
