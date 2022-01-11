import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final JsonDecoder _decoder = const JsonDecoder();
  Future<dynamic> post(Uri url,
      {Map<String, String>? headers, body, encoding}) async {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}
