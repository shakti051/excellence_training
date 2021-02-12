import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.red,
              backgroundImage: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            ),
            Text('Shakti Triparhi ',
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            Text(
              'FLUTTER DEVELOPER ',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SourceSans',
                  color: Colors.teal.shade100,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
              width: 150,
              child: Divider(
                color:Colors.teal[100]
              ),
            ),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal,
                  ),
                  title: Text(
                    '+44 123 459 789',
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontFamily: 'SourceSans',
                        fontSize: 20),
                  ),
                )),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'shakti@excellencetechnologies.in',
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontFamily: 'SourceSans',
                        fontSize: 20),
                  ),
                )),
          ],
        )),
      ),
    );
  }
}
