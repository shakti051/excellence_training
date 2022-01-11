import 'package:flutter/material.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';

class PackageName extends StatelessWidget {
  const PackageName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 146,
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
        ],
      ) /* add child content here */,
    );
  }
}
