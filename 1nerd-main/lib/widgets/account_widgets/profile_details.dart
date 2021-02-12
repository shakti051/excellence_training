import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: TextFormField(
            controller: _firstName,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'First Name',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: TextFormField(
            controller: _lastName,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Middle & Last Name',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: TextFormField(
            controller: _email,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: TextFormField(
            controller: _phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Phone Number',
            ),
          ),
        ),
        const Divider(
          color: AppColors.THEME_COLOR,
          height: 50,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
        FlatButton(
          onPressed: () {},
          textColor: AppColors.BACKGROUND_COLOR,
          child: Text(
            'Change Password',
            style: TextStyle(fontFamily: 'Lato'),
          ),
          color: Colors.white,
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
