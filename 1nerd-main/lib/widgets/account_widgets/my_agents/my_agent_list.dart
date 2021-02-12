import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class MyAgentList extends StatefulWidget {
  @override
  _MyAgentListState createState() => _MyAgentListState();
}

class _MyAgentListState extends State<MyAgentList> {
  final List<String> listOf = [
    "SMRITI LATIMBER",
    // "Renu",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 240,
      margin: (MediaQuery.of(context).size.width < 850 ||
              MediaQuery.of(context).size.height < 600)
          ? EdgeInsets.only(left: 16)
          : EdgeInsets.all(0),
      padding: EdgeInsets.all(6),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, int index) => listAgentItems(this.listOf[index]),
        itemCount: this.listOf.length,
      ),
    );
  }
}

class listAgentItems extends StatelessWidget {
  final String itemName;
  listAgentItems(this.itemName);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 220,
      margin: EdgeInsets.only(left: 0, right: 8, top: 0),
      padding: EdgeInsets.only(top: 8),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/female.png'),
              radius: 40,
            ),
          ),
          SizedBox(height: 10),
          Text(
            itemName,
            style: TextStyle(
                fontSize: 15,
                color: AppColors.BACKGROUND_COLOR,
                fontFamily: 'Lato'),
          ),
          Text(
            'Killer Villam Reality',
            style: TextStyle(
                fontSize: 10,
                color: AppColors.BACKGROUND_COLOR,
                fontFamily: 'Open'),
          ),
          Text(
            'jcho@kw.ocm',
            style: TextStyle(
                fontSize: 10,
                color: AppColors.BACKGROUND_COLOR,
                fontFamily: 'Open'),
          ),
          Container(
            child: Text(
              '9898989898',
              style: TextStyle(
                  fontSize: 10,
                  color: AppColors.BACKGROUND_COLOR,
                  fontFamily: 'Open'),
            ),
          ),
          SizedBox(height: 20),
          FlatButton(
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
        ],
      ),
    );
  }
}
