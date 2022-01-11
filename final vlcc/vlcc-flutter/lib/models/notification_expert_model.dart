// To parse this JSON data, do
//
//     final notificationExpertModel = notificationExpertModelFromJson(jsonString);
import 'dart:convert';
NotificationExpertModel notificationExpertModelFromJson(String str) => NotificationExpertModel.fromJson(json.decode(str));
String notificationExpertModelToJson(NotificationExpertModel data) => json.encode(data.toJson());

class NotificationExpertModel {
    NotificationExpertModel({
        this.status,
        this.message,
        this.notificationDetails,
    });

    int? status;
    String? message;
    List<NotificationDetail>? notificationDetails;

    factory NotificationExpertModel.fromJson(Map<String, dynamic> json) => NotificationExpertModel(
        status: json["Status"],
        message: json["Message"],
        notificationDetails: List<NotificationDetail>.from(json["NotificationDetails"].map((x) => NotificationDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "NotificationDetails": List<dynamic>.from(notificationDetails!.map((x) => x.toJson())),
    };
}

class NotificationDetail {
    NotificationDetail({
        this.notificationId,
        this.appointmentId,
        this.notificationtoken,
        this.notificationtitle,
        this.notificationmessage,
        this.notificationMobileNo,
        this.notificationstatus,
        this.createdDate,
        this.createdTime,
        this.updatedDate,
        this.updatedTime,
    });

    String? notificationId;
    String? appointmentId;
    String? notificationtoken;
    String? notificationtitle;
    String? notificationmessage;
    String? notificationMobileNo;
    String? notificationstatus;
    DateTime? createdDate;
    String? createdTime;
    DateTime? updatedDate;
    String? updatedTime;

    factory NotificationDetail.fromJson(Map<String, dynamic> json) => NotificationDetail(
        notificationId: json["NotificationId"],
        appointmentId: json["AppointmentId"],
        notificationtoken: json["Notificationtoken"],
        notificationtitle: json["Notificationtitle"],
        notificationmessage: json["Notificationmessage"],
        notificationMobileNo: json["NotificationMobileNo"],
        notificationstatus: json["Notificationstatus"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        createdTime: json["CreatedTime"],
        updatedDate: json["UpdatedDate"] == null ? null : DateTime.parse(json["UpdatedDate"]),
        updatedTime: json["UpdatedTime"] == null ? null : json["UpdatedTime"],
    );

    Map<String, dynamic> toJson() => {
        "NotificationId": notificationId,
        "AppointmentId": appointmentId,
        "Notificationtoken": notificationtoken,
        "Notificationtitle": notificationtitle,
        "Notificationmessage": notificationmessage,
        "NotificationMobileNo": notificationMobileNo,
        "Notificationstatus": notificationstatus,
        "CreatedDate": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "CreatedTime": createdTime,
        "UpdatedDate": updatedDate == null ? null : "${updatedDate!.year.toString().padLeft(4, '0')}-${updatedDate!.month.toString().padLeft(2, '0')}-${updatedDate!.day.toString().padLeft(2, '0')}",
        "UpdatedTime": updatedTime == null ? null : updatedTime,
    };
}
