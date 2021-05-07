import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/screens/controller/home_controller.dart';

class Cart extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${controller.status}'),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Back to main"))
          ],
        ),
      ),
    );
  }
}