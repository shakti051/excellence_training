import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class HeadingFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(16, 0, 4, 0),
                child: FlatButton(
                  onPressed: () {},
                  child: const Text('All',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontFamily: 'Open')),
                  color: AppColors.BACKGROUND_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                padding: EdgeInsets.all(4),
                child: FlatButton(
                  onPressed: () {},
                  child: const Text('Anything',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontFamily: 'Open')),
                  color: AppColors.THEME_COLOR,
                  hoverColor: AppColors.BACKGROUND_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black87)),
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                padding: EdgeInsets.all(4),
                child: FlatButton(
                  onPressed: () {},
                  child: const Text('Features',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontFamily: 'Open')),
                  color: AppColors.THEME_COLOR,
                  hoverColor: AppColors.BACKGROUND_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black87)),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(8, 0, 4, 0),
                padding: EdgeInsets.all(4),
                child: FlatButton(
                  onPressed: () {},
                  child: const Text('Suggestions',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontFamily: 'Open')),
                  color: AppColors.THEME_COLOR,
                  hoverColor: AppColors.BACKGROUND_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black87)),
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                padding: EdgeInsets.all(4),
                child: FlatButton(
                  onPressed: () {},
                  child: const Text('Community',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontFamily: 'Open')),
                  color: AppColors.THEME_COLOR,
                  hoverColor: AppColors.BACKGROUND_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black87)),
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                padding: EdgeInsets.all(4),
                child: FlatButton(
                  onPressed: () {},
                  child: const Text('Bugs',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontFamily: 'Open')),
                  color: AppColors.THEME_COLOR,
                  hoverColor: AppColors.BACKGROUND_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black87)),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(8, 0, 16, 0),
                padding: EdgeInsets.all(4),
                child: FlatButton(
                  onPressed: () {},
                  child: const Text('Services',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontFamily: 'Open')),
                  color: AppColors.THEME_COLOR,
                  hoverColor: AppColors.BACKGROUND_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black87)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
