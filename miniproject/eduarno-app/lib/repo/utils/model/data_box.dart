import 'package:hive/hive.dart';

class Data {
  static Box<bool> boolBox = Hive.box<bool>('bool');
  static Box<String> stringBox = Hive.box<String>('string');
  static Box<int> intBox = Hive.box<int>('int');
}
