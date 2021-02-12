import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExplorerScreen extends StatefulWidget {
  @override
  _ExplorerScreenState createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      height: Get.height,
      width: Get.width,
    );
  }
}
