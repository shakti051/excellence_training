import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleprovider/Home.dart';
import 'package:sampleprovider/dataModelClass.dart';
import 'package:sampleprovider/model.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => DataModel())],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DataModel coinData = DataModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: "Test App",
      home: Home(),
    );
  }
}
