import 'package:get/get.dart';

class BottombarController extends GetxController {
  var spage = "0".obs;

  changeBottomTab(String val) {
    spage.value = val;
    print("get "+val);
  }


}
