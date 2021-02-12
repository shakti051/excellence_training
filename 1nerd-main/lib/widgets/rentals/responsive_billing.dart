import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/rentals/payment_history.dart';
import 'package:feedback/widgets/rentals/rentals.dart';
import 'package:feedback/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:feedback/main.dart';

class ResponsiveBilling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.THEME_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MobileMenu(),
                SearchBar(),
                MobileProfileMenu(),
                Row(children: [Heading()]),
                OneNerdPlan(),
                SizedBox(height: 20),
                PaymentDetails(),
                SizedBox(height: 20),
                PaymentHistory(),
              ],
            ),
          ),
        ));
  }
}
