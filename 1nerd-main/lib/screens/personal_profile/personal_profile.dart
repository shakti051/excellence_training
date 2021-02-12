import 'package:feedback/main.dart';
import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/profile_menu.dart';
import 'package:feedback/widgets/personal_profile/personal_profile.dart';
import 'package:feedback/widgets/search.dart';
import 'package:flutter/material.dart';

class PersonalProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.THEME_COLOR,
      body: SafeArea(
        child: Row(
          children: [
            Column(
              children: <Widget>[
                Menu(),
              ],
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  SearchBar(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      ProfileMenu(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingProfile(),
                          ProfilePic(),
                          SizedBox(
                            height: 10,
                          ),
                          PersonalDetails(),
                        ],
                      ),
                      //Text('This is third row')
                      Column(
                        children: [
                          ProfileDetails(),
                          SizedBox(height: 10),
                          SocialLinks(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
