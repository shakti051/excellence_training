import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AccountType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Account Type',
          style: TextStyle(
            color: AppColors.LIGHT_BLACK,
          ),
        ),
        SizedBox(width: 5),
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {},
          textColor: Colors.white,
          child: Text(
            'Renter',
            style: TextStyle(fontFamily: 'Open'),
          ),
          color: AppColors.BACKGROUND_COLOR,
        ),
        SizedBox(width: 5),
        FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: AppColors.BACKGROUND_COLOR)),
          onPressed: () {},
          textColor: AppColors.LIGHT_BLACK,
          child: Text(
            'Buyer',
            style: TextStyle(fontFamily: 'Open'),
          ),
          color: AppColors.THEME_COLOR,
        ),
        SizedBox(width: 20)
      ],
    );
  }
}
