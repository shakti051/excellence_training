import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginWithCredentials extends LoginEvent {
  String username;
  String password;
  LoginWithCredentials(this.username, this.password);
  @override
  List<Object> get props => [username, password];
}
class ForgotPassword extends LoginEvent{}