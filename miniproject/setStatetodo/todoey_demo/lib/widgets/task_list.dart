import 'package:flutter/material.dart';
import 'package:todoey_demo/model/task.dart';
import 'package:todoey_demo/widgets/task_tile.dart';

class TaskList extends StatefulWidget {
  List<Task> tasks;
  TaskList({this.tasks});
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
              taskTitle: widget.tasks[index].name,
              isChecked: widget.tasks[index].isDone,
              checkboxCallback: (checkboxState) {
                setState(() {
                  widget.tasks[index].toggleDone();
                });
              });
        });
  }
}
