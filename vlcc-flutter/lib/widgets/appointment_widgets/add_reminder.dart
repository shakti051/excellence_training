import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/providers/add_appointment_provider.dart';
import 'package:vlcc/providers/reminder_provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/gradient_button.dart';
import '../../main.dart';

class AddReminder extends StatefulWidget {
  // final VideoConsultModel videoConsultModel;
  final int index;
  final int appointmentseconds;
  final String serviceName;
  final int appointmentType;
  final String addressLine1;
  final String addressLine2;
  final String appointmentId;
  final DateTime appointmentDate;

  const AddReminder({
    Key? key,
    this.index = 0,
    this.appointmentseconds = 5,
    this.serviceName = 'VLCC',
    this.appointmentType = 0,
    required this.addressLine1,
    required this.addressLine2,
    required this.appointmentId,
    required this.appointmentDate,
  }) : super(key: key);

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  // final _customTime = TextEditingController();
  final List<ListItem> _dropdownItems = [
    ListItem(1, "Mins"),
    ListItem(2, "Hours"),
    ListItem(3, "Days"),
  ];

  List<DropdownMenuItem<ListItem>>? _dropdownMenuItems;
  ListItem? _selectedItem;
  VlccReminderModel vlccReminderModel = VlccReminderModel();

  @override
  void initState() {
    super.initState();
    vlccReminderModel.appointmentIndex = widget.index;
    vlccReminderModel.reminderTitle = widget.serviceName;
    vlccReminderModel.addressLine1 = widget.addressLine1;
    vlccReminderModel.addressLine2 = widget.addressLine2;
    vlccReminderModel.appointmentType = widget.appointmentType;
    vlccReminderModel.appointmentDateSecond = widget.appointmentseconds;
    vlccReminderModel.appointmentId = int.parse(widget.appointmentId);
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems![0].value;
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
      {required int milliseconds, required int notificationId}) async {
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
        DateTime.now().add(Duration(milliseconds: milliseconds));
    //DateTime.now().add(Duration(seconds: 1));
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
    // String action = 'reminder';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 18,
          child: Text(
            'Appointment added for ${scheduledNotificationTime.day}/${scheduledNotificationTime.month}/${scheduledNotificationTime.year} at ${scheduledNotificationTime.hour}:${scheduledNotificationTime.minute}',
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
    await flutterLocalNotificationsPlugin.schedule(
      notificationId,
      widget.serviceName,
      'Plz take VLCC services',
      scheduledNotificationTime,
      platformChannelSpecifics,
      payload: message,
    );
  }

  int getReminderTime({
    required AddAppointmentProvider addAppointmentProvider,
    required DatabaseHelper databaseHelper,
  }) {
    var finalTime =
        DateTime.fromMillisecondsSinceEpoch(widget.appointmentseconds * 1000)
            .subtract(
      Duration(seconds: addAppointmentProvider.timerDuration),
    );
    var timeInMillisec = finalTime.difference(DateTime.now()).inMilliseconds;

    // var appointmentTime =
    //     widget.appointmentseconds - (reminderProvider.timerDuration * 1000);
    return timeInMillisec;
  }

  @override
  Widget build(BuildContext context) {
    final _remindDuration = context.watch<AddAppointmentProvider>();
    final databaseHelper = context.watch<DatabaseHelper>();
    final remindProvider = context.watch<ReminderProvider>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        // height: 425,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                      opacity: 0, child: Icon(Icons.clear, color: Colors.grey)),
                  Text("Set Reminder ",
                      style: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.large)),
                  GestureDetector(
                      onTap: () {
                        //DatabaseHelper.instance.insertReminder(widget.videoConsultModel!.appointmentDetails![widget.index].appointmentId);
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
                      _remindDuration.selectOnTime();
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      padding:
                          EdgeInsets.symmetric(horizontal: PaddingSize.normal),
                      decoration: BoxDecoration(
                        color:
                            _remindDuration.getOnTime ? AppColors.orange : null,
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SvgPicture.asset(SVGAsset.time,
                          height: 50,
                          color: _remindDuration.getOnTime
                              ? Colors.white
                              : AppColors.navyBlue),
                    ),
                  ),
                  GestureDetector(
                    // ignore: unnecessary_lambdas
                    onTap: () {
                      _remindDuration.selectFifteenMin();
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      padding: EdgeInsets.only(top: PaddingSize.middle),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        color: Provider.of<AddAppointmentProvider>(context)
                                .getFifteen
                            ? AppColors.orange
                            : AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("15m",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _remindDuration.getFifteen
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
                      _remindDuration.selectOneHour();
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      padding: EdgeInsets.only(top: PaddingSize.middle),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(15),
                        color: _remindDuration.getOneHour
                            ? AppColors.orange
                            : AppColors.backgroundColor,
                      ),
                      child: Text("1h",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _remindDuration.getOneHour
                                  ? Colors.white
                                  : AppColors.navyBlue,
                              fontFamily: FontName.oswald,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.extraLarge)),
                    ),
                  ),
                  GestureDetector(
                    onTap: _remindDuration.selectOneDay,
                    child: Container(
                      width: 56,
                      height: 56,
                      padding: EdgeInsets.only(top: PaddingSize.middle),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(15),
                        color:
                            _remindDuration.getOneDay ? AppColors.orange : null,
                      ),
                      child: Text("1d",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _remindDuration.getOneDay
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
                    height: 40,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text("On time",
                        style: TextStyle(
                            color: _remindDuration.getOnTime
                                ? Colors.black87
                                : Colors.grey,
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text("15 min \nprior",
                        style: TextStyle(
                            color: _remindDuration.getFifteen
                                ? Colors.black87
                                : Colors.grey,
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text("1 hour \nprior",
                        style: TextStyle(
                            color: _remindDuration.getOneHour
                                ? Colors.black87
                                : Colors.grey,
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text("1 day \nprior",
                        style: TextStyle(
                            color: _remindDuration.getOneDay
                                ? Colors.black87
                                : Colors.grey,
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.normal)),
                  ),
                ],
              ),
              SizedBox(height: 26),
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
                    child: GradientButton(
                      height: 50,
                      onPressed: () async {
                        remindProvider.setReminderIndex(widget.appointmentId);
                        vlccReminderModel.isSet = 1;
                        vlccReminderModel.insertTime =
                            DateTime.now().millisecondsSinceEpoch;
                        vlccReminderModel.reminderTriggerTime =
                            _remindDuration.timerDuration;
                        databaseHelper
                            .insertReminder(reminderModel: vlccReminderModel)
                            .then((value) {
                          scheduleReminder(
                            notificationId: int.parse(widget.appointmentId),
                            milliseconds: getReminderTime(
                                addAppointmentProvider: _remindDuration,
                                databaseHelper: databaseHelper),
                          );
                        });
                        Navigator.pop(context);
                        
                      },
                      child: Text(
                        "Remind Me",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.large,
                        ),
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
