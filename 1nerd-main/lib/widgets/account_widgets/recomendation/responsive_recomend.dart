import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/account_widgets/account_widgets.dart';
import 'package:feedback/widgets/account_widgets/recomendation/recomend_available.dart';
import 'package:flutter/material.dart';

class ResponsiveRecomend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.THEME_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MobMenuhzr(),
              MobAdvertise(),
              SizedBox(height: 10),
              AccountType(),
              SizedBox(height: 10),
              MobProfileMenu(),
              SizedBox(height: 10),
              RecomendAvailable(),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
