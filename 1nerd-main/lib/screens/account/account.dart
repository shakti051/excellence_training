import 'package:feedback/main.dart';
import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/account_widgets/account_widgets.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.THEME_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MenuHorizontal(),
              SizedBox(height: 10),
              AccountType(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AccountProfileMenu(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Profile(),
                      Container(
                        width: MediaQuery.of(context).size.width * .3,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
