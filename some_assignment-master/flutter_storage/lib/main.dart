import 'package:flutter/material.dart';
import 'package:flutter_storage/bindings/home_bindings.dart';
import 'package:flutter_storage/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/home",
      getPages: [
        GetPage(name: '/home', page: () => HomePage(), binding: HomeBinding()),
      ],
      // home: HomePage(),
    );
  }
}

class HomePage extends GetView<HomeController> {
  final storage = GetStorage();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  if (GetUtils.isEmail(emailController.text)) {
                    storage.write("email", emailController.text);
                    emailController.text = '';
                  } else {
                    Get.snackbar("Incorect Email", "Provide a valid id",
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: Text("Submit")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  controller.updateEmail('${storage.read('email')}');
                },
                child: Text("View")),
            Obx(() {
              return Text("Email address: " + '${controller.email.value}');
            })
          ],
        ),
      ),
    );
  }
}
