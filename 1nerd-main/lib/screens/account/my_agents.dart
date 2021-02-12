import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/account_widgets/account_widgets.dart';
import 'package:feedback/widgets/account_widgets/my_agents/my_agents.dart';
import 'package:flutter/material.dart';
import 'package:feedback/main.dart';

class MyAgents extends StatelessWidget {
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
                    children: [
                      AgentHeading(),
                      MyAgentList(),
                    ],
                  )
                ],
              )
            ],
          )),
        ));
  }
}
