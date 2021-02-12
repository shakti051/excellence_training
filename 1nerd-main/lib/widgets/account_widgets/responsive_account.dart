import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/account_widgets/account_widgets.dart';
import 'package:flutter/material.dart';

class ResponsiveAccount extends StatelessWidget {
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
              Profile(),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfilePic(),
                    SizedBox(height: 20),
                    ProfileDetails(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}