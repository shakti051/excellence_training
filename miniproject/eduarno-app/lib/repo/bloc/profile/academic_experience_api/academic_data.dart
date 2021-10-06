import 'dart:convert';
import 'package:eduarno/repo/bloc/profile/model/academic_model.dart';
import 'package:eduarno/repo/bloc/profile/model/experience_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AcademicProvide extends ChangeNotifier {
  static final AcademicProvide _singleton = AcademicProvide._internal();

  factory AcademicProvide() {
    return _singleton;
  }

  AcademicProvide._internal();

  List<Academic> _academic_detail_List = [];
  List<Experience> _experience_detail_List = [];

  List get academic_detail_List => _academic_detail_List;
  List get experience_detail_List => _experience_detail_List;

  String academicId;
  String experienceId;

  // set setExperienceData(Map<String, dynamic> value) {
  //   _experience_detail_List.add(value);
  //   notifyListeners();
  // }

  // set setAcademicData(Map<String, dynamic> value) {
  //   _academic_detail_List.add(value);
  //   notifyListeners();
  // }

  var academicUpdateUrl =
      'https://eduarno1.herokuapp.com/user/update_academic_profile_by_user_id';
  var academicPostUrl =
      'https://eduarno1.herokuapp.com/user/insert_academic_profile_by_user_id';
  var academicGetUrl =
      'https://eduarno1.herokuapp.com/user/get_academic_profile_by_user_id';

  var academicDeleteUrl =
      'https://eduarno1.herokuapp.com/user/delete_academic_profile_by_user_id';

  var experienceUpdateUrl =
      'https://eduarno1.herokuapp.com/user/update_experience_profile_by_user_id';

  var experiencePostUrl =
      'https://eduarno1.herokuapp.com/user/insert_experience_profile_by_user_id';

  var experienceGetUrl =
      'https://eduarno1.herokuapp.com/user/get_experience_profile_by_user_id';

  var experienceDeleteUrl =
      'https://eduarno1.herokuapp.com/user/delete_experience_profile_by_user_id';

  Future<AcademicDetailResponse> postAcademicData({
    bool isUpdate = false,
    String id,
    institutionName,
    degree,
    specialisation,
    fromMonth,
    fromYear,
    toMonth,
    toYear,
    isCurrentlyHere,
    academicRecord,
    bio,
  }) async {
    var body = json.encode(
      {
        "academic_id": academicId,
        "user_id": id,
        "academic": [
          {
            'institutionName': institutionName,
            'degree': degree,
            'specialisation': specialisation,
            'fromMonth': fromMonth,
            'fromYear': fromYear,
            'toMonth': toMonth,
            'toYear': toYear,
            'isCurrentlyHere': isCurrentlyHere,
            'academicRecord': academicRecord,
            'bio': bio,
          }
        ],
      },
    );

    final http.Response response = await http.post(
        Uri.parse(isUpdate ? academicUpdateUrl : academicPostUrl),
        headers: {'Content-Type': 'application/json'},
        body: body);

    if (response.statusCode == 200) {
      //   print(response.body);
      final academicDetailResponse =
          academicDetailResponseFromJson(response.body);
      isUpdate
          ? academicId = ""
          : academicId = academicDetailResponse.data.first.id;
      var data = academicDetailResponse.data;
      _academic_detail_List.clear();

      data.forEach((element) {
        _academic_detail_List.add(element.academic.first);
        notifyListeners();
      });
      return academicDetailResponse;
    } else {
      throw Exception("Failed to Load Data");
    }
  }

  Future<AcademicDetailResponse> deleteAcademicData(
      {String id,
      institutionName,
      degree,
      specialisation,
      fromMonth,
      fromYear,
      toMonth,
      toYear,
      isCurrentlyHere,
      academicRecord,
      bio}) async {
    var body = json.encode(
      {
        "user_id": id,
        "academic": [
          {
            'institutionName': institutionName,
            'degree': degree,
            'specialisation': specialisation,
            'fromMonth': fromMonth,
            'fromYear': fromYear,
            'toMonth': toMonth,
            'toYear': toYear,
            'isCurrentlyHere': isCurrentlyHere,
            'academicRecord': academicRecord,
            'bio': bio,
          }
        ],
      },
    );

    final http.Response response = await http.post(Uri.parse(academicDeleteUrl),
        headers: {'Content-Type': 'application/json'}, body: body);

    try {
      if (response.statusCode == 200) {
        // print('Deletee ---------> ${response.body}');
        final academicDetailResponse =
            academicDetailResponseFromJson(response.body);
        return academicDetailResponse;
      } else {
        throw Exception("Failed to Load Data");
      }
    } catch (error) {
      // print("Error -------------------------> ${error}");
      return AcademicDetailResponse();
    }
  }

  Future<List<Academic>> getAcademicData(String id) async {
    var body = json.encode({
      'id': id,
    });
    final http.Response response = await http.post(Uri.parse(academicGetUrl),
        headers: {'Content-Type': 'application/json'}, body: body);
    if (response.statusCode == 200) {
      print('Geeeet ----------------------------->${response.body}');
      final academicDetailGetResponse =
          academicDetailResponseFromJson(response.body);
      //To set _academic_list_data to get body...............
      var data = academicDetailGetResponse.data;
      // List<Academic> academic_detail_List = [];
      _academic_detail_List.clear();
      data.forEach((element) {
        _academic_detail_List.add(element.academic.first);
        notifyListeners();
      });
      // for (List<Academic> academic in academicDetailGetResponse.data) {}
      return _academic_detail_List;
    } else {
      throw Exception("Failed to Load Data");
    }
  }

  Future<ExperienceDetailGetResponse> postExperienceData({
    bool isUpdate = false,
    String id,
    institutionName,
    subject,
    fromMonth,
    fromYear,
    toMonth,
    toYear,
    isCurrentlyHere,
  }) async {
    var body = json.encode(
      {
        'experience_id': experienceId,
        'user_id': id,
        'experience': [
          {
            'institutionName': institutionName,
            'subject': subject,
            'fromMonth': fromMonth,
            'fromYear': fromYear,
            'toMonth': toMonth,
            'toYear': toYear,
            'isCurrentlyHere': isCurrentlyHere,
          }
        ]
      },
    );
    final http.Response response = await http.post(
        Uri.parse(isUpdate ? experienceUpdateUrl : experiencePostUrl),
        headers: {'Content-Type': 'application/json'},
        body: body);
    if (response.statusCode == 200) {
      print(response.body);
      final experienceDetailGetResponse =
          experienceDetailGetResponseFromJson(response.body);
      isUpdate
          ? experienceId = ""
          : experienceId = experienceDetailGetResponse.data.first.id;
      var data = experienceDetailGetResponse.data;
      // _experience_detail_List.clear();
      data.forEach((element) {
        _experience_detail_List.add(element.experience.first);
        notifyListeners();
      });
      return experienceDetailGetResponse;
    } else {
      throw Exception("Failed to Load Data");
    }
  }

  Future<ExperienceDetailGetResponse> deleteExperienceData({
    String id,
    institutionName,
    subject,
    fromMonth,
    fromYear,
    toMonth,
    toYear,
    isCurrentlyHere,
  }) async {
    var body = json.encode(
      {
        'user_id': id,
        'experience': [
          {
            'institutionName': institutionName,
            'subject': subject,
            'fromMonth': fromMonth,
            'fromYear': fromYear,
            'toMonth': toMonth,
            'toYear': toYear,
            'isCurrentlyHere': isCurrentlyHere,
          }
        ]
      },
    );
    final http.Response response = await http.post(
        Uri.parse(experienceDeleteUrl),
        headers: {'Content-Type': 'application/json'},
        body: body);
    try {
      if (response.statusCode == 200) {
        //  print('Deleteeee -------------------->${response.body}');
        final experienceDetailGetResponse =
            experienceDetailGetResponseFromJson(response.body);

        return experienceDetailGetResponse;
      } else {
        throw Exception("Failed to Load Data");
      }
    } catch (error) {
      // print("Error ---------------> ${error}");
      return ExperienceDetailGetResponse();
    }
  }

  Future<List<Experience>> getExperienceData(String id) async {
    var body = json.encode({
      'id': id,
    });
    final http.Response response = await http.post(Uri.parse(experienceGetUrl),
        headers: {'Content-Type': 'application/json'}, body: body);
    if (response.statusCode == 200) {
      //  print('Geeeet ----------------------------> ${response.body}');
      final experienceDetailGetResponse =
          experienceDetailGetResponseFromJson(response.body);
      var data = experienceDetailGetResponse.data;
      // List<Experience> experience_detail_List = [];
      _experience_detail_List.clear();
      data.forEach((element) {
        _experience_detail_List.add(element.experience.first);
        notifyListeners();
      });
      return _experience_detail_List;
    } else {
      throw Exception("Failed to Load Data");
    }
  }
}
