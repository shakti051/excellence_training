import 'package:flutter/material.dart';
import 'package:todo_getx/controllers/to_controller.dart';
import 'package:get/get.dart';
import 'package:todo_getx/models/todo.dart';

class TodoEdit extends StatelessWidget {
  final int index;
  TodoEdit({@required this.index});
  final TodoController todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: todoController.todos[index].title);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                  child: TextField(
                controller: textEditingController,
                decoration:
                    InputDecoration(hintText: "", border: InputBorder.none),
                autofocus: true,
                style: TextStyle(fontSize: 25),
                keyboardType: TextInputType.multiline,
                maxLines: 10,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child:
                          Text("Cancel", style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        var edting = todoController.todos[index];
                        edting.title = textEditingController.text;
                        todoController.todos[index] = edting;
                        Get.back();
                      },
                      child: Text("Update"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
