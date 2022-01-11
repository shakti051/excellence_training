import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/components/add_clinic_logo.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/expert/reminder_popup_details.dart';
import 'package:vlcc/expert/reminder_view_details.dart';
import 'package:vlcc/main.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';

class ViewReminder extends StatefulWidget {
  final VlccReminderModel vlccReminderModel;
  const ViewReminder({
    Key? key,
    required this.vlccReminderModel,
  }) : super(key: key);

  @override
  State<ViewReminder> createState() => _ViewReminderState();
}

class _ViewReminderState extends State<ViewReminder>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  void scheduleReminder(
      {required int seconds, required int notificationId}) async {
    var scheduledNotificationTime = DateTime.now().add(
      Duration(
        minutes: 5,
      ),
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Reminder notification',
      icon: 'ic_launcher',
      // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        notificationId,
        widget.vlccReminderModel.reminderTitle,
        'welcome to vlcc',
        scheduledNotificationTime,
        platformChannelSpecifics);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 18,
          child: Text(
            'Appointment snoozed for 5 minutes',
            style: TextStyle(color: Colors.white),
          ),
        ),
        duration: const Duration(milliseconds: 5000),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        // action: SnackBarAction(
        //   textColor: AppColors.orange,
        //   label: 'Undo',
        //   onPressed: () {
        //     // Code to execute.
        //   },
        // ),
      ),
    );

    log("${seconds / (1000 * 60 * 24)}");
  }

  @override
  Widget build(BuildContext context) {
    final _ = context.watch<DatabaseHelper>();
    return ScaleTransition(
      scale: scaleAnimation,
      child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Appointment Reminder ",
                            style: TextStyle(
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.large)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(SVGAsset.reminder))
                      ],
                    ),
                  ),
                  Divider(),
                  reminderCards(
                    addressLine1: widget.vlccReminderModel.addressLine1,
                    addressLine2: widget.vlccReminderModel.addressLine2,
                    serviceName: widget.vlccReminderModel.reminderTitle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            flutterLocalNotificationsPlugin
                                .cancel(widget.vlccReminderModel.appointmentId);
                            scheduleReminder(
                                seconds: widget.vlccReminderModel
                                        .appointmentDateSecond +
                                    (10 * 60 * 1000),
                                notificationId:
                                    widget.vlccReminderModel.appointmentId);
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 50,
                              padding: EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.backBorder),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text("Snooze",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: FontName.frutinger,
                                            fontWeight: FontWeight.w400,
                                            fontSize: FontSize.large)),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 4),
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: SvgPicture.asset(SVGAsset.snooze))
                                ],
                              )),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 50,
                              padding: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.orange),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text("Dismiss",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.orange,
                                      fontFamily: FontName.frutinger,
                                      fontWeight: FontWeight.w400,
                                      fontSize: FontSize.large))),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  Container reminderCards(
      {required String serviceName,
      required String addressLine1,
      required String addressLine2}) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 64, 128, 0.04),
              blurRadius: 10,
              offset: Offset(0, 5), // changes position of shadow
            )
          ],
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddClinicLogo(),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceName,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.large),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: MarginSize.small),
                  child: Text(
                    addressLine1,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: FontSize.normal),
                  ),
                ),
                Text(
                  addressLine2,
                  style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReminderPopUpDetails(
                                      data: widget.vlccReminderModel,
                                    )));
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: MarginSize.small),
                          decoration: BoxDecoration(
                              color: AppColors.orange,
                              border: Border.all(
                                  color: AppColors.orangeProfile, width: 1.0),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: PaddingSize.extraLarge, vertical: 8),
                          child: Text(
                            "View Details",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.large),
                          )),
                    ),
                    Visibility(
                      visible: false,
                      child: SvgPicture.asset(
                        "assets/images/reminder.svg",
                        color: AppColors.orange,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
