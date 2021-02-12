import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _currentDate = DateTime.now();

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime _selDate = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2025),
        builder: (context,child){
            return SingleChildScrollView(child:child);
        }
        );
        if(_selDate!=null){
          setState(() {
          _currentDate = _selDate;
          });
        }
  }

  @override
  Widget build(BuildContext context) {
    String _formattedDate = DateFormat.yMMMd().format(_currentDate);
    return Scaffold(
      appBar: AppBar(
        title: Text("Date Picker Demo"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                _selectedDate(context);
              })
        ],
      ),
      body: Center(child: Text("Date $_formattedDate")),
    );
  }
}
