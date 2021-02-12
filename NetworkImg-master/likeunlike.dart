import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool liked = false;

  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter 1.9'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          ListTile(
              leading: IconButton(
            icon: Icon(
              liked ? Icons.favorite : Icons.favorite_border,
              color: liked ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              _pressed();
            },
          )),
        ],
      )),
    );
  }
}
