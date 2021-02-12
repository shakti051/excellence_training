import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class SocialLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (MediaQuery.of(context).size.width < 1000 ||
              MediaQuery.of(context).size.height < 650)
          ? EdgeInsets.only(left: 16, right: 16)
          : EdgeInsets.only(right: 16),
      height: 150,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text(
                    'Social Links',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                        color: AppColors.BACKGROUND_COLOR),
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
                  padding: EdgeInsets.all(6),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Image(
                    alignment: AlignmentDirectional.topStart,
                    image: AssetImage('assets/images/facebook.png'),
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(8, 16, 16, 0),
                  padding: EdgeInsets.all(6),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Image(
                    alignment: AlignmentDirectional.topStart,
                    image: AssetImage('assets/images/instagram.png'),
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                  padding: EdgeInsets.all(6),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Image(
                    alignment: AlignmentDirectional.topStart,
                    image: AssetImage('assets/images/linkedin.png'),
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.fromLTRB(8, 0, 16, 0),
                    padding: EdgeInsets.all(6),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    alignment: AlignmentDirectional.topStart,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage('assets/images/youtube.png'),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
