import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class SalesRentals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (MediaQuery.of(context).size.width < 850 ||
              MediaQuery.of(context).size.height < 600)
          ? EdgeInsets.only(left: 16, right: 16, bottom: 8)
          : EdgeInsets.only(right: 16, bottom: 8),
      child: Row(
        children: [
          Text('Sales',
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: AppColors.BACKGROUND_COLOR,
                  fontSize: 13,
                  fontFamily: 'Lato')),
          SizedBox(width: 10),
          Text('Rentals',
              style: TextStyle(
                  color: Colors.black54, fontSize: 13, fontFamily: 'Lato'))
        ],
      ),
    );
  }
}
