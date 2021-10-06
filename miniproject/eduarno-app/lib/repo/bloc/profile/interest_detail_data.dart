import 'package:eduarno/repo/bloc/profile/model/interest.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/repo/utils/network/callApi.dart';
import 'package:eduarno/widgets/toast.dart';
import 'package:flutter/cupertino.dart';

class InterestProvider extends ChangeNotifier {
  static final InterestProvider _singleton = InterestProvider._internal();

  factory InterestProvider() {
    return _singleton;
  }

  InterestProvider._internal();

  List<Interest> _interestList = [];

  List<Interest> get interestList => _interestList;

  // set interestList(){

  // }

  void deleteInterest(Interest interest) {
    _interestList.remove(interest);
    notifyListeners();
  }

  Future<bool> updateInterestDetail() async {
    print(interestList);
    final data = await callApi({
      'user_id': User().userId,
      'data': interestList,
    }, 'user/interest_update_profile_user_by_id');
    print('Response Data ----------------->>> $data');
    if (data['code'] == 400) {
      print(data['message']);
      // _interestList.clear();
      // _interestList =
      //     List<Interest>.from(data["data"].map((x) => Interest.fromJson(x)));
      // print('Intrestsss------------------------------->$_interestList');
      // notifyListeners();
      return true;
    }
    return false;
  }

  /// set users interest details
  Future<bool> setInterestDetail(
      String id, String specialization, List<Map<String, dynamic>> topic,
      {bool isEdit = false}) async {
    final data = await callApi(
        {
          'user_id': id,
          'user_specialisation': specialization,
          'interest': topic,
        },
        isEdit
            ? 'user/interest_update_profile_user_by_id'
            : 'user/interest_insert_profile_user_by_id');
    try {
      if (data['code'] == 200) {
        print('Send Interest Data ---------------------- >>>>${data['data']}');
        _interestList.clear();
        _interestList =
            List<Interest>.from(data['data'].map((x) => Interest.fromJson(x)));
        print('Intrestsss------------------------------->$_interestList');
        notifyListeners();
        return false;
      }
    } catch (e) {
      return false;
    }
    ShowToast.show(data['message'] ?? 'Something Went wrong');

    return false;
  }

  Future<bool> deleteInterestDetail(
    String id,
    String specialization,
  ) async {
    final data = await callApi({
      'user_id': id,
      'user_specialisation': specialization,
    }, 'user/interest_delete_profile_user_by_id');
    try {
      if (data['code'] == 200) {
        //  print('Geeeeettttt----------------------->$data');
        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }
    ShowToast.show(data['message'] ?? 'Something Went wrong');
    return false;
  }

  /// get users interest details
  Future<bool> getInterestDetail(String id) async {
    final data = await callApi({
      'user_id': id,
    }, 'user/interest_get_profile_user_by_id');
    try {
      if (data['code'] == 200) {
        print('Get Interest Data ---------------------- >>>>${data['data']}');
        _interestList.clear();
        _interestList =
            List<Interest>.from(data['data'].map((x) => Interest.fromJson(x)));
        notifyListeners();
        return false;
      }
    } catch (e) {
      return false;
    }
    ShowToast.show(data['message'] ?? 'Something Went wrong');

    return false;
  }
}
