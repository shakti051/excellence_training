import 'package:flutter/material.dart';
import 'package:loginstate/src/mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(),
            passwordFeild(),
            Container(margin: EdgeInsets.only(top: 25)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Email Address", hintText: 'you@gmail.com'),
      validator: validateEmail,
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordFeild() {
    return TextFormField(
        obscureText: true,
        decoration:
            InputDecoration(labelText: 'Password', hintText: 'Password'),
        validator: validatePassword,
        onSaved: (String value) {
          password = value;
        });
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          formKey.currentState.reset();
          print("The to send $email and $password to API");
        }
      },
      child: Text('Submit'),
    );
  }
}

