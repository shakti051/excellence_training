import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/appointment_widgets/add_reminder.dart';
import 'package:vlcc/widgets/appointment_widgets/view_reminder.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import 'package:vlcc/widgets/nodata.dart';

class UpcomingVideoConsultation extends StatefulWidget {
  const UpcomingVideoConsultation({Key? key}) : super(key: key);

  @override
  _UpcomingVideoConsultationState createState() =>
      _UpcomingVideoConsultationState();
}

class _UpcomingVideoConsultationState extends State<UpcomingVideoConsultation> {
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
          "Upcoming consultations",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.heading),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: PaddingSize.extraLarge),
        child: consulationCard(
            dashboardProvider: dashboardProvider,
            databaseHelper: databaseHelper),
      ),
    );
  }

  Widget consulationCard(
      {required DashboardProvider dashboardProvider,
      required DatabaseHelper databaseHelper}) {
    var videoAppointment = dashboardProvider.videoAppointmentList;
    return videoAppointment.isNotEmpty
        ? FutureBuilder<List<VlccReminderModel>>(
            future: databaseHelper.getReminders(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: videoAppointment.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    List<VlccReminderModel> snap = [];
                    if (snapshot.hasData) {
                      snap = snapshot.data!
                          .where(
                            (element) =>
                                element.appointmentId ==
                                int.parse(
                                    videoAppointment[index].appointmentId),
                          )
                          .toList();
                    }
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 64, 128, 0.04),
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                )
                              ],
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 52,
                                  child: SvgPicture.asset(
                                      "assets/images/beauty_brush.svg")),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      videoAppointment[index].serviceName,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700,
                                          fontSize: FontSize.large),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: MarginSize.small),
                                      child: Text(
                                        videoAppointment[index].addressLine1,
                                        style: TextStyle(
                                            color: AppColors.orange,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize.normal),
                                      ),
                                    ),
                                    Text(
                                      "In 15 mins",
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.normal),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
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
                                              "Video Call",
                                              style: TextStyle(
                                                  color: AppColors.orange,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: FontSize.large),
                                            )),
                                        InkWell(
                                          onTap: () {
                                            if (snap.isEmpty) {
                                              addReminderDialog(
                                                  index: 0,
                                                  addressLine1:
                                                      videoAppointment[index]
                                                          .addressLine1,
                                                  addressLine2:
                                                      videoAppointment[index]
                                                          .addressLine2,
                                                  appointmentId:
                                                      videoAppointment[index]
                                                          .appointmentId,
                                                  appointmentDate:
                                                      videoAppointment.first
                                                              .appointmentDate ??
                                                          DateTime.now(),
                                                  title: videoAppointment[index]
                                                      .serviceName,
                                                  appointmentSeconds:
                                                      convertToTime(
                                                    temp: videoAppointment[
                                                                index]
                                                            .appointmentDate ??
                                                        DateTime.now(),
                                                  ));
                                            } else {
                                              viewReminderDialog(
                                                vlccReminderModel: snapshot
                                                    .data![findSnapshotIndex(
                                                  appointmentId: int.parse(
                                                      videoAppointment[index]
                                                          .appointmentId),
                                                  listReminder:
                                                      snapshot.data ?? [],
                                                )],
                                              );
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            "assets/images/reminder.svg",
                                            color: snap.isEmpty
                                                ? AppColors.grey
                                                : AppColors.orange,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
                  });
            })
        : NoDataScreen(noDataSelect: NoDataSelectType.upcomingAppointment);
  }
}
