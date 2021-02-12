import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/account_widgets/account_type.dart';
import 'package:feedback/widgets/account_widgets/credit_report/credit_report.dart';
import 'package:feedback/widgets/account_widgets/credit_report/person_credit_report.dart';
import 'package:feedback/widgets/account_widgets/mob_advertise.dart';
import 'package:feedback/widgets/account_widgets/mob_menu_hzr.dart';
import 'package:feedback/widgets/account_widgets/mob_profile_menu.dart';
import 'package:flutter/material.dart';

class ResponsiveCreditReport extends StatelessWidget {
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
              CreditHeading(),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 16, right: 16),
                color: Colors.white,
                padding: EdgeInsets.only(top: 10),
                child: PersonCreditReport(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
