import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Flutter Dialog'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          width: 300,
          child: RaisedButton(
            onPressed: () {
//              alertDialog(context);
              customDialog();
            },
            child: Text(
              'Dialog Show',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            color: Colors.deepOrange,
            elevation: 20,
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  /* void alertDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Text('We are learning Alert Dialog'),
      content: Text('Flutter is pretty goood.'),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('YES',style: TextStyle(fontSize:20 ),))
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext c) {
          return alert;
        });
  }
  */

  customDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext c) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 450,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepOrange),
              child: Column(
                children: <Widget>[
                  Image.network(
                    'https://images.pexels.com/photos/169647/pexels-photo-169647.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: <Widget>[
                    new Expanded(
                        child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: Center(
                          child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Remove',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )),
                    )),
                    SizedBox(width: 15),
                    new Expanded(
                        child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: Center(
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Add',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)))),
                    )),
                  ])
                ],
              ),
            ),
          );
        });
  }
}
