import 'package:flutter/material.dart';
import 'package:feedback/resources/app_colors.dart';

class RequestedDocuments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: (MediaQuery.of(context).size.width < 850 ||
                MediaQuery.of(context).size.height < 600)
            ? EdgeInsets.only(left: 16, right: 16, bottom: 0)
            : EdgeInsets.only(right: 16, bottom: 0),
        width: MediaQuery.of(context).size.width - 200,
        padding: EdgeInsets.only(left: 16, top: 16),
        color: Colors.white,
        child: Text(
          'Requested Documents',
          style: TextStyle(
              color: AppColors.BACKGROUND_COLOR,
              fontSize: 16,
              fontFamily: 'Lato'),
        ));
  }
}
