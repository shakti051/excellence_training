import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/src/provider.dart';
import 'package:vlcc/components/add_clinic_logo.dart';
import 'package:vlcc/models/appointment_expert_model.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/providers/reminder_provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/appointment_widgets/appointment_widgets.dart';
import 'package:vlcc/widgets/nodata.dart';
import 'expert_view_details.dart';

class FutureConsultaion extends StatefulWidget {
  AppointmentExpertModel? appointmentExpertModel;
  FutureConsultaion({Key? key, this.appointmentExpertModel}) : super(key: key);

  @override
  _FutureConsultaionState createState() => _FutureConsultaionState();
}

class _FutureConsultaionState extends State<FutureConsultaion> {
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

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

  @override
  Widget build(BuildContext context) {
    final remindProvider = context.watch<ReminderProvider>();
    return Scaffold(
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
            child: Text("Upcoming Consultation",
                style: TextStyle(
                    height: 1.5,
                    color: Colors.black87,
                    fontFamily: FontName.frutinger,
                    fontWeight: FontWeight.w700,
                    fontSize: FontSize.extraLarge)),
          ),
        ),
      ),
      body: widget.appointmentExpertModel!.appointmentexpertDetails!.isNotEmpty
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingSize.extraLarge),
                child: ListView.builder(
                    itemCount: widget.appointmentExpertModel!
                        .appointmentexpertDetails!.length,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return (widget
                                      .appointmentExpertModel!
                                      .appointmentexpertDetails![index]
                                      .appointmentType!
                                      .toLowerCase() ==
                                  'video consultations' &&
                              DateTime.parse(widget
                                      .appointmentExpertModel!
                                      .appointmentexpertDetails![index]
                                      .appointmentDate!)
                                  .isAfter(DateTime.now()))
                          ? Container(
                              margin:
                                  EdgeInsets.only(bottom: MarginSize.normal),
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
                                  AddClinicLogo(),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                widget
                                                    .appointmentExpertModel!
                                                    .appointmentexpertDetails![
                                                        index]
                                                    .clientname!,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: FontSize.large),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget
                                                      .appointmentExpertModel!
                                                      .appointmentexpertDetails![
                                                          index]
                                                      .appointmentStatus!,
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.aquaGreen,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: FontSize.small),
                                                ),
                                                Text(
                                                  Jiffy(DateTime.parse(widget
                                                          .appointmentExpertModel!
                                                          .appointmentexpertDetails![
                                                              index]
                                                          .appointmentDate!))
                                                      .yMMMEd,
                                                  style: TextStyle(
                                                      color: AppColors.orange,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: FontSize.small),
                                                ),
                                                Text(
                                                  widget
                                                      .appointmentExpertModel!
                                                      .appointmentexpertDetails![
                                                          index]
                                                      .appointmentStartTime!,
                                                  style: TextStyle(
                                                      color: AppColors.orange,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                            widget
                                                .appointmentExpertModel!
                                                .appointmentexpertDetails![
                                                    index]
                                                .bookingId!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: FontSize.normal),
                                          ),
                                        ),
                                        Text(
                                          widget
                                              .appointmentExpertModel!
                                              .appointmentexpertDetails![index]
                                              .appointmentServiceexpertDtl![0]
                                              .serviceName!,
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
                                                bool isVideoCall = false;
                                                if (widget
                                                        .appointmentExpertModel
                                                        ?.appointmentexpertDetails?[
                                                            index]
                                                        .appointmentType
                                                        ?.toLowerCase() ==
                                                    'Video Consultations'
                                                        .toLowerCase()) {
                                                  isVideoCall = true;
                                                }
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ExpertViewDetails(
                                                            appointmentExpertModel:
                                                                widget
                                                                    .appointmentExpertModel,
                                                            index: index,
                                                            isVideoCall:
                                                                isVideoCall,
                                                          )),
                                                );
                                              },
                                              child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical:
                                                          MarginSize.small),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .orangeProfile,
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: PaddingSize
                                                          .extraLarge,
                                                      vertical: 8),
                                                  child: Text(
                                                    "View Details",
                                                    style: TextStyle(
                                                        color: AppColors.orange,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize:
                                                            FontSize.large),
                                                  )),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (!remindProvider
                                                    .reminderAddedAt
                                                    .contains(widget
                                                        .appointmentExpertModel!
                                                        .appointmentexpertDetails![
                                                            index]
                                                        .appointmentId!)) {
                                                  addReminderDialog(
                                                    appointmentType: 1,
                                                    appointmentSeconds: widget
                                                        .appointmentExpertModel!
                                                        .appointmentexpertDetails![
                                                            index]
                                                        .appointmentStartDateTime!,
                                                    index: index,
                                                    title: widget
                                                        .appointmentExpertModel!
                                                        .appointmentexpertDetails![
                                                            index]
                                                        .appointmentServiceexpertDtl![
                                                            0]
                                                        .serviceName!,
                                                    addressLine1: widget
                                                        .appointmentExpertModel!
                                                        .appointmentexpertDetails![
                                                            index]
                                                        .centerCode!,
                                                    addressLine2: widget
                                                        .appointmentExpertModel!
                                                        .appointmentexpertDetails![
                                                            index]
                                                        .centerName!,
                                                    appointmentDate:
                                                        DateTime.parse(widget
                                                            .appointmentExpertModel!
                                                            .appointmentexpertDetails![
                                                                index]
                                                            .appointmentDate!),
                                                    appointmentId: widget
                                                        .appointmentExpertModel!
                                                        .appointmentexpertDetails![
                                                            index]
                                                        .appointmentId!,
                                                  );
                                                } else {
                                                  viewReminderDialog(
                                                      vlccReminderModel:
                                                          VlccReminderModel(
                                                    addressLine1: widget
                                                        .appointmentExpertModel!
                                                        .appointmentexpertDetails![
                                                            index]
                                                        .centerCode!,
                                                    addressLine2: widget
                                                        .appointmentExpertModel!
                                                        .appointmentexpertDetails![
                                                            index]
                                                        .centerName!,
                                                  ));
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                  "assets/images/reminder.svg",
                                                  color: remindProvider
                                                          .reminderAddedAt
                                                          .contains(widget
                                                              .appointmentExpertModel!
                                                              .appointmentexpertDetails![
                                                                  index]
                                                              .appointmentId!)
                                                      ? AppColors.orange
                                                      : Colors.grey),
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
                    }),
              ),
            )
          : NoDataScreen(noDataSelect: NoDataSelectType.upcomingAppointment),
    );
  }
}
