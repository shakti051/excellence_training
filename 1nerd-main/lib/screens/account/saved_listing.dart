import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/account_widgets/account_profile_menu.dart';
import 'package:feedback/widgets/account_widgets/saved_listing/saved_listing.dart';
import 'package:flutter/material.dart';
import 'package:feedback/main.dart';
import 'package:feedback/widgets/account_widgets/account_type.dart';

class SavedListing extends StatelessWidget {
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
                      SavedHeading(),
                      SalesRentals(),
                      SizedBox(height: 30),
                      FlatAvailable(),
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
