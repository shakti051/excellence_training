import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_apitesting/model/all_specialisatio.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyData(),
    );
  }
}

class MyData extends StatefulWidget {
  const MyData({Key key}) : super(key: key);

  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  AllSpecialisation allSpecialisation;
  bool apiHit = false;

  Future<AllSpecialisation> getAllSpecilasation() async {
    final response = await http
        .get(Uri.parse("https://eduarno1.herokuapp.com/get_specialisations"));
    if (response.statusCode == 200) {
      allSpecialisation =
          AllSpecialisation.fromJson(json.decode(response.body));
       //print(allSpecialisation.data[0].specialisation);
      setState(() {
        apiHit = true;
      });
      return allSpecialisation;
    } else {
      throw Exception('Failed to load specialisation');
    }
  }

  @override
  void initState() {
    getAllSpecilasation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return apiHit
        ? ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: allSpecialisation.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.only(left: 8, bottom: 8),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(allSpecialisation.data[index].specialisation,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 14)));
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
