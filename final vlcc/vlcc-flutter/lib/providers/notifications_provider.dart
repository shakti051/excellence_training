import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:vlcc/models/notificaitons_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';

class NotificationProvider extends ChangeNotifier {
  final VlccShared _vlccShared = VlccShared();
  final Services _services = Services();
  num unreadCount = 0;

  Future<List<NotificationDetailModel>> getNotifications() async {
    var body = {
      'auth_token': _vlccShared.authToken,
      'client_mobile': _vlccShared.mobileNum,
      'device_id': _vlccShared.deviceId
    };
    var response = await _services.callApi(
        body, '/api/api_notification_list.php?request=notification_list');
    List<NotificationDetailModel> _notifications = [];
    unreadCount = 0.0;

    try {
      NotificationsModel notificationsModel =
          NotificationsModel.fromJson(jsonDecode(response));
      for (var element in notificationsModel.notificationDetails) {
        NotificationDetailModel notificationDetailModel =
            NotificationDetailModel(
                notificationId: element['NotificationId'] ?? '',
                appointmentId: element['AppointmentId'] ?? '',
                notificationtoken: element['Notificationtoken'] ?? '',
                notificationtitle: element['Notificationtitle'] ?? '',
                notificationmessage: element['Notificationmessage'] ?? '',
                notificationMobileNo: element['NotificationMobileNo'] ?? '',
                notificationstatus: element['Notificationstatus'] ?? '',
                createdDate: element['CreatedDate'] ?? '',
                createdTime: element['CreatedTime'] ?? '',
                updatedDate: element['UpdatedDate'] ?? '',
                updatedTime: element['UpdatedTime'] ?? '');
        _notifications.add(notificationDetailModel);
      }
      for (NotificationDetailModel notification in _notifications) {
        if (notification.notificationstatus.toLowerCase() == 'pending') {
          unreadCount++;
        }
      }
    } catch (e) {
      log('Error', error: e, name: ' Error notificaiton');
    }
    return _notifications.reversed.toList();
  }

  Future<bool> updateReadStatus({
    required String notificationID,
  }) async {
    var body = {
      'auth_token': _vlccShared.authToken,
      'client_mobile': _vlccShared.mobileNum,
      'device_id': _vlccShared.deviceId,
      'NotificationId': notificationID,
    };
    bool isSuccessful = false;
    var response = await _services.callApi(body,
        '/api/api_notification_completed.php?request=notification_completed');
    var json = jsonDecode(response);

    if (json['Message'].toString().toLowerCase() == 'success') {
      isSuccessful = true;
    }
    return isSuccessful;
  }
}
