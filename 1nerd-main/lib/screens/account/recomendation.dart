import 'package:feedback/widgets/account_widgets/account_profile_menu.dart';
import 'package:feedback/widgets/account_widgets/recomendation/recomentation.dart';
import 'package:flutter/material.dart';
import 'package:feedback/main.dart';
import 'package:feedback/widgets/account_widgets/account_type.dart';
import 'package:feedback/resources/app_colors.dart';

class Recomendation extends StatelessWidget {
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
                      RecomendHeading(),
                      RecomendAvailable(),
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
