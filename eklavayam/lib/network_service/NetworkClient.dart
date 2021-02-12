import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BackendUrl.dart';


class NetworkClient{
  static BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        } else {
          return false;
        }
      });

  static Dio dio = Dio(options);


  Future<dynamic> getLoginDetails(String path) async {


    try {
      Options options = Options(
          contentType: 'application/json',

        );

      var response = await dio.post(path, options: options);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
       // var responseJson = json.decode(response.data);
       // print(responseJson);
        return response.data;
      }
      else if(response.statusCode==429){
        print("Error: " + 'Error while communicating with server. Please try again after some time.');
      }else {
        print("Error: " + response.statusCode.toString());
      }

    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        print("Error: " + "Network Error");
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        print("Error: " +
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }

  Future<dynamic> getApiCall(String path) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String access_token = sharedPreferences.getString("access_token");
    access_token="Bearer  eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNjAzMjcyMjU5fQ.i-sxjrrd-DatnsNmBmjpKYef5y43xRN2ULS18WfJX2M";
    try {
      Options options = Options(
          contentType: 'application/json',
          headers: {"Authorization": access_token,
          },
        );


      var response = await dio.post(path, options: options);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(response.data);
        // var responseJson = json.decode(response.data);
        // print(responseJson);
        return response.data;
      }
      else if(response.statusCode==429){
        print("Error: " + 'Error while communicating with server. Please try again after some time.');
      }else {
        print("Error: " + response.statusCode.toString());
      }

    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        print("Error: " + "Network Error");
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        print("Error: " +
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }


  Future<dynamic> postData(String path,var jdata) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String access_token = sharedPreferences.getString("access_token");

   // print("networkclientpost> "+access_token);
    access_token="Bearer  eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNjAzMjcyMjU5fQ.i-sxjrrd-DatnsNmBmjpKYef5y43xRN2ULS18WfJX2M";
  // access_token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNjAzMjcyMjU5fQ.i-sxjrrd-DatnsNmBmjpKYef5y43xRN2ULS18WfJX2M";

    try {
      Options options = Options(
        contentType: 'application/json',
        headers: {"Authorization": access_token,
        },

      );

      var response = await dio.post(path, options: options,data: jdata);
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        // var responseJson = json.decode(response.data);
        // print(responseJson);
        return response.data;
      }
      else if(response.statusCode==429){
        print("Error: " + 'Error while communicating with server. Please try again after some time.');
      }else {
        print("Error: " + response.statusCode.toString());
      }

    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        print("Error: " + "Network Error");
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        print("Error: " +
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }

  Future<dynamic> uploadImage(File file) async {

    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String access_token = sharedPreferences.getString("access_token");
    //
    // print("networkclientpost> "+access_token);
    // access_token="Bearer  eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNjAzMjcyMjU5fQ.i-sxjrrd-DatnsNmBmjpKYef5y43xRN2ULS18WfJX2M";
    // // access_token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNjAzMjcyMjU5fQ.i-sxjrrd-DatnsNmBmjpKYef5y43xRN2ULS18WfJX2M";

    try {
      Options options = Options(
        //contentType: 'application/json'
       // headers: {"Authorization": access_token,
        //},

      );
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file":
        await MultipartFile.fromFile(file.path, filename:fileName),
      });

      var response = await dio.post("uploadImages",options: options, data: formData);
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        // var responseJson = json.decode(response.data);
        // print(responseJson);
        return response.data;
      }
      else if(response.statusCode==429){
        print("Error: " + 'Error while communicating with server. Please try again after some time.');
      }else {
        print("Error: " + response.statusCode.toString());
      }

    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        print("Error: " + "Network Error");
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        print("Error: " +
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }

  // Future<String> uploadImage(File file) async {
  //   String fileName = file.path.split('/').last;
  //   FormData formData = FormData.fromMap({
  //     "file":
  //     await MultipartFile.fromFile(file.path, filename:fileName),
  //   });
  //   response = await dio.post("/upload", data: formData);
  //   return response.data['id'];
  // }
}