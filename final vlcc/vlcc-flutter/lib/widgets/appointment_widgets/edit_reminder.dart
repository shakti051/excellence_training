import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/providers/reminder_provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import '../../main.dart';
import '../gradient_button.dart';

class EditReminder extends StatefulWidget {
  final int index;
  final int selectedTime;
  final String serviceName;
  final int appointmentseconds;
  final int appointmentIndex;
  final int appointmentId;
  final VlccReminderModel reminderModel;
  const EditReminder({
    Key? key,
    this.index = 0,
    this.selectedTime = 0,
    required this.serviceName,
    required this.appointmentseconds,
    required this.appointmentIndex,
    required this.reminderModel,
    required this.appointmentId,
  }) : super(key: key);

  @override
  _EditReminderState createState() => _EditReminderState();
}

class _EditReminderState extends State<EditReminder> {
  // final _customTime = TextEditingController();
  final VlccReminderModel vlccReminderModel = VlccReminderModel();

  final List<ListItem> _dropdownItems = [
    ListItem(1, "Mins"),
    ListItem(2, "Hours"),
    ListItem(3, "Days"),
  ];

  List<DropdownMenuItem<ListItem>>? _dropdownMenuItems;
  ListItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems![0].value;
    vlccReminderModel.id = widget.reminderModel.id;
    vlccReminderModel.appointmentIndex = widget.index;
    vlccReminderModel.reminderTitle = widget.serviceName;
    vlccReminderModel.addressLine1 = widget.reminderModel.addressLine1;
    vlccReminderModel.addressLine2 = widget.reminderModel.addressLine2;
    vlccReminderModel.appointmentType = widget.reminderModel.appointmentType;
    vlccReminderModel.appointmentId = widget.reminderModel.appointmentId;
    vlccReminderModel.appointmentDateSecond =
        widget.reminderModel.appointmentDateSecond;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  void scheduleReminder(
      {required int seconds, required int notificationId}) async {
    var message = json.encode({
      "notification": {
        "body": widget.serviceName,
        "title": widget.serviceName,
      },
      "notificationId": notificationId,
      "priority": "high",
      "data": {
        "action": "reminder" //to identify the action
      },
      "to": "deviceFCMId"
    });

    var scheduledNotificationTime =
        DateTime.now().add(Duration(milliseconds: seconds));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Reminder notification',
      icon: 'ic_launcher',
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
      widget.serviceName,
      'welcome to vlcc',
      scheduledNotificationTime,
      platformChannelSpecifics,
      payload: message,
    );
  }

  int getReminderTime({
    required ReminderProvider reminderProvider,
    required DatabaseHelper databaseHelper,
  }) {
    var finalTime =
        DateTime.fromMillisecondsSinceEpoch(widget.appointmentseconds * 1000)
            .subtract(
      Duration(seconds: reminderProvider.timerDuration),
    );
    var timeInMillisec = finalTime.difference(DateTime.now()).inMilliseconds;
    return timeInMillisec;
  }

  @override
  Widget build(BuildContext context) {
    final remindDuration = context.watch<ReminderProvider>();
    final databaseHelper = context.watch<DatabaseHelper>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                      opacity: 0, child: Icon(Icons.clear, color: Colors.grey)),
                  Text("Edit Reminder ",
                      style: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.large)),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, color: Colors.grey))
                ],
              ),
              SizedBox(height: 18),
              Divider(height: 2, color: AppColors.backBorder),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    // ignore: unnecessary_lambdas
                    onTap: () {
                      remindDuration.selectOnTime();
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      padding:
                          EdgeInsets.symmetric(horizontal: PaddingSize.normal),
                      decoration: BoxDecoration(
                        color:
                            remindDuration.getOnTime ? AppColors.orange : null,
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SvgPicture.asset(SVGAsset.time,
                          height: 50,
                          color: remindDuration.getOnTime
                              ? Colors.white
                              : AppColors.navyBlue),
                    ),
                  ),
                  GestureDetector(
                    // ignore: unnecessary_lambdas
                    onTap: () {
                      remindDuration.selectFifteenMin();
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      padding: EdgeInsets.only(top: PaddingSize.middle),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        color: Provider.of<ReminderProvider>(context).getFifteen
                            ? AppColors.orange
                            : AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("15m",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: remindDuration.getFifteen
                                  ? Colors.white
                                  : AppColors.navyBlue,
                              fontFamily: FontName.oswald,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.extraLarge)),
                    ),
                  ),
                  GestureDetector(
                    // ignore: unnecessary_lambdas
                    onTap: () {
                      remindDuration.selectOneHour();
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      padding: EdgeInsets.only(top: PaddingSize.middle),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(15),
                        color: remindDuration.getOneHour
                            ? AppColors.orange
                            : AppColors.backgroundColor,
                      ),
                      child: Text("1h",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: remindDuration.getOneHour
                                  ? Colors.white
                                  : AppColors.navyBlue,
                              fontFamily: FontName.oswald,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.extraLarge)),
                    ),
                  ),
                  GestureDetector(
                    // ignore: unnecessary_lambdas
                    onTap: () {
                      remindDuration.selectOneDay();
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      padding: EdgeInsets.only(top: PaddingSize.middle),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(15),
                        color:
                            remindDuration.getOneDay ? AppColors.orange : null,
                      ),
                      child: Text("1d",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: remindDuration.getOneDay
                                  ? Colors.white
                                  : AppColors.navyBlue,
                              fontFamily: FontName.oswald,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.extraLarge)),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text("On time",
                        style: TextStyle(
                            color: remindDuration.getOnTime
                                ? Colors.black87
                                : Colors.grey,
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text("15 min \nbefore",
                        style: TextStyle(
                            color: remindDuration.getFifteen
                                ? Colors.black87
                                : Colors.grey,
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text("1 hour \nbefore",
                        style: TextStyle(
                            color: remindDuration.getOneHour
                                ? Colors.black87
                                : Colors.grey,
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text("1 day \nbefore",
                        style: TextStyle(
                            color: remindDuration.getOneDay
                                ? Colors.black87
                                : Colors.grey,
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal)),
                  ),
                ],
              ),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 143,
                        padding: EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: AppColors.backBorder),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 4),
                          child: Text("Cancel",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 26, width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: GradientButton(
                        height: 50,
                        onPressed: () async {
                          flutterLocalNotificationsPlugin
                              .cancel(widget.appointmentId);
                          // databaseHelper.deleteReminder(id: widget.index);
                          vlccReminderModel.appointmentIndex = widget.index;
                          vlccReminderModel.insertTime =
                              DateTime.now().millisecondsSinceEpoch;
                          vlccReminderModel.isSet = 1;
                          vlccReminderModel.reminderTriggerTime =
                              remindDuration.timerDuration;
                          databaseHelper.updateReminder(
                            appointmentId: widget.reminderModel.id ?? 0,
                            reminderModel: vlccReminderModel,
                          );
                          scheduleReminder(
                              seconds: getReminderTime(
                                  reminderProvider: remindDuration,
                                  databaseHelper: databaseHelper),
                              notificationId: widget.appointmentId);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Reminder updated ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Text("Edit Reminder",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w400,
                                fontSize: FontSize.large)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}
