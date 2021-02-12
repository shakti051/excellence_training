import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/account_widgets/account_widgets.dart';
import 'package:feedback/widgets/account_widgets/my_agents/my_agents.dart';
import 'package:flutter/material.dart';

class ResponsiveMyAgent extends StatelessWidget {
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
            AgentHeading(),
            MyAgentList(),
          ],
        )),
      ),
    );
  }
}
