import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //  mainAxisAlignment: MainAxisAlignment.center,
            //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //  verticalDirection: VerticalDirection.down,
            //  mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Colors.teal,
                child: Text('container 1'),
                height: 100,
                width: 100,
              ),
              SizedBox(height: 20,),
              Container(
                color: Colors.blue,
                child: Text('container 2'),
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.pink,
                child: Text('container 3'),
                height: 100,
                width: 100,
              ),

              /*  Container(
                height: 10,
                width: double.infinity,
              ),*/
            ],
          ),
        ),
      ),
    ),
  );
}
