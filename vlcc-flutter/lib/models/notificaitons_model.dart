import 'dart:convert';

class NotificationsModel {
  NotificationsModel({
    required this.status,
    required this.message,
    required this.notificationDetails,
  });

  final int status;
  final String message;
  final List<dynamic> notificationDetails;

  factory NotificationsModel.fromRawJson(String str) =>
      NotificationsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
          status: json["Status"],
          message: json["Message"],
          notificationDetails: json["NotificationDetails"]

          // json["NotificationDetails"].cast<NotificationDetailModel>()
          // as List<NotificationDetailModel>

          // ??
          //     NotificationDetailModel(
          //         notificationId: '',
          //         appointmentId: 'appointmentId',
          //         notificationtoken: '',
          //         notificationtitle: 'notificationtitle',
          //         notificationmessage: 'notificationmessage',
          //         notificationMobileNo: 'notificationMobileNo',
          //         notificationstatus: 'notificationstatus',
          //         createdDate: 'createdDate',
          //         createdTime: 'createdTime',
          //         updatedDate: 'updatedDate',
          //         updatedTime: 'updatedTime'),
          );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "NotificationDetails": notificationDetails,
      };
}

class NotificationDetailModel {
  NotificationDetailModel({
    required this.notificationId,
    required this.appointmentId,
    required this.notificationtoken,
    required this.notificationtitle,
    required this.notificationmessage,
    required this.notificationMobileNo,
    required this.notificationstatus,
    required this.createdDate,
    required this.createdTime,
    required this.updatedDate,
    required this.updatedTime,
  });

  final String notificationId;
  final String appointmentId;
  final String notificationtoken;
  final String notificationtitle;
  final String notificationmessage;
  final String notificationMobileNo;
  final String notificationstatus;
  final String createdDate;
  final String createdTime;
  final String updatedDate;
  final String updatedTime;

  factory NotificationDetailModel.fromRawJson(String str) =>
      NotificationDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationDetailModel.fromJson(Map<String, dynamic> json) =>
      NotificationDetailModel(
        notificationId: json["NotificationId"] ?? '',
        appointmentId: json["AppointmentId"] ?? '',
        notificationtoken: json["Notificationtoken"] ?? '',
        notificationtitle: json["Notificationtitle"] ?? '',
        notificationmessage: json["Notificationmessage"] ?? '',
        notificationMobileNo: json["NotificationMobileNo"] ?? '',
        notificationstatus: json["Notificationstatus"] ?? '',
        createdDate: json["CreatedDate"] ?? '',
        createdTime: json["CreatedTime"] ?? '',
        updatedDate: json["UpdatedDate"] ?? 'help',
        updatedTime: json["UpdatedTime"] ?? 'help 2',
      );

  Map<String, dynamic> toJson() => {
        "NotificationId": notificationId,
        "AppointmentId": appointmentId,
        "Notificationtoken": notificationtoken,
        "Notificationtitle": notificationtitle,
        "Notificationmessage": notificationmessage,
        "NotificationMobileNo": notificationMobileNo,
        "Notificationstatus": notificationstatus,
        "CreatedDate": createdDate,
        "CreatedTime": createdTime,
        "UpdatedDate": updatedDate,
        "UpdatedTime": updatedTime,
      };
}

// enum Notificationstatus { COMPLETED, PENDING }

// final notificationstatusValues = EnumValues({
//   "Completed": Notificationstatus.COMPLETED,
//   "Pending": Notificationstatus.PENDING
// });

// enum Notificationtitle { NEW_APPOINTMENT, AFTER_SIGNUP, CANCEL_APPOINTMENT }

// final notificationtitleValues = EnumValues({
//   "After Signup": Notificationtitle.AFTER_SIGNUP,
//   "Cancel appointment": Notificationtitle.CANCEL_APPOINTMENT,
//   "New appointment": Notificationtitle.NEW_APPOINTMENT
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
