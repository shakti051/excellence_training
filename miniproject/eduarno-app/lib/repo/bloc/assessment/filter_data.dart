import 'package:eduarno/repo/bloc/assessment/model/specialization.dart';
import 'package:eduarno/repo/bloc/assessment/model/topic.dart';
import 'package:eduarno/repo/utils/network/callApi.dart';
import 'package:eduarno/widgets/toast.dart';
import 'package:flutter/cupertino.dart';

class FilterBloc extends ChangeNotifier {
  static final FilterBloc _singleton = FilterBloc._internal();

  factory FilterBloc() {
    return _singleton;
  }

  FilterBloc._internal();

  List<Specialization> _specializationList = [];
  List<Topic> _topicList = [];
  String _selectedSpecialization;
  String _selectedSpecializationId;
  String _isSpecializationSelected = 'false';
  bool _isSaveButtonActivate = false;

  bool get isSaveButtonActivate => _isSaveButtonActivate;
  set isSaveButtonActivate(bool value) {
    _isSaveButtonActivate = value;
    notifyListeners();
  }

  List<Specialization> get specializationList => _specializationList;

  List<Topic> get topicList => _topicList;

  String get selectedSpecialization => _selectedSpecialization;

  String get selectedSpecializationId => _selectedSpecializationId;

  String get isSpecializationSelected => _isSpecializationSelected;

  set selectedSpecializationId(String value) {
    _selectedSpecializationId = value;
    notifyListeners();
  }

  set isSpecializationSelected(String value) {
    _isSpecializationSelected = value;
    notifyListeners();
  }

  set selectedSpecialization(String value) {
    _selectedSpecialization = value;
    notifyListeners();
  }

  /// fetch specializations
  Future<bool> specializations() async {
    final data = await callGetApi('specialisations');

    if (data['code'] == 200) {
      _specializationList = List<Specialization>.from(
          data['data'].map((x) => Specialization.fromJson(x)));

      return true;
    }

    ShowToast.show(data['message'] ?? 'Something Went wrong');

    return false;
  }

  /// fetch topic
  Future<bool> getTopics(String specializationId) async {
    final data = await callApi({
      'topic_id': specializationId,
    }, 'get_topic_by_specialisation_id');

    if (data['code'] == 200) {
      _topicList = List<Topic>.from(data['data'].map((x) => Topic.fromJson(x)));

      return true;
    }

    ShowToast.show(data['message'] ?? 'Something Went wrong');

    return false;
  }
}
