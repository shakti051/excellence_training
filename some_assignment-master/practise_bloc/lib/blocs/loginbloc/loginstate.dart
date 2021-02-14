import 'package:equatable/equatable.dart';
//import 'package:formz/formz.dart';

class LoginState extends Equatable {
  LoginState();
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  String message;
  LoginSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class LoginFalure extends LoginState {
  String message;
  LoginFalure(this.message);
  @override
  List<Object> get props => [message];
}