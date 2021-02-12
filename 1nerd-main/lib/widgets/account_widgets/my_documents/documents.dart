import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class Documents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: (MediaQuery.of(context).size.width < 850 ||
                MediaQuery.of(context).size.height < 600)
            ? EdgeInsets.only(left: 16, right: 16, bottom: 0)
            : EdgeInsets.only(right: 16, bottom: 0),
        width: (MediaQuery.of(context).size.width < 850 ||
                MediaQuery.of(context).size.height < 600)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width - 200,
        padding: EdgeInsets.only(left: 16, top: 16),
        color: Colors.white,
        child: Text(
          'Uploaded Documents',
          style: TextStyle(
              color: AppColors.BACKGROUND_COLOR,
              fontSize: 16,
              fontFamily: 'Lato'),
        ));
  }
}
