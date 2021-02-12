import 'package:feedback/main.dart';
import 'package:feedback/widgets/search.dart';
import 'package:flutter/material.dart';

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Column(
              children: <Widget>[
                Menu(),
              ],
            ),
            Column(
              children: <Widget>[
                SearchBar(),
                Container(
                    margin: EdgeInsets.all(32),
                    child: Text(
                      'This is sales page',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
