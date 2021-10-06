import 'dart:convert';

import 'package:eduarno/Notification/notificationResponseModel.dart';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NotificationProvider extends ChangeNotifier {
  static final NotificationProvider _singleton =
      NotificationProvider._internal();

  factory NotificationProvider() {
    return _singleton;
  }

  NotificationProvider._internal();

  List<String> _requestID = [];
  List<String> get requestId => _requestID;

  void setRequestId(List<String> requestList) {
    _requestID = requestList;
    notifyListeners();
  }

  List<Datum> _notificationList = [];
  List<Datum> get notificationList => _notificationList;

  int _notificationCount = 0;
  int get notificationCount => _notificationCount;
  void notificationCountSet() {
    _notificationCount--;
    notifyListeners();
  }

  var getNotificationUrl = '$kBaseApiUrl/user/get_notification_list';

  Future<NotificationResultResponse> getNotifications() async {
    var body = json.encode(
      {'user_id': User().userId},
    );
    // ignore: omit_local_variable_types
    final http.Response response = await http.post(
        Uri.parse(getNotificationUrl),
        headers: {'Content-Type': 'application/json'},
        body: body);

    if (response.statusCode == 200) {
      try {
        final notificationResultResponse =
            notificationResultResponseFromJson(response.body);
        _notificationList = [];
        _notificationCount = 0;
        notificationResultResponse.data.forEach((notifications) {
          _notificationList.add(notifications);
          if (notifications.isRead == false) {
            _notificationCount++;
          }
          notifyListeners();
        });
        return notificationResultResponse;
      } catch (error) {
        print('Expception ------------------> $error');
        return NotificationResultResponse();
      }
    } else {
      return NotificationResultResponse();
    }
  }
}
