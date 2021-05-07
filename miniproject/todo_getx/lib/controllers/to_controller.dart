import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_getx/models/todo.dart';

class TodoController extends GetxController {
  //var todos = List<Todo>().obs;
  var todos = [].obs;
  @override
  void onInit() {
    List storedTodos = GetStorage().read<List>('todos');
    if (storedTodos != null) {
      todos = storedTodos.map((e) => Todo.fromJson(e)).toList().obs;
    }

    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}
