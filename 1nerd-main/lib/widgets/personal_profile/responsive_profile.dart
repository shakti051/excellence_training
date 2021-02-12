import 'package:feedback/main.dart';
import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/personal_profile/personal_profile.dart';
import 'package:feedback/widgets/rentals/mobile_profile_menu.dart';
import 'package:feedback/widgets/search.dart';
import 'package:flutter/material.dart';

class ResponsiveProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.THEME_COLOR,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MobileMenu(),
          SearchBar(),
          MobileProfileMenu(),
          HeadingProfile(),
          ProfilePic(),
          SizedBox(height: 10),
          PersonalDetails(),
          SizedBox(height: 10),
          ProfileDetails(),
          SizedBox(height: 10),
          SocialLinks(),
          SizedBox(height: 20)
        ],
      ))),
    );
  }
}
