import 'dart:html';

import 'package:learn_dart/point.dart';
import 'package:learn_dart/shape.dart';
import 'package:learn_dart/stack.dart';

class Animal {
  final int age;

  Animal({this.age});

  void sleep() => print('sleep');
}

class Dog extends Animal {
  Dog({int age}) : super(age: age);

  void bark() => print('bark');
  @override
  void sleep() {
    super.sleep();
    print('sleep some more');
  }
}

class Cow extends Animal {
  Cow({int age}) : super(age: age);

  void moo() => print('moo');
}

class CleaverDog extends Dog {
  CleaverDog({int age}) : super(age: age);
  void catchBall() => print('Catch Ball');
}

void main() {
  final animal = Animal(age: 10);
  //animal.sleep();
  final dog = Dog(age: 10);
  dog.sleep();
  final square = Square(10);
  print(square.area);
  final circle = Circle(14);
  print(circle.area);
  printArea(circle);
  final shapes = [Square(20), Circle(27)];
  shapes.forEach((shape) {
    return printArea(shape);
  });
  print(Point(1, 1));
  const list = [Point(1, 2), Point(2, 3)];
  print(list);
  print(Point(0, 0) == Point(0, 0));
  print(Point(1, 1) + Point(2, 0));
  print(Point(2, 1) * 5);
  final stack = Stack<int>();
  stack.push(1);
  stack.push(2);
  print(stack.pop());
  print(stack.pop());
  final names = Stack<String>();
  names.push('Andrea');
  names.push('Alice');
}
