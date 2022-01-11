import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/models/reshedule_appointment_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/bottom_bar/bottom_bar.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class PendingAppointment extends StatefulWidget {
  final int index;
  final DateTime? currentDate;
  final TimeOfDay? time;
  final String originalDate;
  final String originalTime;
  final VlccShared vlccShared;
  final AppointmentListModel? appointmentListModel;

  const PendingAppointment({
    Key? key,
    this.index = 0,
    this.appointmentListModel,
    this.currentDate,
    this.time,
    required this.originalDate,
    required this.originalTime,
    required this.vlccShared,
  }) : super(key: key);

  @override
  _PendingAppointmentState createState() => _PendingAppointmentState();
}

class _PendingAppointmentState extends State<PendingAppointment> {
  TimeOfDay? time;
  TimeOfDay? picked;
  String _url = 'Attached Documents';
  final Services _services = Services();
  ResheduleAppointmentModel? resheduleAppointmentModel;
  bool isLoading = false;

  @override
  void initState() {
    time = TimeOfDay.now();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _showSnackbar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShodow,
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
                  if (!isLoading) {
                    Navigator.pop(context);
                  }
                },
                icon: SvgPicture.asset(SVGAsset.backButton),
              ),
            ),
          ),
          title: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text("Appointment Details",
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.black87,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.extraLarge)),
              ),
              Text(
                  widget.appointmentListModel!.appointmentDetails![widget.index]
                      .appointmentStatus,
                  style: TextStyle(
                      color: widget
                                  .appointmentListModel!
                                  .appointmentDetails![widget.index]
                                  .appointmentStatus ==
                              'Approved'
                          ? AppColors.aquaGreen
                          : AppColors.orange,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
            ],
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 24, top: 8),
                child:
                    SvgPicture.asset(SVGAsset.reminder, color: Colors.black87)),
          ],
        ),
      ),
      body: SafeArea(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.logoOrange,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PaddingSize.extraLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24),
                          SizedBox(height: 32),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              shadowColor: AppColors.whiteShodow,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 12, top: 12, bottom: 4),
                                    child: Text("Speciality",
                                        style: TextStyle(
                                            fontFamily: FontName.frutinger,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize.normal)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: PaddingSize.small),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: AppColors.greyBackground,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 14),
                                            child: SvgPicture.asset(
                                                "assets/images/category.svg")),
                                        Flexible(
                                          child: Text(
                                              widget
                                                  .appointmentListModel!
                                                  .appointmentDetails![
                                                      widget.index]
                                                  .serviceName,
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontName.frutinger,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: FontSize.large)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    margin: EdgeInsets.only(left: 12),
                                    child: Text("Place",
                                        style: TextStyle(
                                            fontFamily: FontName.frutinger,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize.normal)),
                                  ),
                                  Container(
                                    height: 48,
                                    margin: EdgeInsets.only(
                                        top: 4, left: 12, right: 12),
                                    decoration: BoxDecoration(
                                        color: AppColors.greyBackground,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 14),
                                            child: SvgPicture.asset(
                                                "assets/images/health_clinic.svg")),
                                        Text(
                                            widget
                                                .appointmentListModel!
                                                .appointmentDetails![
                                                    widget.index]
                                                .areaName,
                                            style: TextStyle(
                                                fontFamily: FontName.frutinger,
                                                fontWeight: FontWeight.w600,
                                                fontSize: FontSize.large)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  SizedBox(
                                    height: 75,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: MarginSize.middle),
                                                child: Text("Preferred date",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            FontName.frutinger,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize:
                                                            FontSize.normal)),
                                              ),
                                              SizedBox(height: 4),
                                              InkWell(
                                                onTap: () {
                                                  //  _selectedDate(context);
                                                },
                                                child: Container(
                                                  height: 46,
                                                  margin: EdgeInsets.only(
                                                      left: MarginSize.middle),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .backBorder),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 14),
                                                        child: SvgPicture.asset(
                                                            "assets/images/invitation.svg",
                                                            color: AppColors
                                                                .calanderColor),
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 15),
                                                        child: Text(
                                                          DateFormat(
                                                                  "dd/MM/yyyy")
                                                              .format(widget
                                                                  .currentDate!)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontFamily:
                                                                  FontName
                                                                      .frutinger,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: FontSize
                                                                  .normal),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Preferred time",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          FontName.frutinger,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          FontSize.normal)),
                                              SizedBox(height: 4),
                                              InkWell(
                                                onTap: () {
                                                  //  _selectTime(context);
                                                },
                                                child: Container(
                                                  height: 46,
                                                  margin: EdgeInsets.only(
                                                      right: MarginSize.middle),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .backBorder),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 14),
                                                        child: SvgPicture.asset(
                                                            "assets/images/clock.svg",
                                                            color: AppColors
                                                                .calanderColor),
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 15),
                                                        child: Text(
                                                          widget.time!
                                                              .format(context),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontFamily:
                                                                  FontName
                                                                      .frutinger,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: FontSize
                                                                  .normal),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12)
                                ],
                              )),
                          SizedBox(height: 25),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            shadowColor: AppColors.whiteShodow,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(left: 12, top: 12),
                                  child: Text("Problem description (Optional)",
                                      style: TextStyle(
                                          fontFamily: FontName.frutinger,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.normal)),
                                ),
                                SizedBox(height: 4),
                                Visibility(
                                  visible: widget
                                              .appointmentListModel!
                                              .appointmentDetails![widget.index]
                                              .appointmentRemark ==
                                          ""
                                      ? false
                                      : true,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    padding: EdgeInsets.all(12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: AppColors.backBorder),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Text(
                                        widget
                                            .appointmentListModel!
                                            .appointmentDetails![widget.index]
                                            .appointmentRemark,
                                        style: TextStyle(
                                            height: 1.5,
                                            fontFamily: FontName.frutinger,
                                            fontWeight: FontWeight.w400,
                                            fontSize: FontSize.large)),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12),
                                  child: Text("Attachments (Optional)",
                                      style: TextStyle(
                                          fontFamily: FontName.frutinger,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.normal)),
                                ),
                                SizedBox(height: 24),
                                GestureDetector(
                                  onTap: _launchURL,
                                  child: Visibility(
                                    visible: widget
                                                .appointmentListModel!
                                                .appointmentDetails![
                                                    widget.index]
                                                .appointmentAttDoc ==
                                            ""
                                        ? false
                                        : true,
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: MarginSize.normal),
                                        height: 56,
                                        decoration: BoxDecoration(
                                            color: AppColors.greyBackground,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Row(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                        MarginSize.normal),
                                                child: Icon(
                                                    Icons.picture_as_pdf,
                                                    color: Colors.redAccent)),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(_url,
                                                      style: TextStyle(
                                                          fontFamily: FontName
                                                              .frutinger,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              FontSize.normal)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 16)
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(height: 12)
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          GradientButton(
                            onPressed: () {
                              if (!isLoading) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConsumerBottomBar(selectedPage: 2),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(right: MarginSize.small),
                                  child: Text("Show appointments",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.large,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 42)
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }

  _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 18,
          child: Text(
            'Appointment Resheduled',
            style: TextStyle(color: Colors.white),
          ),
        ),
        duration: const Duration(milliseconds: 5000),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        action: SnackBarAction(
          textColor: AppColors.orange,
          label: 'Undo',
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            var body = {
              'client_mobile': widget.vlccShared.mobileNum,
              'auth_token': widget.vlccShared.authToken,
              'device_id': widget.vlccShared.deviceId,
              'appointment_date': widget.originalDate,
              'appointment_start_time': widget.originalTime,
              'appointment_end_time': '20:00:00',
              'AppointmentId': widget.appointmentListModel!
                  .appointmentDetails![widget.index].appointmentId,
              'cancellation_comment': "test",
            };
            var response = await _services.callApi(body,
                '/api/api_appointment_reschedule_rbs.php?request=appointment_reschedule',
                apiName: 'Reshedule Appointment');
            setState(() {
              isLoading = false;
            });
            resheduleAppointmentModel =
                resheduleAppointmentModelFromJson(response);
            if (resheduleAppointmentModel!.status == 2000) {
              try {
                Navigator.pop(context);
              } catch (e) {
                log('undo error', error: e);
              }
              Fluttertoast.showToast(
                  msg: "Undo successful",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
        ),
      ),
    );
  }

  void _launchURL() async {
    String url = widget.appointmentListModel!.appointmentDetails![widget.index]
        .appointmentAttDoc;
    _url = url.replaceAll(r'\', '\\');
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
