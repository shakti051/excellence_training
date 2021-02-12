import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CompanyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (MediaQuery.of(context).size.width < 1000 ||
              MediaQuery.of(context).size.height < 650)
          ? EdgeInsets.only(left: 16, right: 16)
          : EdgeInsets.only(right: 16),
      height: 130,
      padding: EdgeInsets.only(top: 8),
      width: (MediaQuery.of(context).size.width < 1000 ||
              MediaQuery.of(context).size.height < 650)
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
                'Company Profile',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lato',
                    color: AppColors.BACKGROUND_COLOR),
              )),
          Stack(
            alignment: const Alignment(.9, 0),
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  child: Image(
                    image: AssetImage('assets/images/logo.jpeg'),
                    width: 60,
                    height: 60,
                  )),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 7,
                backgroundImage: AssetImage('assets/images/camera.png'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
