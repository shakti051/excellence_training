import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:vlcc/components/add_clinic_logo.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class ReminderViewDetails extends StatefulWidget {
  List<VlccReminderModel>? data;
  int index;
  ReminderViewDetails({Key? key, this.data, this.index = 0}) : super(key: key);

  @override
  _ReminderViewDetailsState createState() => _ReminderViewDetailsState();
}

class _ReminderViewDetailsState extends State<ReminderViewDetails> {
  String timeAgo({required int milliseconds}) {
    return timeago.format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
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
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(SVGAsset.backButton),
              ),
            ),
          ),
          title: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text("Reminder Details",
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.black87,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.extraLarge)),
              ),
              // Text(widget.data![widget.index].reminderDescription,
              //     style: TextStyle(
              //         color: AppColors.aquaGreen,
              //         fontFamily: FontName.frutinger,
              //         fontWeight: FontWeight.w600,
              //         fontSize: FontSize.normal)),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSize.extraLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: MarginSize.small),
                      padding: const EdgeInsets.only(top: PaddingSize.normal),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(0, 64, 128, 0.04),
                                blurRadius: 10,
                                offset: Offset(0, 5))
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: MarginSize.defaulty,
                                  bottom: MarginSize.extraLarge,
                                  right: MarginSize.defaulty),
                              child: AddClinicLogo()),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(right: MarginSize.middle),
                                  child: Text(
                                      "Appointment ID:  ${widget.data![widget.index].id.toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.defaultFont)),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: MarginSize.small),
                                  child: Text(
                                    widget.data![widget.index]
                                        .reminderDescription,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSize.normal),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(right: MarginSize.small),
                                  child: RichText(
                                    text: TextSpan(
                                      text: widget
                                          .data![widget.index].addressLine2,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.normal),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15)
                              ],
                            ),
                          )
                        ],
                      )), //Todo later
                  SizedBox(height: 32),
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      shadowColor: AppColors.whiteShodow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 12, top: 12, bottom: 4),
                            child: Text("Appointment Type",
                                style: TextStyle(
                                    fontFamily: FontName.frutinger,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.normal)),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: MarginSize.middle),
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                color: AppColors.greyBackground,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 14),
                                    child: SvgPicture.asset(
                                        "assets/images/category.svg")),
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: MarginSize.middle),
                                    child: Text(
                                        widget.data![widget.index]
                                                    .appointmentType ==
                                                0
                                            ? "General Appointment"
                                            : "Video Consultation",
                                        style: TextStyle(
                                            fontFamily: FontName.frutinger,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize.large)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            margin:
                                EdgeInsets.only(left: 12, top: 12, bottom: 4),
                            child: Text("Center Address",
                                style: TextStyle(
                                    fontFamily: FontName.frutinger,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.normal)),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: MarginSize.middle),
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                color: AppColors.greyBackground,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 14),
                                    child: SvgPicture.asset(
                                        "assets/images/category.svg")),
                                Flexible(
                                  child: Text(
                                      widget.data![widget.index].addressLine2,
                                      style: TextStyle(
                                          fontFamily: FontName.frutinger,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.large)),
                                ),
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
                                        child: Text("Appointment Sheduled",
                                            style: TextStyle(
                                                fontFamily: FontName.frutinger,
                                                fontWeight: FontWeight.w600,
                                                fontSize: FontSize.normal)),
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
                                                color: AppColors.backBorder),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 14),
                                                child: SvgPicture.asset(
                                                    "assets/images/invitation.svg",
                                                    color: AppColors
                                                        .calanderColor),
                                              ),
                                              Container(
                                                height: 45,
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: Text(
                                                  timeAgo(
                                                    milliseconds: widget
                                                        .data![widget.index]
                                                        .insertTime,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontFamily:
                                                          FontName.frutinger,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          FontSize.normal),
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
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
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
                                        child: Text("Appointment Start Time",
                                            style: TextStyle(
                                                fontFamily: FontName.frutinger,
                                                fontWeight: FontWeight.w600,
                                                fontSize: FontSize.normal)),
                                      ),
                                      SizedBox(height: 4),
                                      InkWell(
                                        onTap: () {
                                          //  _selectTime(context);
                                        },
                                        child: Container(
                                          height: 46,
                                          margin: EdgeInsets.only(
                                              left: MarginSize.middle,
                                              right: MarginSize.middle),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.backBorder),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 14),
                                                child: SvgPicture.asset(
                                                    "assets/images/clock.svg",
                                                    color: AppColors
                                                        .calanderColor),
                                              ),
                                              Container(
                                                height: 45,
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: Text(
                                                  DateFormat('hh:mm a').format(
                                                    DateTime.fromMillisecondsSinceEpoch(
                                                            widget
                                                                    .data![widget
                                                                        .index]
                                                                    .appointmentDateSecond *
                                                                1000)
                                                        .subtract(
                                                      Duration(
                                                          seconds: widget
                                                              .data![
                                                                  widget.index]
                                                              .reminderTriggerTime),
                                                    ),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontFamily:
                                                          FontName.frutinger,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          FontSize.normal),
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
                        ],
                      )),
                  SizedBox(height: 24),
                  GradientButton(
                      child: Text("Continue",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.large,
                              color: Colors.white)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
