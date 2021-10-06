import 'dart:convert';
import 'package:eduarno/Utilities/constants.dart';
import 'package:http/http.dart' as http;

Future<dynamic> callApi(Map<String, dynamic> body, String apiUrl,
    [bool isCompleteUrl = false]) async {
  // print(
  //     "//////--------->Request Data ----> ${json.encode(body).toString()}/n/////////////");
  final String url = isCompleteUrl ? apiUrl : '$kBaseApiUrl/$apiUrl';
  Uri uri = Uri.parse(url);
  try {
    // print("add data body : ${body.toString()}");
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    print('Response code - ${response.statusCode}');
    print("data -> ${response.body}");

    // var bodyData = ;
    // print("data -> ${response.body}");
    return json.decode(response.body);
  } catch (e) {
    print('Error of callApi = $e and url = $uri');
    return {'code': -999};
  }
}

Future<dynamic> callGetApi(String apiUrl, [bool isCompleteUrl = false]) async {
  final String url = isCompleteUrl ? apiUrl : '$kBaseApiUrl/$apiUrl';
  Uri uri = Uri.parse(url);
  try {
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    print("${response.body}");
    return json.decode(response.body);
  } catch (e) {
    print('Error of callApi = $e and url = $apiUrl');
    return {'code': -999};
  }
}
