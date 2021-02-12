import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

class Point extends Equatable {
  final int x;
  final int y;

  const Point(this.x, this.y);

  // @override
  // String toString() => 'Ponit($x,$y)';

  @override
  // TODO: implement props
  List<Object> get props => [x,y];

  @override
  bool get stringify => true;
  
  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

  // @override
  // bool operator ==(covariant Point other) {
  //   if (other is Point) {
  //     return x == other.x && y == other.y;
  //   }
  //   return false;
  // }

  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
  }

  Point operator *(int other) {
    return Point(x * other, y * other);
  }
}