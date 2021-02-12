import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CompanyProfileDetails extends StatelessWidget {
  final _yearLicenced = TextEditingController();
  final _languages = TextEditingController();
  final _speciality = TextEditingController();
  final _neighbour = TextEditingController();
  final _bio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (MediaQuery.of(context).size.width < 1000 ||
              MediaQuery.of(context).size.height < 650)
          ? EdgeInsets.only(left: 16, right: 16)
          : EdgeInsets.only(right: 16),
      height: MediaQuery.of(context).size.height < 650
          ? 400
          : MediaQuery.of(context).size.height - 250,
      padding: EdgeInsets.only(top: 16),
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
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Profile Details',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Lato',
                        color: AppColors.BACKGROUND_COLOR),
                  )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: SizedBox(),
                ),
                Flexible(
                  child: TextFormField(
                    controller: _yearLicenced,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Year Founded',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: TextFormField(
              controller: _languages,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Languages',
                  suffixIcon: Icon(Icons.expand_more)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: TextFormField(
              controller: _speciality,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Team Speciality',
                  suffixIcon: Icon(Icons.expand_more)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: TextFormField(
              controller: _neighbour,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Neighborhoods of coverage',
                  suffixIcon: Icon(Icons.expand_more)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: TextFormField(
              maxLines: 2,
              controller: _bio,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bio',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
