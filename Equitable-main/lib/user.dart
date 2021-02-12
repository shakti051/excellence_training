import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String prefrences;
  User(this.name, this.prefrences);

  @override
  List<Object> get props => [name, prefrences];
  @override
  bool get stringify => true;
}
