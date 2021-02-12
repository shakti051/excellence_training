import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class PersonCreditReport extends StatelessWidget {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _dob = TextEditingController();
  final _securityNumber = TextEditingController();
  final _homeAddr = TextEditingController();

  String str =
      """I am aware that a credit history, landlord/tenant court search and criminal background check may be done in conjunction with my application and I hereby authorize Rent Application to request the aforementioned reports. I understand that I may have the right to make a written request within a reasonable period of time to receive additional, detailed information about the nature and scope of this investigation. """;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
              labelText: 'Last Name',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: TextFormField(
            controller: _dob,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Date of Birth',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: TextFormField(
            controller: _securityNumber,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Social Security Number',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: TextFormField(
            controller: _homeAddr,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Home Address',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Text(
            str,
            textAlign: TextAlign.left,
            style: TextStyle(color: AppColors.OFFLINE, fontSize: 10),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
          height: 50,
          child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {},
            textColor: Colors.white,
            child: Text(
              'Review Agent',
              style: TextStyle(fontFamily: 'Open'),
            ),
            color: AppColors.BACKGROUND_COLOR,
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
