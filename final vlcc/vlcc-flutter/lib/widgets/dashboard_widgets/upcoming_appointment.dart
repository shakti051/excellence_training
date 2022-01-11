import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/screens/appointments/appointment_card.dart';
import 'package:vlcc/screens/appointments/upcoming_general.dart';
import 'package:vlcc/widgets/appointment_widgets/add_reminder.dart';
import 'package:vlcc/widgets/appointment_widgets/view_reminder.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_widgets.dart';
import 'package:vlcc/widgets/nodata.dart';

class UpcomingAppointment extends StatefulWidget {
  const UpcomingAppointment({Key? key}) : super(key: key);

  @override
  State<UpcomingAppointment> createState() => _UpcomingAppointmentState();
}

class _UpcomingAppointmentState extends State<UpcomingAppointment> {
  AppointmentListModel _appointmentListModel = AppointmentListModel();

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();
    final databaseHelper = context.watch<DatabaseHelper>();
    _appointmentListModel = dashboardProvider.allAppointmentList;
    _filterAppointments();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Upcoming appointment",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: FontSize.large),
              ),
              Spacer(),
              Visibility(
                visible:
                    (_appointmentListModel.appointmentDetails?.isNotEmpty ??
                            false) &&
                        _appointmentListModel.appointmentDetails?.length != 1,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: UpcomingGeneralAppointment()));
                    },
                    child: Icon(Icons.arrow_forward)),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          consulationCard(databaseHelper: databaseHelper),
        ],
      ),
    );
  }

  Widget consulationCard({required DatabaseHelper databaseHelper}) {
    List<VlccReminderModel> vlccReminderModelList = [];
    int appointmentsLength =
        _appointmentListModel.appointmentDetails?.length ?? 0;
    return FutureBuilder<List<VlccReminderModel>>(
      future: databaseHelper.getReminders(),
      builder: (context, snapshot) {
        return appointmentsLength > 0
            ? ListView.builder(
                itemCount: appointmentsLength > 0 ? 1 : 0,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isReminderActive = false;
                  vlccReminderModelList = snapshot.data ?? [];
                  if (snapshot.hasData) {
                    vlccReminderModelList = snapshot.data ?? [];
                    for (var element in vlccReminderModelList) {
                      if (element.reminderTitle ==
                              _appointmentListModel
                                  .appointmentDetails![index].serviceName &&
                          element.appointmentId ==
                              int.parse(
                                _appointmentListModel
                                    .appointmentDetails![index].appointmentId,
                              )) {
                        isReminderActive = true;
                      }
                    }
                  }

                  DateTime date = _appointmentListModel
                          .appointmentDetails![index].appointmentDate ??
                      DateTime.now();

                  String timeString = DateFormat.jm().format(
                      DateFormat("hh:mm:ss").parse(_appointmentListModel
                          .appointmentDetails![index].appointmentTime));
                  String dateString = Jiffy(date).yMMMEd;
                  if (_appointmentListModel.appointmentDetails![index]
                      .serviceName.toTitleCase.isEmpty) {
                    _appointmentListModel.appointmentDetails?[index]
                        .serviceName = 'Pseudo Service Name';
                  }

                  return AppointmentCard(
                    appointmentListModel: _appointmentListModel,
                    index: index,
                    timeString: timeString,
                    dateString: dateString,
                    isReminderActive: isReminderActive,
                    vlccReminderModelList: vlccReminderModelList,
                    callback: () {},
                  );
                },
              )
            : NoDataScreen(
                noDataSelect: NoDataSelectType.upcomingAppointment,
              );
      },
    );
  }

  void _filterAppointments() {
    _appointmentListModel.appointmentDetails!.removeWhere((element) {
      bool isBeforeNow = DateTime.fromMillisecondsSinceEpoch(
              element.appointmentStartDateTime * 1000)
          .isBefore(
        DateTime.now(),
      );
      bool isCancelled = element.appointmentStatus.toLowerCase() == 'cancelled';

      bool isVideo =
          element.appointmentType.toLowerCase() == 'video consultations';

      return isBeforeNow || isCancelled || isVideo;
    });
  }

  int convertToTime({required DateTime temp}) {
    var seconds = temp.difference(DateTime.now()).inSeconds;
    return seconds;
  }

  viewReminderDialog({required VlccReminderModel vlccReminderModel}) {
    return showDialog(
        context: context,
        builder: (BuildContext c) {
          return ViewReminder(
            vlccReminderModel: vlccReminderModel,
          );
        });
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

  int findSnapshotIndex(
      {required int appointmentId,
      required List<VlccReminderModel> listReminder}) {
    var result = listReminder
        .indexWhere((element) => element.appointmentId == appointmentId);
    return result;
  }
}
