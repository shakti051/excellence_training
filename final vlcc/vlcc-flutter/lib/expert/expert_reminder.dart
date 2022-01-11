import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/providers/reminder_provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/consultation/reminder_consultation_dialouge.dart';
import 'package:vlcc/widgets/appointment_widgets/edit_reminder.dart';
import 'package:vlcc/widgets/nodata.dart';
import '../main.dart';

class ExpertReminder extends StatefulWidget {
  const ExpertReminder({Key? key}) : super(key: key);

  @override
  _ExpertReminderState createState() => _ExpertReminderState();
}

class _ExpertReminderState extends State<ExpertReminder> {
  editReminderDialog({
    required int index,
    required int selectionTime,
    required String serviceName,
    required int appointmentTime,
    required int appointmentIndex,
    required VlccReminderModel vlccReminderModel,
    required int appointmentId,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext c) {
          return EditReminder(
            reminderModel: vlccReminderModel,
            appointmentIndex: appointmentIndex,
            appointmentseconds: appointmentTime,
            serviceName: serviceName,
            index: index,
            selectedTime: selectionTime,
            appointmentId: appointmentId,
          );
        });
  }

  editReminderConsultationDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext c) {
          return ReminderConsultationDialouge();
        });
  }

  void timeSelector(
      {required ReminderProvider reminderProvider, required int timerSet}) {
    switch (timerSet) {
      case 0:
        reminderProvider.selectOnTime();
        break;
      case 900:
        reminderProvider.selectFifteenMin();
        break;
      case 3600:
        reminderProvider.selectOneHour();
        break;
      case 86400:
        reminderProvider.selectOneDay();
        break;
      default:
        reminderProvider.selectOnTime();
    }
  }

  bool isBeforeToday({required DateTime temp}) {
    var result = temp.isBefore(DateTime.now());
    return result;
  }

  String timeAgo({required int milliseconds}) {
    return timeago.format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
  }

  @override
  Widget build(BuildContext context) {
    final databaseHelper = context.watch<DatabaseHelper>();
    final remindDurationProvider = context.watch<ReminderProvider>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Transform.scale(
              scale: 1.4,
              child: Container(
                margin: EdgeInsets.only(left: 24, top: 12, bottom: 12),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.backBorder),
                    borderRadius: BorderRadius.circular(8)),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(SVGAsset.backButton),
                ),
              ),
            ),
            title: Container(
              margin: EdgeInsets.only(top: 8),
              child: Text("Reminders",
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.black87,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.extraLarge)),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
          child: FutureBuilder<List<VlccReminderModel>>(
              future: databaseHelper.getReminders(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var isNormalAppointment = snapshot.data!.where(
                    (element) => element.appointmentType == 0,
                  );
                  var isVideoAppointment = snapshot.data!.where(
                    (element) => element.appointmentType == 1,
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      SizedBox(
                        height: 50,
                        child: AppBar(
                          backgroundColor: AppColors.backgroundColor,
                          elevation: 0,
                          bottom: TabBar(
                            isScrollable: true,
                            labelColor: Colors.black87,
                            indicatorColor: Colors.black87,
                            indicatorSize: TabBarIndicatorSize.label,
                            unselectedLabelStyle: TextStyle(
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.heading),
                            labelStyle: TextStyle(
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.heading),
                            tabs: const [
                              Tab(
                                text: "Appointments",
                              ),
                              Tab(
                                text: "Video Consultation",
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Expanded(
                        child: TabBarView(children: [
                          if (isNormalAppointment.isEmpty) ...[
                            NoDataScreen(
                              noDataSelect: NoDataSelectType.reminders,
                            ),
                          ],
                          if (isNormalAppointment.isNotEmpty) ...[
                            generalAppointment(snapshot, databaseHelper,
                                remindDurationProvider)
                          ],
                          if (isVideoAppointment.isEmpty) ...[
                            NoDataScreen(
                              noDataSelect: NoDataSelectType.reminders,
                            ),
                          ],
                          if (isVideoAppointment.isNotEmpty) ...[
                            videoConsultation(snapshot, remindDurationProvider,
                                databaseHelper)
                          ],
                        ]),
                      ),
                    ],
                  );
                } else {
                  return NoDataScreen(
                    noDataSelect: NoDataSelectType.appointment,
                  );
                }
              }),
        ),
      ),
    );
  }

  ListView generalAppointment(AsyncSnapshot<List<VlccReminderModel>> snapshot,
      DatabaseHelper databaseHelper, ReminderProvider remindDurationProvider) {
    return ListView.builder(
        itemCount: snapshot.data!.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (isBeforeToday(
              temp: DateTime.fromMillisecondsSinceEpoch(
                  snapshot.data![index].appointmentDateSecond * 1000))) {
            databaseHelper.deleteReminder(
              appointmentId: snapshot.data![index].appointmentId,
            );
          }
          return snapshot.data![index].appointmentType == 0
              ? Container(
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
                      SizedBox(
                          width: 52,
                          child: Image.asset("assets/images/rounded.png")),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    snapshot.data![index].reminderTitle,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: FontSize.large),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      timeAgo(
                                        milliseconds:
                                            snapshot.data![index].insertTime,
                                      ),
                                      style: TextStyle(
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.small),
                                    ),
                                    Text(
                                      DateFormat('hh:mm a').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                                snapshot.data![index]
                                                        .appointmentDateSecond *
                                                    1000)
                                            .subtract(
                                          Duration(
                                              seconds: snapshot.data![index]
                                                  .reminderTriggerTime),
                                        ),
                                      ),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.small),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: MarginSize.small),
                              child: Text(
                                snapshot.data![index].addressLine1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.normal),
                              ),
                            ),
                            Text(
                              snapshot.data![index].addressLine2,
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal),
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: MarginSize.small),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.orangeProfile,
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: PaddingSize.extraLarge,
                                        vertical: 8),
                                    child: Text(
                                      "View Details",
                                      style: TextStyle(
                                          color: AppColors.orange,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.large),
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    timeSelector(
                                        reminderProvider:
                                            remindDurationProvider,
                                        timerSet: snapshot
                                            .data![index].reminderTriggerTime);
                                    editReminderDialog(
                                        vlccReminderModel:
                                            snapshot.data![index],
                                        appointmentIndex: snapshot.data![index]
                                                .appointmentIndex ??
                                            0,
                                        appointmentTime: snapshot
                                            .data![index].appointmentDateSecond,
                                        serviceName:
                                            snapshot.data![index].reminderTitle,
                                        selectionTime: snapshot
                                            .data![index].reminderTriggerTime,
                                        index: index,
                                        appointmentId: snapshot
                                            .data![index].appointmentId);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: MarginSize.normal),
                                    child: SvgPicture.asset(
                                        "assets/icons/editor.svg"),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    flutterLocalNotificationsPlugin.cancel(
                                        snapshot.data![index]
                                                .appointmentIndex ??
                                            index);
                                    databaseHelper.deleteReminder(
                                      appointmentId:
                                          snapshot.data![index].appointmentId,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/trash.svg",
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox();
        });
  }

  ListView videoConsultation(AsyncSnapshot<List<VlccReminderModel>> snapshot,
      ReminderProvider remindDurationProvider, DatabaseHelper databaseHelper) {
    return ListView.builder(
        itemCount: snapshot.data!.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return snapshot.data![index].appointmentType == 1
              ? Container(
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
                      SizedBox(
                          width: 52,
                          child: Image.asset("assets/images/rounded.png")),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    snapshot.data![index].reminderTitle,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: FontSize.large),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      timeAgo(
                                        milliseconds:
                                            snapshot.data![index].insertTime,
                                      ),
                                      style: TextStyle(
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.small),
                                    ),
                                    Text(
                                      DateFormat('hh:mm a').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                                snapshot.data![index]
                                                        .appointmentDateSecond *
                                                    1000)
                                            .subtract(
                                          Duration(
                                              seconds: snapshot.data![index]
                                                  .reminderTriggerTime),
                                        ),
                                      ),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.small),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: MarginSize.small),
                              child: Text(
                                snapshot.data![index].addressLine1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.normal),
                              ),
                            ),
                            Text(
                              snapshot.data![index].addressLine2,
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal),
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: MarginSize.small),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.orangeProfile,
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: PaddingSize.extraLarge,
                                        vertical: 8),
                                    child: Text(
                                      "View Details",
                                      style: TextStyle(
                                          color: AppColors.orange,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.large),
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    timeSelector(
                                        reminderProvider:
                                            remindDurationProvider,
                                        timerSet: snapshot
                                            .data![index].reminderTriggerTime);
                                    editReminderDialog(
                                      vlccReminderModel: snapshot.data![index],
                                      appointmentIndex: snapshot
                                              .data![index].appointmentIndex ??
                                          0,
                                      appointmentTime: snapshot
                                          .data![index].appointmentDateSecond,
                                      serviceName:
                                          snapshot.data![index].reminderTitle,
                                      selectionTime: snapshot
                                          .data![index].reminderTriggerTime,
                                      index: index,
                                      appointmentId:
                                          snapshot.data![index].appointmentId,
                                    );
                                    // editReminderConsultationDialog();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: MarginSize.normal),
                                    child: SvgPicture.asset(
                                        "assets/icons/editor.svg"),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    flutterLocalNotificationsPlugin.cancel(
                                      snapshot.data![index].appointmentId,
                                    );
                                    databaseHelper.deleteReminder(
                                      appointmentId:
                                          snapshot.data![index].appointmentId,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/trash.svg",
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox();
        });
  }
}
