import 'package:flutter/material.dart';

class SessionProvider extends ChangeNotifier {
  String url = '';
  int _noOfSessions = 0;
  int get noOfSessions => _noOfSessions;
  List<String> _posted_url = List.generate(100, (index) => '');
  List<String> get posted_url {
    print('Posted Url array ---------> $_posted_url');
    return _posted_url;
  }

  // void addElement() {
  //   _posted_url.add('');
  //   notifyListeners();
  // }

  set noOfSessions(int value) {
    _noOfSessions = value;
    _posted_url = List.generate(value, (index) => '');
    print('At session screen --> $_posted_url');
    notifyListeners();
  }

  // List<String> posted_url = [];

  // SessionProvider({this.url});
  // String get getUrl {
  //   return url;
  // }

  // set setUrl(String url) {
  //   this.url = url;
  //   notifyListeners();
  // }

  // String updateUrl(String newUrl) {
  //   url = newUrl;
  //   print("url is:  " + url);
  //   notifyListeners();
  // }

  void setPostedUrl(String url, int index) {
    _posted_url.insert(index, url);
    notifyListeners();
  }

  void removeUrl(int index) {
    _posted_url.removeAt(index);
    notifyListeners();
  }
}

// class SessionProvider extends ChangeNotifier {
//   static final SessionProvider _singleton = SessionProvider._internal();

//   factory SessionProvider() {
//     return _singleton;
//   }

//   SessionProvider._internal();
//   List<String> _posted_url = [''];
//   List<String> get posted_url => _posted_url;

//   void setPostedUrl(
//     String url,
//   ) {
//     _posted_url.add(url);
//     notifyListeners();
//   }

//   void removeUrl(int index) {
//     _posted_url.removeAt(index);
//     notifyListeners();
//   }
// }
