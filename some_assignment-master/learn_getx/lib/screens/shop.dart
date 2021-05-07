import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/screens/cart.dart';
import 'package:learn_getx/screens/controller/home_controller.dart';

class Shop extends StatelessWidget {
  HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shop Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text(Get.arguments),
            Text("${Get.parameters['product_variable']}"),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Get.offNamed('/cart');
                  // Get.offAllNamed('/cart');
                  //Get.off(Cart());
                  //Get.offAll(Cart());
                },
                child: Text("Go to cart")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                  //Get.back(result: "success");
                },
                child: Text("Back to main"))
          ],
        ),
      ),
    );
  }
}
