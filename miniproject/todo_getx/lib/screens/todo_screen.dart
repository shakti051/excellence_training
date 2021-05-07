import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/to_controller.dart';
import 'package:todo_getx/models/todo.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find<TodoController>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                  child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "What you want to accomodate",
                    border: InputBorder.none),
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
                        todoController.todos
                            .add(Todo(title: textEditingController.text));
                        Get.back();
                      },
                      child: Text("Add"),
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