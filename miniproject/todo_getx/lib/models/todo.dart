
class Todo {
  String title;
  bool done;
  Todo({this.title, this.done = false});

  factory Todo.fromJson(Map<String, dynamic> json) =>
      Todo(title: json['title'], done: json['done']);

  Map<String, dynamic> toJosn() => {'title': title, 'done': done};
}