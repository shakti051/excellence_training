import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class OneNerdPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).size.width < 1050
          ? EdgeInsets.only(left: 16, right: 16)
          : EdgeInsets.only(right: 16),
      height: 150,
      padding: EdgeInsets.only(top: 16),
      width: MediaQuery.of(context).size.width < 1050
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * .30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                'Your 1NERD Plan',
                style: TextStyle(
                    fontSize: 10, fontFamily: 'Lato', color: Colors.black87),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Text(
                    'Premium',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                        color: AppColors.BACKGROUND_COLOR),
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 8, 16, 0),
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.GREEN),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Update Plan',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  )),
            ],
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: .5,
            indent: 16,
            endIndent: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
                      child: Text(
                        'Total Per Month',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Open',
                            color: AppColors.BACKGROUND_COLOR),
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(8, 8, 16, 0),
                      child: Text(
                        'See Details',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Open',
                            decoration: TextDecoration.underline,
                            color: AppColors.GREEN),
                      )),
                ],
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Text(
                    '\$${99}',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Open',
                        color: AppColors.BACKGROUND_COLOR),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
