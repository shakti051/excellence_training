import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        // textDirection: TextDirection.ltr,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
              
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Container(
                          color: Colors.teal, child: Text('container 1',textAlign:TextAlign.center,),width: 200,),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                          color: Colors.blue, child: Text('container 2',textAlign:TextAlign.center),width: 200,),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                          color: Colors.pink, child: Text('container 3',textAlign:TextAlign.center),width: 200,),
                    ),
                  ),
                ]),
            //place here   theother
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Container(
                          color: Colors.pink, child: Text('container 4',textAlign:TextAlign.center),width: 200,),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                          color: Colors.purple, child: Text('container 5',textAlign:TextAlign.center),width: 200,),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                          color: Colors.blueAccent, child: Text('container 6',textAlign:TextAlign.center),width: 200,),
                    ),
                  ),
                ]), //place here

            Column(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        color: Colors.teal, child: Text('container 7',textAlign:TextAlign.center),width: 200,),
                  ),
                  Expanded(
                    child: Container(
                        color: Colors.blue, child: Text('container 8',textAlign:TextAlign.center),width: 200,),
                  ),
                  Expanded(
                    child: Container(
                        color: Colors.pink, child: Text('container 9',textAlign:TextAlign.center),width: 200,),
                  ),
                ]),
          ],
        )),
      ),
    ),
  );
}
