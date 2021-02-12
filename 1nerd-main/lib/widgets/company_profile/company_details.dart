import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CompanyDetails extends StatelessWidget {
  final _comoanyName = TextEditingController();
  final _addr = TextEditingController();
  final _email = TextEditingController();
  final _cellPhone = TextEditingController();
  final _brokerage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (MediaQuery.of(context).size.width < 1000 ||
              MediaQuery.of(context).size.height < 650)
          ? EdgeInsets.only(left: 16, right: 16)
          : EdgeInsets.only(right: 16),
      height: MediaQuery.of(context).size.height < 650
          ? 420
          : MediaQuery.of(context).size.height * .58,
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
                    'Company Details',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Lato',
                        color: AppColors.BACKGROUND_COLOR),
                  )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: TextFormField(
              controller: _comoanyName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Company Name',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: TextFormField(
              controller: _addr,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Company Address',
                  suffixIcon: Icon(Icons.expand_more)),
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
              controller: _cellPhone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cell Phone',
              ),
            ),
          ),
          Container(
            color: AppColors.TXT_DISABLE,
            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: TextFormField(
              readOnly: true,
              controller: _brokerage,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Brokerage'),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  '1NERD.com/',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Open',
                      color: AppColors.LIGHT_BLACK),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 23),
                child: SizedBox(
                  width: 80,
                  child: const Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 1,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
