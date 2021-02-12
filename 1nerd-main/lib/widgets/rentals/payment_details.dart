import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).size.width < 1050
          ? EdgeInsets.only(left: 16, right: 16)
          : EdgeInsets.only(right: 16),
      height: 170,
      padding: EdgeInsets.only(top: 16),
      width: MediaQuery.of(context).size.width < 1050
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * .30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text(
                    'Payment Details',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Lato',
                        color: AppColors.BACKGROUND_COLOR),
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Icon(Icons.more_horiz)),
            ],
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Image(
                    image: AssetImage('assets/images/visa.jpg'),
                    width: 70,
                    height: 30,
                  )),
              Text(
                '.... .... .... 2222',
                style: TextStyle(fontSize: 10, color: AppColors.LIGHT_BLACK),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 16, top: 4, bottom: 4),
            child: Text('you are billed monthly',
                style: TextStyle(
                    color: AppColors.LIGHT_BLACK,
                    fontSize: 10,
                    fontFamily: 'Open')),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, top: 4, bottom: 4),
            child: Text('Next billing on October 23,2020',
                style: TextStyle(
                    color: AppColors.LIGHT_BLACK,
                    fontSize: 10,
                    fontFamily: 'Open')),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, top: 4, bottom: 4),
            child: Text('Invoice sent to abc@gmail.com',
                style: TextStyle(
                    color: AppColors.LIGHT_BLACK,
                    fontSize: 10,
                    fontFamily: 'Open')),
          )
        ],
      ),
    );
  }
}
