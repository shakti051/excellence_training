import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/to_controller.dart';
import 'package:todo_getx/screens/edit_todo.dart';
import 'package:todo_getx/screens/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Getx Todo")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(TodoScreen());
        },
      ),
      body: Container(child: Obx(() {
        return ListView.separated(
            itemBuilder: (context, index) => Dismissible(
                  background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white)),
                  key: UniqueKey(),
                  onDismissed: (_) {
                    todoController.todos.removeAt(index);
                    Get.snackbar("Removed", "Task was successfully deleted",
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  child: ListTile(
                    onTap: () {
                      Get.to(TodoEdit(index: index));
                    },
                    title: Text(todoController.todos[index].title,
                        style: todoController.todos[index].done
                            ? TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough)
                            : TextStyle(color: Colors.black)),
                    leading: Checkbox(
                      value: todoController.todos[index].done,
                      onChanged: (newvalue) {
                        var todo = todoController.todos[index];
                        todo.done = newvalue;
                        todoController.todos[index] = todo;
                      },
                    ),
                    trailing: Icon(Icons.edit),
                  ),
                ),
            separatorBuilder: (context, pos) => Divider(),
            itemCount: todoController.todos.length);
      })),
    );
  }
}
