import 'dart:convert';

import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/profile/model/live_session_post_model_body.dart';
import 'package:eduarno/repo/bloc/profile/model/live_session_response_model.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/repo/utils/network/callApi.dart';
import 'package:eduarno/widgets/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class LiveSessionProvider extends ChangeNotifier {
  static final LiveSessionProvider _singleton = LiveSessionProvider._internal();

  factory LiveSessionProvider() {
    return _singleton;
  }

  LiveSessionProvider._internal();

  var liveSessionGetUrl = '$kBaseApiUrl/user/session_get_profile_user_by_id';
  var liveSessionsInsertUrl =
      '$kBaseApiUrl/user/session_insert_profile_user_by_id';
  var liveSessionUpdate = '$kBaseApiUrl/user/session_update_profile_user_by_id';

  LiveSessionResponse _response;
  LiveSessionResponse get response => _response;

  bool _containerState = false;
  bool get containerState => _containerState;

  set containerState(bool value) {
    _containerState = value;
    notifyListeners();
  }

  /// set users academic details
  // Future<bool> setLiveSessionDetail(
  //     {String id,
  //     String isAvailable,
  //     var dayList,
  //     String startTime,
  //     String endTime}) async {
  //   final data = await callApi({
  //     'user_id': id,
  //     'user_available_day': dayList,
  //     'user_start_time': startTime,
  //     'user_end_time': endTime,
  //     'is_available': isAvailable,
  //   }, 'user/update_academic_profile_by_user_id');
  //   if (data['code'] == 200) {
  //     try {
  //       ShowToast.show(data['message'], isError: false);
  //     } catch (e) {
  //       return false;
  //     }
  //     notifyListeners();
  //     return true;
  //   }
  //   ShowToast.show(data['message'] ?? 'Something Went wrong');

  //   return false;
  // }

  Future<void> setLiveSessionDetails(
      LiveSessionPostBodyResponse postResponse, String hitUrl) async {
    var body = json.encode({
      'user_id': postResponse.userId,
      'user_available_day': postResponse.userAvailableDay,
      'is_available': postResponse.isAvailable
    });
    // ignore: omit_local_variable_types
    final http.Response response = await http.post(Uri.parse(hitUrl),
        headers: {'Content-Type': 'application/json'}, body: body);

    if (response.statusCode == 200) {
      // User().setTrigger(value)
      // final liveSessionPostBodyResponse =
      //     liveSessionPostBodyResponseFromJson(response.body);
      // User().setTrigger(liveSessionPostBodyResponse.isAvailable);
      print('Posted Live Session Data success ----------- > ${response.body}');
    }
  }

  Future<LiveSessionResponse> getLiveSessionDetails() async {
    var body = json.encode(
      {
        'user_id': User().userId,
      },
    );
    // var body = json.encode({'user_id': 'eNktPQN8AaB42vpNW'});
    // ignore: omit_local_variable_types
    final http.Response response = await http.post(Uri.parse(liveSessionGetUrl),
        headers: {'Content-Type': 'application/json'}, body: body);

    if (response.statusCode == 200) {
      try {
        final LiveSessionResponse liveSessionResponse =
            liveSessionResponseFromJson(response.body);
        _response = liveSessionResponse;
        // if (liveSessionResponse.data.isEmpty) {
        //   final LiveSessionResponse empty = LiveSessionResponse();
        //   return empty;
        // }
        print('Live Session get body ${response.body}');

        return liveSessionResponse;
      } catch (error) {
        print('Exception at Live session get ------------> $error');
        return LiveSessionResponse();
      }
    } else {
      return LiveSessionResponse();
    }
  }
}
