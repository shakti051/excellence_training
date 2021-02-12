import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class MobAdvertise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.BACKGROUND_COLOR,
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('Advertise', style: TextStyle(color: AppColors.LIGHT_GREEN)),
          SizedBox(width: 10),
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            onPressed: () {},
            textColor: AppColors.BACKGROUND_COLOR,
            child: Text(
              'Sign In / Register',
              style: TextStyle(),
            ),
            color: AppColors.LIGHT_GREEN,
          ),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}
