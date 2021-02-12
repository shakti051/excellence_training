import 'package:feedback/main.dart';
import 'package:feedback/resources/app_colors.dart';
import 'package:feedback/widgets/profile_menu.dart';
import 'package:feedback/widgets/rentals/payment_history.dart';
import 'package:feedback/widgets/rentals/rentals.dart';
import 'package:feedback/widgets/search.dart';
import 'package:flutter/material.dart';

class RentalsPage extends StatelessWidget {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SearchBar(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      ProfileMenu(),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Heading(),
                            OneNerdPlan(),
                            SizedBox(height: 20),
                            PaymentDetails(),
                            SizedBox(
                                height: MediaQuery.of(context).size.height < 600
                                    ? 20
                                    : MediaQuery.of(context).size.height * .23)
                          ],
                        ),
                      ),
                      PaymentHistory(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
