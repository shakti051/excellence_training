import 'package:feedback/main.dart';
import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/agent_widgets/agent_widgets.dart';
import 'package:feedback/widgets/rentals/mobile_profile_menu.dart';
import 'package:feedback/widgets/search.dart';
import 'package:flutter/material.dart';

class AgentMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.THEME_COLOR,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MobileMenu(),
            SearchBar(),
            MobileProfileMenu(),
            Row(
              children: <Widget>[AgentList(), AddNew()],
            )
          ],
        ),
      ),
    );
  }
}
