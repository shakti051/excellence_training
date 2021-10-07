import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class Services {
  static const baseUrl = 'http://lms.vlccwellness.com';
  static const auth = '';

  Future<dynamic> callApi(Map<String, dynamic> body, String url) async {
    Uri uri = Uri.parse(baseUrl + url);
    try {
      final response = await http.post(
        uri,
       // headers: {'Content-Type': 'application/json'},
        body: body,
      );
      print(response.body);
      return _returnResponse(response, 'Post body');
    
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + url),
        headers: {'Content-Type': 'application/json'},
      );
      var body = _returnResponse(response, 'Get API');
      return body;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  dynamic _returnResponse(http.Response response, String apiName) {
    switch (response.statusCode) {
      case 200:
        var body = response.body.toString();
        log(body, name: apiName);
        return body;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}