import 'dart:convert';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/assessment/model/assessment_item.dart';
import 'package:eduarno/repo/bloc/profile/model/assessment_result.dart';
import 'package:eduarno/repo/bloc/profile/model/notification_model.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'model/assessment_details.dart';

class AssessmentProvider extends ChangeNotifier {
  static final AssessmentProvider _singleton = AssessmentProvider._internal();

  factory AssessmentProvider() {
    return _singleton;
  }

  AssessmentProvider._internal();

  final resultUrl =
      'https://eduarno1.herokuapp.com/user/post_assessment_result_new';

  final getAssessmentDetailsUrl =
      'https://eduarno1.herokuapp.com/user/post_assessment_detail';

  List<AssessmentItem> _assessmentItemList = [];

  final List<Questions> _myQuestions = [];
  List<Questions> _resultQuestions = [];

  // List<Questions> get resultQuestions => _resultQuestions;

  void checbox() {}

  void addresultQuestions(Questions questionResult) {
    _resultQuestions.add(questionResult);
    print('Result questions pushed data----------------> $_resultQuestions');
    notifyListeners();
  }

  void removeQuestions() {
    _resultQuestions.removeLast();
    print('Result questions poped data----------------> $_resultQuestions');
    notifyListeners();
  }

  void setTrue({@required int questionIndex, @required int mcqValue}) {
    _myQuestions[questionIndex].mcq[mcqValue]['isSelected'] = true;
  }

  int _sectionZeroQuestions = 0;
  int _sectionOneQuestions = 0;
  int _sectionTwoQuestions = 0;

  List<Questions> get myQuestions => _myQuestions;
  int get sectionZeroQuestions => _sectionZeroQuestions;
  int get sectionOneQuestions => _sectionOneQuestions;
  int get sectionTwoQuestions => _sectionTwoQuestions;

  final List<Map<String, dynamic>> _mcqData = [];
  List<Map<String, dynamic>> get mcqData => _mcqData;

  String _sectionZeroId = '';
  String _sectionOneId = '';
  String _sectionTwoId = '';
  String _assessmentId = '';
  String _assessmentLevel = '';

  String get assessmentId => _assessmentId;
  String get assessmentLevel => _assessmentLevel;
  String get sectionZeroId => _sectionZeroId;
  String get sectionOneId => _sectionOneId;
  String get sectionTwoId => _sectionTwoId;

  List<AssessmentItem> get assessmentItemList => _assessmentItemList;

  /// set users academic details
  Future<bool> getAssessmentListing(String specialization, String topic) async {
    final url = '$kBaseApiUrl/user/post_assessment_list';
    var uri = Uri.parse(url);
    var body = {'user_id': '${User().userId}'};
    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        _assessmentItemList = List<AssessmentItem>.from(
          body['data'].map(
            (item) => AssessmentItem.fromJson(item),
          ),
        );
        notifyListeners();
        return true;
        break;
      case 400:
        return false;
        break;
      case 500:
        return false;
        break;
      default:
        return false;
    }
  }

  Future<AssessmentResultResponse> getAssessmentResult(
      {bool isDiscard = false}) async {
    print('List of response submitted -- > $myQuestions');
    List<Questions> submitResponse;
    if (isDiscard) {
      submitResponse = _myQuestions;
    } else {
      submitResponse = _resultQuestions;
    }
    var body = json.encode({
      'user_id': User().userId,
      'assessment_id': assessmentId,
      'level': assessmentLevel,
      'questions': submitResponse,
    });
    final response = await http.post(
      Uri.parse(resultUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      print('Result Data -------------------------> ${response.body}');
      final assessmentResultResponse =
          assessmentResultResponseFromJson(response.body);

      if (assessmentResultResponse.data.first.result.toLowerCase() == 'pass') {
        User().isAssessment = true;
      } else {
        if (User().isAssessment == true) {
          User().isAssessment = true;
        } else {
          User().isAssessment = false;
        }
      }
      return assessmentResultResponse;
    } else {
      return AssessmentResultResponse();
    }
  }

  Future<AssessmentDetailsResponse> getAssessment({String id}) async {
    var body = json.encode({
      'id': id,
    });
    final response = await http.post(
      Uri.parse(getAssessmentDetailsUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      try {
        _resultQuestions = [];
        final assessmenDetailsResponse =
            assessmenDetailsResponseFromJson(response.body);
        print(
            'Got assessment Yayyyy -------------------------->  ${response.body}');
        myQuestions.clear();
        _sectionZeroQuestions = 0;
        _sectionOneQuestions = 0;
        _sectionTwoQuestions = 0;
        _sectionOneId = '';
        _sectionTwoId = '';
        _sectionZeroId = '';
        _assessmentId = '';
        _assessmentLevel = '';
        _assessmentId = assessmenDetailsResponse.assessment.first.id;
        _assessmentLevel = assessmenDetailsResponse.assessment.first.level;
        assessmenDetailsResponse.sections.forEach(
          (section) {
            if (assessmenDetailsResponse.assessment.first.businessLogic
                    .toLowerCase() ==
                'random_order') {
              section.questions.shuffle();
            }

            section.questions.forEach((question) {
              myQuestions.add(question);
            });
            if (section.index == 0) {
              _sectionZeroId = section.id;
              print('Section 1 id $_sectionZeroId');
              section.questions.forEach((question) {
                _sectionZeroQuestions++;
                print(_sectionZeroQuestions);
                notifyListeners();
              });
            } else if (section.index == 1) {
              _sectionOneId = section.id;
              print('Section 2 id $_sectionOneId');
              section.questions.forEach((question) {
                _sectionOneQuestions++;
                print(_sectionOneQuestions);
                notifyListeners();
              });
            } else if (section.index == 2) {
              _sectionTwoId = section.id;
              print('Section 3 id $_sectionTwoId');
              section.questions.forEach((question) {
                _sectionTwoQuestions++;
                print(_sectionTwoQuestions);
                notifyListeners();
              });
            }
          },
        );

        // int count = assessmenDetailsResponse.sections.length;
        // for (var i = 0; i < count; i++) {
        //   sectionZero.add(assessmenDetailsResponse.sections[0].questions);
        // }

        return assessmenDetailsResponse;
      } catch (error) {
        return AssessmentDetailsResponse();
      }
    } else {
      return AssessmentDetailsResponse();
    }
  }
}
