import 'package:flutter/material.dart';
import 'package:todoey_demo/model/task_data.dart';
import 'package:todoey_demo/widgets/task_tile.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
            itemCount: taskData.taskCount,
            itemBuilder: (context, index) {
              final task = taskData.tasks[index];
              return TaskTile(
                  taskTitle: Provider.of<TaskData>(context).tasks[index].name,
                  isChecked: taskData.tasks[index].isDone,
                  checkboxCallback: (checkboxState) {
                    taskData.updateTask(task);
                  },
                  longPressCallback: (){
                    taskData.deleteTask(task);
                  },
                  );
            });
      },
    );
  }
}
