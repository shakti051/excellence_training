import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';

class PackageValidity extends StatelessWidget {
  const PackageValidity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage("assets/images/package_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                left: MarginSize.normal,
                top: MarginSize.normal,
                bottom: MarginSize.extraSmall),
            child: Text(
              "Package name",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontName.frutinger,
                  fontWeight: FontWeight.w700,
                  fontSize: FontSize.heading),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: MarginSize.normal),
            child: Text(
              "Safe health clinic",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontName.frutinger,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSize.small),
            ),
          ),
          SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: MarginSize.normal),
                child: Text(
                  "*Valid till 30 Mar,2022",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.extraSmall),
                ),
              ),
              Container(
                width: 101,
                height: 37,
                padding: EdgeInsets.only(top: 10),
                margin: EdgeInsets.only(right: MarginSize.normal),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.pink,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            margin: EdgeInsets.only(
              left: MarginSize.normal,
            ),
            child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * .8,
                lineHeight: 5.0,
                percent: 0.5,
                progressColor: Colors.white),
          )
        ],
      ),
    );
  }
}
