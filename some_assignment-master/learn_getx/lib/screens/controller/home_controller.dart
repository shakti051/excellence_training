import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // String status = "online";
  var status = "online".obs;
  var followers = 50.obs;
  //int followers = 50;
  void onInit() {
    // ever(status, (_) {
    //   print("Ever Worker");
    // });
    everAll([status, followers], (_) {
      print("Status or follower value changed");
    });
    // once(status, (_) {
    //   print("Status or followers changed once");
    // });
    // debounce(status, (_) {                       It is used for searching purpose
    //   print("Debounce WOrker");
    // },time: Duration(seconds: 1));
    super.onInit();
  }

  void updateStatus(String newStatus) {
    status.value = newStatus;
    // status = newStatus;
    //update(['status_widget']);
  }
}
