import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/screens/agents/agents.dart';
import 'package:feedback/screens/company_profile/company_profile.dart';
import 'package:feedback/screens/personal_profile/personal_profile.dart';
import 'package:feedback/screens/rentals/rentals.dart';
import 'package:feedback/widgets/agent_widgets/agent_widgets.dart';
import 'package:feedback/widgets/company_profile/company_profile.dart';
import 'package:feedback/widgets/personal_profile/personal_profile.dart';
import 'package:feedback/widgets/rentals/responsive_billing.dart';
import 'package:flutter/material.dart';

class MobileProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            (MediaQuery.of(context).size.width < 1000 ||
                                    MediaQuery.of(context).size.height < 650)
                                ? ResponsiveProfile()
                                : PersonalProfile()),
                  );
                },
                child: Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      'Personal profile',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Open',
                          color: AppColors.BACKGROUND_COLOR),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            (MediaQuery.of(context).size.width < 1000 ||
                                    MediaQuery.of(context).size.height < 650)
                                ? ResponsiveCompanyProfile()
                                : CompanyProfile()),
                  );
                },
                child: Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      'Company Profile',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Open',
                          color: AppColors.BACKGROUND_COLOR),
                    )),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              (MediaQuery.of(context).size.width < 1000 ||
                                      MediaQuery.of(context).size.height < 650)
                                  ? AgentMobileView()
                                  : CompanyAgents()));
                },
                child: Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      'Company Agent',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Lato',
                          color: AppColors.BACKGROUND_COLOR),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              (MediaQuery.of(context).size.width < 1000 ||
                                      MediaQuery.of(context).size.height < 650)
                                  ? ResponsiveBilling()
                                  : RentalsPage()));
                },
                child: Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text('Billing',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Open',
                            color: AppColors.BACKGROUND_COLOR))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
