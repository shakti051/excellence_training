import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          height: MediaQuery.of(context).size.width < 1050
              ? MediaQuery.of(context).size.height * .4
              : MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width < 1050
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * .30,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 20, 0),
                  child: Text(
                    'Payment History',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                        color: AppColors.BACKGROUND_COLOR),
                  )),
              ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                          child: Text(
                            'October 23,2020',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Open',
                                color: AppColors.BACKGROUND_COLOR),
                          )),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
                              child: Text(
                                '\$${99}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Open',
                                    color: AppColors.BACKGROUND_COLOR),
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(8, 8, 16, 0),
                            child: Icon(
                              Icons.file_download,
                              color: Colors.blueAccent,
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height < 600
              ? 40
              : MediaQuery.of(context).size.height * .19,
        )
      ],
    );
  }
}
