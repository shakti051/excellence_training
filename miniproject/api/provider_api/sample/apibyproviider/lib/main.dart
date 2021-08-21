import 'package:apibyproviider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ApiDatAcreen(),
      ),
    );
  }
}

class ApiDatAcreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BackendService(),
        child: Consumer<BackendService>(builder: (context, data, child) {
          if (data.getAppState == appSatte.INIT) {
            data.getData();
            return Center(child: CircularProgressIndicator());
          } else if (data.appState == appSatte.BUILD) {
            return Center(
              child: Text(data.model.title.toString()),
            );
          }
          return CircularProgressIndicator();
        }));
  }
}
