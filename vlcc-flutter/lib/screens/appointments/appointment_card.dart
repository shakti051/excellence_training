import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/screens/appointments/view_details.dart';
import 'package:vlcc/widgets/appointment_widgets/add_reminder.dart';
import 'package:vlcc/widgets/appointment_widgets/view_reminder.dart';

class AppointmentCard extends StatefulWidget {
  final AppointmentListModel appointmentListModel;
  final int index;
  final String timeString;
  final String dateString;
  final bool isReminderActive;
  final List<VlccReminderModel> vlccReminderModelList;
  final VoidCallback callback;

  const AppointmentCard({
    Key? key,
    required this.appointmentListModel,
    required this.index,
    required this.timeString,
    required this.dateString,
    required this.isReminderActive,
    required this.vlccReminderModelList,
    required this.callback,
  }) : super(key: key);

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  late AppointmentListModel _appointmentListModel;
  List<VlccReminderModel> vlccReminderModelList = [];
  int index = 0;
  String timeString = '';
  String dateString = '';
  bool isReminderActive = false;

  @override
  void initState() {
    super.initState();
    _appointmentListModel = widget.appointmentListModel;
    index = widget.index;
    timeString = widget.timeString;
    dateString = widget.dateString;
    isReminderActive = widget.isReminderActive;
    vlccReminderModelList = widget.vlccReminderModelList;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // databaseHelper.deleteReminder(
          //     id: index);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: MarginSize.normal),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 64, 128, 0.04),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ],
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(PNGAsset.clinicLogo),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            _appointmentListModel.appointmentDetails![index]
                                    .serviceName.toTitleCase.isEmpty
                                ? 'Pseudo Service Name'
                                : _appointmentListModel
                                    .appointmentDetails![index]
                                    .serviceName
                                    .toTitleCase,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.large),
                          ),
                        ),
                        SizedBox(width: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _appointmentListModel
                                  .appointmentDetails![index].appointmentStatus,
                              style: TextStyle(
                                color: AppColors.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.small,
                              ),
                            ),
                            Text(
                              dateString,
                              style: TextStyle(
                                  color: AppColors.aquaGreen,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.small),
                            ),
                            Text(
                              timeString,
                              style: TextStyle(
                                  color: AppColors.aquaGreen,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.small),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: MarginSize.small),
                      child: Text(
                        _appointmentListModel
                            .appointmentDetails![index].addressLine1
                            .toLowerCase()
                            .toTitleCase,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.normal),
                      ),
                    ),
                    Text(
                      _appointmentListModel
                          .appointmentDetails![index].addressLine2
                          .toLowerCase()
                          .toTitleCase,
                      style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.normal),
                    ),
                    Text(
                      _appointmentListModel.appointmentDetails![index].cityName
                          .toLowerCase()
                          .toTitleCase,
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
                            bool isVideoCall = false;
                            if (_appointmentListModel
                                    .appointmentDetails?[index].appointmentType
                                    .toLowerCase() ==
                                'Video Consultations'.toLowerCase()) {
                              isVideoCall = true;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewDetails(
                                  appointmentListModel: _appointmentListModel,
                                  index: index,
                                  isVideoCall: isVideoCall,
                                ),
                              ),
                            );

                            // .then((value) async {
                            //   log('callback');
                            //   widget.callback();
                            // });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: MarginSize.small),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.orangeProfile, width: 1.0),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: PaddingSize.extraLarge,
                                vertical: 8),
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                color: AppColors.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.large,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: true,
                          // visible: !isBeforeToday(
                          //       temp: DateTime.fromMillisecondsSinceEpoch(
                          //           _appointmentListModel
                          //                   .appointmentDetails![index]
                          //                   .appointmentStartDateTime *
                          //               1000),
                          //     ) &&
                          //     (_appointmentListModel.appointmentDetails![index]
                          //                 .appointmentStatus
                          //                 .toLowerCase() ==
                          //             "booked" ||
                          //         _appointmentListModel
                          //                 .appointmentDetails![index]
                          //                 .appointmentStatus
                          //                 .toLowerCase() ==
                          //             "rescheduled"),
                          child: GestureDetector(
                            onTap: () {
                              if (!isReminderActive) {
                                addReminderDialog(
                                  appointmentType: 0,
                                  appointmentSeconds: _appointmentListModel
                                      .appointmentDetails![index]
                                      .appointmentStartDateTime,
                                  index: index,
                                  title: _appointmentListModel
                                      .appointmentDetails![index].serviceName,
                                  addressLine1: _appointmentListModel
                                      .appointmentDetails![index].addressLine1,
                                  addressLine2: _appointmentListModel
                                      .appointmentDetails![index].addressLine2,
                                  appointmentDate: _appointmentListModel
                                          .appointmentDetails![index]
                                          .appointmentDate ??
                                      DateTime.now(),
                                  appointmentId: _appointmentListModel
                                      .appointmentDetails![index].appointmentId,
                                );
                              } else {
                                viewReminderDialog(
                                    vlccReminderModel:
                                        vlccReminderModelList[findSnapshotIndex(
                                  appointmentId: int.parse(_appointmentListModel
                                      .appointmentDetails![index]
                                      .appointmentId),
                                  listReminder: vlccReminderModelList,
                                )]);
                              }
                            },
                            child: SvgPicture.asset(
                              "assets/images/reminder.svg",
                              color: !isReminderActive
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
        ));
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

  viewReminderDialog({required VlccReminderModel vlccReminderModel}) {
    return showDialog(
        context: context,
        builder: (BuildContext c) {
          return ViewReminder(
            vlccReminderModel: vlccReminderModel,
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

  bool isBeforeToday({required DateTime temp}) {
    var result = temp.isBefore(DateTime.now());
    return result;
  }
}
