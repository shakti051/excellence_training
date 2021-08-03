import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_demo/model/task.dart';
import 'package:todoey_demo/model/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  String newTaskTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text("Add Task",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.lightBlueAccent)),
            TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  newTaskTitle = newText;
                }),
            SizedBox(height: 16),
            FlatButton(
                color: Colors.lightBlueAccent,
                child: Text("Add", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Provider.of<TaskData>(context).addTask(newTaskTitle);
                  Navigator.pop(context);
                })
          ]),
        ));
  }
}