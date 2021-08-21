import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_apitesting/model/all_specialisatio.dart';
import 'package:http/http.dart' as http;

enum HomeState {
  Intial,
  Loading,
  Loaded,
  Error,
}

class SpecialisationProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Intial;
  HomeState get homeState => _homeState;
  String message = '';
  AllSpecialisation allSpecialisation;
  AllSpecialisation get yourSkills => allSpecialisation;
  
  SpecialisationProvider() {
    getAllSpecilasation();
  }

  Future<AllSpecialisation> getAllSpecilasation() async {
    _homeState = HomeState.Loading;
    try {
      final response = await http
          .get(Uri.parse("https://eduarno1.herokuapp.com/get_specialisations"));
      if (response.statusCode == 200) {
        allSpecialisation =
            AllSpecialisation.fromJson(json.decode(response.body));
        for (int i = 0; i < allSpecialisation.data.length; i++)
          print(allSpecialisation.data[i].specialisation);
        _homeState = HomeState.Loaded;
        notifyListeners();
        return allSpecialisation;
      }
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
      notifyListeners();
    }
  }

  delete(int index) {
    allSpecialisation.data.removeAt(index);
    notifyListeners();
  }
}
