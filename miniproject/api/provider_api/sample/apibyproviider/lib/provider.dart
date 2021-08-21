import 'dart:convert';
import 'package:apibyproviider/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

enum appSatte{
  INIT,BUILD,DISPOSE
}

class BackendService extends ChangeNotifier{
   appSatte appState=appSatte.INIT;

   appSatte get getAppState=>appState;

  Model model=Model();

  Model get useModel=> model;

  getData() async{
    final response = await get(Uri.parse('https://jsonplaceholder.typicode.com/posts/10'));
    model=Model.fromJson(jsonDecode(response.body));
    appState=appSatte.BUILD;
    notifyListeners();
  }
}