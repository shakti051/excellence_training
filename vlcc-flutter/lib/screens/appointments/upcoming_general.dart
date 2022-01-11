import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/dashboard/viewdetails_upcoming.dart';
import 'package:vlcc/widgets/appointment_widgets/add_reminder.dart';
import 'package:vlcc/widgets/appointment_widgets/view_reminder.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import 'package:vlcc/widgets/nodata.dart';

class UpcomingGeneralAppointment extends StatefulWidget {
  const UpcomingGeneralAppointment({Key? key}) : super(key: key);

  @override
  _UpcomingGeneralAppointmentState createState() =>
      _UpcomingGeneralAppointmentState();
}

class _UpcomingGeneralAppointmentState
    extends State<UpcomingGeneralAppointment> {
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  viewReminderDialog({required VlccReminderModel vlccReminderModel}) {
    return showDialog(
        context: context,
        builder: (BuildContext c) {
          return ViewReminder(
            vlccReminderModel: vlccReminderModel,
          );
        });
  }

  String titleCase(String text) {
    if (text.length <= 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1);
      return '$first$rest';
    });
    return capitalized.join(' ');
  }

  addReminderDialog(
      {required int index,
      int appointmentType = 0,
      required String addressLine1,
      required String addressLine2,
      required String appointmentId,
      required DateTime appointmentDate,
      required String title,
      required int appointmentSeconds}) {
    return showDialog(
        context: context,
        builder: (BuildContext c) {
          return AddReminder(
            appointmentType: appointmentType,
            addressLine1: addressLine1,
            appointmentseconds: appointmentSeconds,
            index: index,
            serviceName: title,
            addressLine2: addressLine2,
            appointmentDate: appointmentDate,
            appointmentId: appointmentId,
          );
        });
  }

  int convertToTime({required DateTime temp}) {
    var seconds = temp.difference(DateTime.now()).inSeconds;
    return seconds;
  }

  int findSnapshotIndex(
      {required int appointmentId,
      required List<VlccReminderModel> listReminder}) {
    var result = listReminder
        .indexWhere((element) => element.appointmentId == appointmentId);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();
    final databaseHelper = context.read<DatabaseHelper>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
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
        title: Text(
          "Upcoming appointments",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.heading),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(PaddingSize.extraLarge),
        child: consulationCard(
            dashboardProvider: dashboardProvider,
            databaseHelper: databaseHelper),
      ),
    );
  }

  bool isBeforeToday({required DateTime temp}) {
    var result = temp.isBefore(DateTime.now());
    return result;
  }

  Widget consulationCard(
      {required DashboardProvider dashboardProvider,
      required DatabaseHelper databaseHelper}) {
    var generalAppointment = dashboardProvider.generalAppointmentList;
    return generalAppointment.isNotEmpty
        ? FutureBuilder<List<VlccReminderModel>>(
            future: databaseHelper.getReminders(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: generalAppointment.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    List<VlccReminderModel> snap = [];
                    if (snapshot.hasData) {
                      snap = snapshot.data!
                          .where(
                            (element) =>
                                element.appointmentId ==
                                int.parse(
                                    generalAppointment[index].appointmentId),
                          )
                          .toList();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 64, 128, 0.04),
                                blurRadius: 10,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              )
                            ],
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                width: 52,
                                child: Image.asset(PNGAsset.clinicLogo)),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          generalAppointment[index].serviceName,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700,
                                              fontSize: FontSize.large),
                                        ),
                                      ),
                                      Text(
                                        _dateFormatter.format(
                                          generalAppointment[index]
                                                  .appointmentDate ??
                                              DateTime.now(),
                                        ),
                                        style: TextStyle(
                                            color: AppColors.blue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize.small),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: MarginSize.small),
                                    child: Text(
                                      titleCase(generalAppointment[index]
                                          .addressLine1
                                          .toLowerCase()),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.normal),
                                    ),
                                  ),
                                  Text(
                                    titleCase(generalAppointment[index]
                                        .addressLine2
                                        .toLowerCase()),
                                    style: TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSize.normal),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewDetailsUpcoming(
                                                        index: index,
                                                        dashboardProvider:
                                                            dashboardProvider,
                                                        generalAppointment:
                                                            generalAppointment)),
                                          );
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: MarginSize.small),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.orangeProfile,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    PaddingSize.extraLarge,
                                                vertical: 8),
                                            child: Text(
                                              "View Details",
                                              style: TextStyle(
                                                  color: AppColors.orange,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: FontSize.large),
                                            )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (snap.isEmpty) {
                                            addReminderDialog(
                                              appointmentType: 0,
                                              appointmentSeconds:
                                                  generalAppointment[index]
                                                      .appointmentStartDateTime,
                                              index: 0,
                                              title: generalAppointment[index]
                                                  .serviceName,
                                              addressLine1:
                                                  generalAppointment[index]
                                                      .addressLine1,
                                              addressLine2:
                                                  generalAppointment[index]
                                                      .addressLine2,
                                              appointmentDate:
                                                  generalAppointment[index]
                                                          .appointmentDate ??
                                                      DateTime.now(),
                                              appointmentId:
                                                  generalAppointment[index]
                                                      .appointmentId,
                                            );
                                          } else {
                                            viewReminderDialog(
                                              vlccReminderModel: snapshot
                                                  .data![findSnapshotIndex(
                                                appointmentId: int.parse(
                                                    generalAppointment[index]
                                                        .appointmentId),
                                                listReminder:
                                                    snapshot.data ?? [],
                                              )],
                                            );
                                          }
                                        },
                                        child: Visibility(
                                          visible: !isBeforeToday(
                                                temp: DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                  generalAppointment[index]
                                                          .appointmentStartDateTime *
                                                      1000,
                                                ),
                                              ) &&
                                              (generalAppointment[index]
                                                          .appointmentStatus
                                                          .toLowerCase() ==
                                                      "booked" ||
                                                  generalAppointment[index]
                                                          .appointmentStatus
                                                          .toLowerCase() ==
                                                      "rescheduled"),
                                          child: SvgPicture.asset(
                                            "assets/images/reminder.svg",
                                            color: snap.isEmpty
                                                ? AppColors.grey
                                                : AppColors.orange,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            })
        : NoDataScreen(noDataSelect: NoDataSelectType.upcomingAppointment);
  }
}
