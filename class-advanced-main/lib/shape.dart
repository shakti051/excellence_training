import 'dart:math';

abstract class Shape {
  double get area;

}

class Square extends Shape {
  final double side;
  Square(this.side);
  @override
  double get area => side * side;
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
  @override
  // TODO: implement area
  double get area => pi *radius*radius;
}
void printArea(Shape shape) {
  print(shape.area);
}


