import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class MobMenuhzr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(8, 8, 16, 16),
            child: Text(
              '1NERD',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Passion',
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1),
            ),
          ),
          InkWell(child: Icon(Icons.home, color: Colors.white)),
          InkWell(
              onTap: () => Navigator.pushNamed(context, '/rentals'),
              child: Icon(Icons.location_city, color: Colors.white)),
          Icon(Icons.edit_location, color: Colors.white),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}
