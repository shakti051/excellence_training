import 'package:eduarno/repo/bloc/user.dart';
import 'package:flutter/material.dart';

class TestBuildScreen extends StatefulWidget {
  const TestBuildScreen({Key key}) : super(key: key);

  @override
  _TestBuildScreenState createState() => _TestBuildScreenState();
}

class _TestBuildScreenState extends State<TestBuildScreen> {
  @override
  void initState() {
    super.initState();
    print('Get assessment data values --------------> ${User().interestAdded}');
    print(
        'Get assessment is new user values --------------> ${User().isNewUser}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is demo screen'),
    );
  }
}
