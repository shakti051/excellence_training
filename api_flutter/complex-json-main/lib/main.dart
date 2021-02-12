import 'package:complex_json/home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List listOf = await getAllData();
  runApp(MyApp(listOf));
}

class MyApp extends StatelessWidget {
  List listOf;
  MyApp(this.listOf);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(listOf),
    );
  }
}

Future<List> getAllData() async {
  var api = "https://jsonplaceholder.typicode.com/users";
  var data = await http.get(api);
  var jsonData = json.decode(data.body);
  return jsonData;
}
