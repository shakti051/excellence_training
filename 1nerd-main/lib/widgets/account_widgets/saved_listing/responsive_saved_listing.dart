import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/account_widgets/account_widgets.dart';
import 'package:feedback/widgets/account_widgets/saved_listing/saved_listing.dart';
import 'package:flutter/material.dart';

class ResponsiveSavedListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.THEME_COLOR,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MobMenuhzr(),
              MobAdvertise(),
              SizedBox(height: 10),
              AccountType(),
              SizedBox(height: 10),
              MobProfileMenu(),
              SizedBox(height: 10),
              SavedHeading(),
              SalesRentals(),
              SizedBox(height: 30),
              FlatAvailable(),
              SizedBox(height: 20)
            ]),
      )),
    );
  }
}
