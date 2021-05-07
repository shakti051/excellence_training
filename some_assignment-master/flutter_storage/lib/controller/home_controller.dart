import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
 
  var email = "".obs;
  
  void updateEmail(String newEmail) {
    email.value = newEmail;
  }
}
