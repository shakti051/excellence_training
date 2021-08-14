import 'package:flutter/material.dart';
import 'package:todoey_demo/model/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier{
    List<Task> _tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'Buy Bread'),
    Task(name: 'Buy lentils'),
  ];
   
   UnmodifiableListView<Task> get tasks{
     return UnmodifiableListView(_tasks);
   }

    int get taskCount{
    return _tasks.length;
    }
   
    void addTask(String newTaskTile){
      final task = Task(name: newTaskTile);
      _tasks.add(task);
      notifyListeners();
    }

    void updateTask(Task task){
      task.toggleDone();
      notifyListeners();     
    }

    void deleteTask(Task task){
        _tasks.remove(task);
        notifyListeners();
    }   
}