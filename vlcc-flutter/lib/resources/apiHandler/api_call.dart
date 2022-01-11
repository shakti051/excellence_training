import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/screens/packages/package_routes.dart';

class Services {
  static const baseUrl = 'http://lms.vlccwellness.com';
  static const baseUrlHTTPS = 'https://lms.vlccwellness.com';
  static const httpsBaseUrl = 'https://www.vlccwellness.com';
  static const auth = '';
  final VlccShared sharedPrefs = VlccShared();
  // final Get
  Future<http.StreamedResponse> patchProfileImage(
      {required String url, required String filepath}) async {
    url = baseUrl + url;
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('client_pic', filepath));
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });
    var response = request.send();
    //log(response.toString());
    return response;
  }

  Future<http.Response> uploadImage(
      {required File? file, bool isHttp = true}) async {
    var apiUrl =
        '${isHttp ? baseUrl : httpsBaseUrl}/api/api_client_profile_update.php?request=client_profile_update';
    Uri uri = Uri.parse(apiUrl);
    var fileStream = http.ByteStream(Stream.castFrom(file!.openRead()));
    var length = await file.length();
    var request = http.MultipartRequest("POST", uri);
    String mimeType = mime(basename(file.path)) ?? '';
    String mimee = mimeType.split('/')[0];
    String type = mimeType.split('/')[1];
    var multipartFile = http.MultipartFile('files', fileStream, length,
        filename: basename(file.path), contentType: MediaType(mimee, type));
    request.files.add(multipartFile);
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    request.fields.addAll(headers);
    var response = await request.send();
    var finalResponse = await http.Response.fromStream(response);
    return finalResponse;
  }

  Future<dynamic> callApi(Map<String, dynamic> body, String url,
      {String apiName = 'Post', bool isHttp = true}) async {
    Uri uri = Uri.parse((isHttp ? baseUrl : httpsBaseUrl) + url);
    try {
      final response = await http.post(
        uri,
        body: body,
      );
      var returnResponse = _returnResponse(response, apiName);
      var jsonTest = json.decode(returnResponse);
      if (jsonTest['Status'] == 2002) {
        sharedPrefs.signOut().then((value) {
          Get.clearTranslations();
          Get.toNamed(PackageRoutes.welcomeScreen);
          Get.snackbar(
            'Security breach!!!',
            'Another user has logged in with your credentials...',
            backgroundColor: AppColors.orange,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        });
      } else {
      log(response.body,name: "response");
        return _returnResponse(response, apiName);
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<dynamic> get({required String endpoint, bool isHttp = false}) async {
    try {
      final response = await http.get(
        Uri.parse((isHttp ? baseUrl : baseUrlHTTPS) + endpoint),
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
        // var body = json.decode(response.body.toString());
        log(response.body, name: apiName);
        return response.body;
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

  @override
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
