import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AddNew extends StatelessWidget {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _title = TextEditingController();
  final _email = TextEditingController();
  final _cellPhone = TextEditingController();
  final _brokerage = TextEditingController();
  final _agentPlan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    customDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext c) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * .8,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: [
                          InkWell(
                            child: Icon(Icons.keyboard_arrow_left,
                                color: AppColors.BACKGROUND_COLOR),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(8, 16, 8, 10),
                              child: Text('Add New Agent',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Open',
                                    color: AppColors.BACKGROUND_COLOR,
                                    fontWeight: FontWeight.w700,
                                  )))
                        ]),
                        Stack(
                          alignment: const Alignment(1.2, 0.3),
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 16, top: 8),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/female.png'),
                                radius: 30,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 7,
                              backgroundImage:
                                  AssetImage('assets/images/camera.png'),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: Text(
                                  'Personal Details',
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
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: _firstName,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'First Name',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: _lastName,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Last Name',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: TextFormField(
                            controller: _title,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Title',
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
                          margin: EdgeInsets.fromLTRB(16, 4, 16, 16),
                          child: TextFormField(
                            readOnly: true,
                            controller: _brokerage,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Brokerage'),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                'Company pays',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.BACKGROUND_COLOR,
                                    fontFamily: 'Open'),
                              ),
                            ),
                            Switch(
                              value: false,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.greenAccent,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: AppColors.OFFLINE,
                              onChanged: (bool value) {},
                            ),
                            Container(
                              child: Text(
                                '{IF COMPANY PAY \n THEN WE SHOW BELOW}',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.pinkAccent,
                                    fontFamily: 'Open'),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: TextFormField(
                            controller: _agentPlan,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Select An Agent Plan',
                                suffixIcon: Icon(Icons.expand_more)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          width: double.infinity,
                          height: 50,
                          child: FlatButton(
                            onPressed: () {},
                            color: AppColors.BACKGROUND_COLOR,
                            textColor: Colors.white,
                            child: Text('Create Agent'),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ]),
                ),
              ),
            );
          });
    }

    return Container(
      width: 140,
      height: 180,
      margin: EdgeInsets.only(right: 16, top: 16),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Align(alignment: Alignment(1, 1), child: Icon(Icons.more_horiz)),
          InkWell(
            onTap: () {
              customDialog();
            },
            child: Container(
              child: CircleAvatar(
                backgroundColor: AppColors.THEME_COLOR,
                radius: 50,
                child: Icon(
                  Icons.add,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Add Agent',
            style:
                TextStyle(fontSize: 15, color: Colors.grey, fontFamily: 'Open'),
          ),
        ],
      ),
    );
  }
}
