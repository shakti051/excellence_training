import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class SavedHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: (MediaQuery.of(context).size.width < 850 ||
                MediaQuery.of(context).size.height < 600)
            ? EdgeInsets.only(left: 16, right: 16, bottom: 8)
            : EdgeInsets.only(right: 16, bottom: 8),
        child: Text(
          'SAVED LISTINGS',
          style: TextStyle(
              color: AppColors.BACKGROUND_COLOR,
              fontSize: 16,
              fontFamily: 'Lato'),
        ));
  }
}
