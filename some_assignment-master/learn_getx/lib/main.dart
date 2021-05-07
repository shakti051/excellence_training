import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/screens/bindings/home_bindings.dart';
import 'package:learn_getx/screens/cart.dart';
import 'package:learn_getx/screens/controller/home_controller.dart';
import 'package:learn_getx/screens/shop.dart';
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
      initialRoute: "/home",
      smartManagement: SmartManagement.full,
      // initialBinding: HomeBinding(),
      getPages: [
        GetPage(name: '/home', page: () => HomePage(), binding: HomeBinding()),
        GetPage(name: '/cart', page: () => Cart()),
        GetPage(name: '/shop/:product_variable', page: () => Shop()),
      ],
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
//      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // HomeController homeController = Get.put(HomeController(),permanent: true);
  HomeController homeController = Get.find<HomeController>();
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<HomeController>(
                id: "follower_widget",
                builder: (_) {
                  print("follower widget rebuid");
                  return Text("${homeController.followers}");
                }),
            GetX<HomeController>(builder: (_) {
              print("status widget rebuild");
              return Text("${homeController.status.value}");
            }),
            Obx(() {
              print("status widget rebuild");
              return Text("${homeController.status.value}");
            }),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  homeController.updateStatus("offline");
                },
                child: Text("logout")),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                Get.snackbar("success", "This is snackbar",
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: Colors.black,
                    backgroundColor: Colors.lightBlueAccent,
                    borderRadius: 30,
                    margin: EdgeInsets.all(10),
                    icon: Icon(Icons.check, color: Colors.white),
                    mainButton:
                        TextButton(onPressed: null, child: Text("My Cart")),
                    padding: EdgeInsets.all(10));
              },
              child: Text("Show Snackbar"),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Are You sure ?",
                  content: Text("Are you going to delete Account"),
                  backgroundColor: Colors.yellow,
                  textConfirm: "Yes",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Navigator.pop(context);
                  },
                  //barrierDismissible: true
                );
              },
              child: Text("Show Dialog"),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                Get.bottomSheet(
                    Container(
                        height: 200,
                        color: Colors.orange,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircularProgressIndicator(),
                              Icon(Icons.message, color: Colors.white, size: 20)
                            ])),
                    isDismissible: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)));
              },
              child: Text("Show Bottomsheet"),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                Get.toNamed('/shop/Macbook');
                // String status =
                //     await Get.to(Shop(), arguments: "Vikas Agarwal");
                // print(status);
              },
              child: Text("Go To Shop"),
            ),
          ],
        ),
      ),
    );
  }
}