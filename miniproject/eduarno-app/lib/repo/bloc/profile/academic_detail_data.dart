// import 'package:eduarno/repo/utils/network/callApi.dart';
// import 'package:eduarno/widgets/toast.dart';
// import 'package:flutter/cupertino.dart';

// class AcademicProvider extends ChangeNotifier {
//   static final AcademicProvider _singleton = AcademicProvider._internal();

//   factory AcademicProvider() {
//     return _singleton;
//   }

//   AcademicProvider._internal();

//   List<Map<String, dynamic>> _eduList = [];
//   List<Map<String, dynamic>> _expList = [];
//   // String _reward;
//   // String _bio;

//   List<Map<String, dynamic>> get eduList => _eduList;

//   List<Map<String, dynamic>> get expList => _expList;

//   // String get reward => _reward;

//   // String get bio => _bio;

//   set setEducationItem(Map<String, dynamic> value) {
//     _eduList.add(value);
//     notifyListeners();
//   }

//   // set setExperienceItem(Map<String, dynamic> value) {
//   //   _expList.add(value);
//   //   notifyListeners();
//   // }

//   /// set users academic details
//   Future<bool> setAcademicDetail(String id) async {
//     final data = await callApi({
//       'user_id': id,
//       'academic': _eduList,
//     }, 'user/update_academic_profile_by_user_id');
//     if (data['code'] == 200) {
//       _eduList = [];
//       //_expList = [];
//       // _reward = '';
//       // _bio = '';
//       try {
//         for (Map<String, dynamic> academic in data['data']['academic']) {
//           var education = {
//             'id': academic['id'],
//             'user_university': academic['user_university'],
//             "user_degree": academic['user_degree'],
//             //'specialization': academic['specialization'],
//             'user_from': academic['user_from'],
//             //'fromYear': academic['fromYear'],
//             'user_to': academic['user_to'],
//             //'toYear': academic['toYear'],
//             'isCurrentlyHere': academic['isCurrentlyHere'],
//           };
//           _eduList.add(education);
//         }
//         // _reward = data['data']['reward'];
//         // _bio = data['data']['bio'];
//       } catch (e) {
//         print('error -------> $e');
//         return false;
//       }
//       notifyListeners();
//       return true;
//     }
//     ShowToast.show(data['message'] ?? 'Something Went wrong');

//     return false;
//   }

//   /// get Academic details
//   Future<bool> getAcademicDetail(String id) async {
//     final data = await callApi({
//       'id': id,
//     }, 'user/get_academic_profile_by_user_id');
//     try {
//       if (data['code'] == 200) {
//         _eduList = [];
//         //_expList = [];
//         // _reward = '';
//         // _bio = '';
//         for (Map<String, dynamic> academic in data['data'][0]['academic']) {
//           var education = {
//             "id": academic['id'],
//             "institutionName": academic['institutionName'],
//             "degree": academic['degree'],
//             'specialization': academic['specialization'],
//             'fromMonth': academic['fromMonth'],
//             'fromYear': academic['fromYear'],
//             'toMonth': academic['toMonth'],
//             'toYear': academic['toYear'],
//             'isCurrentlyHere': academic['isCurrentlyHere'],
//           };
//           _eduList.add(education);
//         }
//         notifyListeners();
//         return true;
//       }
//     } catch (e) {
//       print('error -------> $e');
//       return false;
//     }
//     ShowToast.show(data['message'] ?? 'Something Went wrong');

//     return false;
//   }
// }
