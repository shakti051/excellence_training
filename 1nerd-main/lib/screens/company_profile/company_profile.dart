import 'package:feedback/main.dart';
import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/company_profile/company_logo.dart';
import 'package:feedback/widgets/personal_profile/personal_profile.dart';
import 'package:feedback/widgets/profile_menu.dart';
import 'package:feedback/widgets/company_profile/company_profile.dart';
import 'package:feedback/widgets/search.dart';
import 'package:flutter/material.dart';

class CompanyProfile extends StatelessWidget {
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
                          Heading(),
                          CompanyLogo(),
                          SizedBox(
                            height: 10,
                          ),
                          CompanyDetails(),
                        ],
                      ),
                      //Text('This is third row')
                      Column(
                        children: [
                          CompanyProfileDetails(),
                          SizedBox(height: 10),
                          SocialLinks()
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