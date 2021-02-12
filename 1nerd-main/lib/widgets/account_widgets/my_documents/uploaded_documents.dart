import 'package:flutter/material.dart';

class UploadedDocuments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: Colors.white,
      width: (MediaQuery.of(context).size.width < 850 ||
              MediaQuery.of(context).size.height < 600)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width - 200,
      padding: EdgeInsets.only(left: 16),
      margin: (MediaQuery.of(context).size.width < 850 ||
              MediaQuery.of(context).size.height < 600)
          ? EdgeInsets.only(left: 16, right: 16)
          : EdgeInsets.all(0),
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return DocList();
        },
      ),
    );
  }
}

class DocList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Container(
          margin: EdgeInsets.only(right: 16),
          child: Image(
            image: AssetImage('assets/images/pdf.png'),
            width: 50,
            height: 70,
          ),
        ),
        Container(
            width: 50,
            margin: EdgeInsets.only(right: 16),
            child: Text(
              'id',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ))
      ],
    );
  }
}
