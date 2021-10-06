import 'package:flutter/material.dart';

class MyNoData extends StatelessWidget {
  final String message;
  const MyNoData({Key key, this.message = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              child: Image.asset(
                'assets/no_data_found.png',
                // color: Colors.white,
                height: 200,
                width: 500,
              ),
            ),
          ),
          Center(
              child: Text(
            message,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}
