import 'package:flutter/material.dart';
import 'package:todoey_demo/model/task_data.dart';
import 'package:todoey_demo/screens/tasks_screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create: (context) => TaskData(),
          child: MaterialApp(
          home: TasksScreen(),
      ),
    );
  }
}
