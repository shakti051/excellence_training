import 'package:flutter/material.dart';
import 'package:todoey_demo/model/task_data.dart';
import 'package:todoey_demo/screens/add_task_screen.dart';
import 'package:todoey_demo/widgets/task_list.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) => SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddTaskScreen())));
          },
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.add)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                  child:
                      Icon(Icons.list, size: 30, color: Colors.lightBlueAccent),
                  backgroundColor: Colors.white,
                  radius: 30),
              SizedBox(height: 10),
              Text(
                "Todoey",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w700),
              ),
              Text('${Provider.of<TaskData>(context).tasks.length} Tasks',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ]),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: TaskList(),
            ),
          ),
        ],
      ),
    );
  }
}
