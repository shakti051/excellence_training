import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/account_widgets/account_profile_menu.dart';
import 'package:feedback/widgets/account_widgets/account_type.dart';
import 'package:feedback/widgets/account_widgets/rental_application/rental_application.dart';
import 'package:flutter/material.dart';
import 'package:feedback/main.dart';

class RentalApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.THEME_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MenuHorizontal(),
              SizedBox(height: 10),
              AccountType(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AccountProfileMenu(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RentalAppliHeading(),
                      Container(
                        width: MediaQuery.of(context).size.width - 200,
                        color: Colors.white,
                        padding: EdgeInsets.only(top: 10),
                        child: RentailDetails(),
                      ),
                      SizedBox(height: 50)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
