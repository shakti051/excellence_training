import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vlcc/mixins/validation_mixin.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with ValidationMixin, InputValidationMixin {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Form validation example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formGlobalKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  maxLength: 150,
                  obscureText: true,
                  // validator: (String? password) {
                  //   if (validatePassword(password!))
                  //     return null;
                  //   else
                  //     return 'Enter a valid password';
                  // },
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      if (formGlobalKey.currentState!.validate()) {
                        formGlobalKey.currentState!.save();
                        // use the email provided here
                        log("object");
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ));
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;
}
