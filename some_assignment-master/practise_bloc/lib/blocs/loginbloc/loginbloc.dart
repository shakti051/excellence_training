import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_bloc/blocs/loginbloc/loginevent.dart';
import 'package:practise_bloc/blocs/loginbloc/loginstate.dart';
import 'package:practise_bloc/services/loginservice.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithCredentials) {
      yield* _mapLoginWithCredentialsToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsToState(
      LoginWithCredentials event) async* {
    var responseError;
    await fetchData(event.username, event.password).then((value) {
      responseError = value.error;
    });
    if (responseError == 0) {
      yield LoginSuccess('SUCCESS');
    } else if (responseError == 1) {
      yield LoginFalure('FAIL');
    }
  }
}