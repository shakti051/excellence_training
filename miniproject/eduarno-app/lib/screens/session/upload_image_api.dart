import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class UploadImageApi {
  Future<http.Response> uploadImage(
      { File file}) async {
    final apiUrl = 'https://eduarno1.herokuapp.com/upload_files_content';
    Uri uri = Uri.parse(apiUrl);
    var fileStream =
        http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    var request = http.MultipartRequest("POST", uri);
    String mimeType = mime(basename(file.path));
    String mimee = mimeType.split('/')[0];
    String type = mimeType.split('/')[1];
    var multipartFile = http.MultipartFile('files', fileStream, length,
        filename: basename(file.path), contentType: MediaType(mimee, type));
    request.files.add(multipartFile);
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    request.fields.addAll(headers);
    var response = await request.send();
      var finalResponse = await http.Response.fromStream(response);
     // print("final>>>>>>>>>>>>>>>>>>>>>>>>>"+finalResponse.body);
      return finalResponse;
    // return await request.send().then((result) async {
    //   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>"+result.toString());
    //   return await http.Response.fromStream(result);
    // });
  }
}
