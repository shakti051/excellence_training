import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  JsonDecoder _decoder = JsonDecoder();
  Future<dynamic> post(String url, {Map header, body, encoding}) async {
    return http
        .post(url, body: body, headers: header, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return _decoder.convert(res);
      } else {
        throw Exception('invalid response');
      }
    });
  }
}
