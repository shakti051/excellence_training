import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/models/reshedule_appointment_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/util_functions.dart';
import 'package:vlcc/screens/appointments/pending_appointment.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import 'package:vlcc/widgets/gradient_button.dart';
import 'package:vlcc/widgets/heading_title_text.dart';

class ResheduleAppointment extends StatefulWidget {
  final int index;
  final AppointmentListModel? appointmentListModel;

  const ResheduleAppointment(
      {Key? key, this.index = 0, this.appointmentListModel})
      : super(key: key);

  @override
  State<ResheduleAppointment> createState() => _ResheduleAppointmentState();
}

class _ResheduleAppointmentState extends State<ResheduleAppointment> {
  DateTime _currentDate = DateTime.now();
  TimeOfDay? time;
  TimeOfDay? picked;
  final Services _services = Services();
  final VlccShared _vlccShared = VlccShared();
  ResheduleAppointmentModel? resheduleAppointmentModel;
  FixedExtentScrollController _periodScrollController =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _hourScrollController =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _minuteScrollController =
      FixedExtentScrollController(initialItem: 0);
  String originalDate = '';
  String originalTime = '';

  bool uploading = false;

  @override
  void initState() {
    // preferredTime = DateFormat.jm().format(_currentDate).toString();
    originalDate = widget.appointmentListModel
            ?.appointmentDetails?[widget.index].appointmentDate
            .toString() ??
        '';
    originalTime = widget.appointmentListModel
            ?.appointmentDetails?[widget.index].appointmentTime ??
        '';
    time = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();
    return Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.only(top: 8, bottom: 20),
                      height: 2,
                      width: 70,
                      color: AppColors.backBorder)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reshedule Appointment",
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
              SizedBox(height: 20),
              Divider(height: 2, color: AppColors.backBorder),
              SizedBox(height: 20),
              SizedBox(
                height: 75,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Preferred date",
                              style: TextStyle(
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal)),
                          SizedBox(height: 4),
                          InkWell(
                            onTap: () {
                              _selectedDate(context);
                            },
                            child: Container(
                              height: 46,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.backBorder),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 14),
                                    child: SvgPicture.asset(
                                        "assets/images/invitation.svg",
                                        color: AppColors.calanderColor),
                                  ),
                                  Container(
                                    height: 45,
                                    padding: EdgeInsets.only(top: 15),
                                    child: Text(
                                      DateFormat("dd/MM/yyyy")
                                          .format(_currentDate)
                                          .toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: FontName.frutinger,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.normal),
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
              SizedBox(
                height: 75,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Preferred time",
                              style: TextStyle(
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal)),
                          SizedBox(height: 4),
                          InkWell(
                            onTap: () {
                              _selectTime(context,
                                  dashboardProvider: dashboardProvider);
                            },
                            child: Container(
                              height: 46,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.backBorder),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 14),
                                    child: SvgPicture.asset(
                                        "assets/images/clock.svg",
                                        color: AppColors.calanderColor),
                                  ),
                                  Container(
                                    height: 45,
                                    padding: EdgeInsets.only(top: 15),
                                    child: Text(
                                      preferredTime,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: FontName.frutinger,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.normal),
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
              RichText(
                text: TextSpan(
                  text: 'Note: Resheduling an ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.small),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Approved appointment',
                      style: TextStyle(
                          color: AppColors.aquaGreen,
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.small),
                    ),
                    TextSpan(
                      text: ' will change its status back to ',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.black87,
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.small),
                    ),
                    TextSpan(
                      text: 'Pending',
                      style: TextStyle(
                          color: AppColors.pink,
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.small),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26),
              GradientButton(
                onPressed: resheduleAppointment,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: MarginSize.small),
                      child: Text("Reshedule Appointment",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.large,
                              color: Colors.white)),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26)
            ]),
          ),
        ));
  }

  int _hourIndex = 0;
  int _minuteIndex = 0;
  int _periodIndex = 0;

  String finalHour = '08';
  String finalMinute = '00';
  String finalPeriod = 'AM';
  String preferredTime = '';
  String rescheduledTime = '';
  String startTime = '';

  Future<void> _selectTime(BuildContext context,
      {required DashboardProvider dashboardProvider}) async {
    _hourScrollController =
        FixedExtentScrollController(initialItem: _hourIndex);
    _minuteScrollController =
        FixedExtentScrollController(initialItem: _minuteIndex);

    _periodScrollController =
        FixedExtentScrollController(initialItem: _periodIndex);
    int initHour = 7;
    const List<String> period = ['AM', 'PM'];
    finalPeriod = period[_periodIndex];
    preferredTime = '$finalHour:$finalMinute $finalPeriod';
    var hours = List.generate(12, (index) {
      initHour = initHour + 1;
      return UtilityFunctions.hourConverter(initialTime: initHour);
    });
    picked = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          double itemExtent = 45.0;
          return SizedBox(
            height: 200,
            child: AlertDialog(
              title: HeadingTitleText(
                fontSize: FontSize.defaultFont,
                title: 'Preferred time',
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 300,
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: _hourScrollController,
                            useMagnifier: true,
                            looping: true,
                            itemExtent: itemExtent,
                            onSelectedItemChanged: (value) {
                              _hourIndex = value;

                              if (hours[value] >= 1 && hours[value] < 8 ||
                                  hours[value] == 12) {
                                _periodScrollController.animateToItem(1,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.ease);
                              } else {
                                _periodScrollController.animateToItem(0,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.ease);
                              }
                              finalHour = hours[value].toString();
                            },
                            children: List.generate(
                              hours.length,
                              (index) => Center(
                                child: Text(
                                  hours[index].toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: CupertinoPicker(
                          scrollController: _minuteScrollController,
                          useMagnifier: true,
                          itemExtent: itemExtent,
                          onSelectedItemChanged: (value) {
                            _minuteIndex = value;
                            finalMinute = value.toString().padLeft(2, '0');
                          },
                          children: List.generate(
                            60,
                            (index) => Center(
                                child: Text(index.toString().padLeft(2, '0'))),
                          ),
                        )),
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: dashboardProvider.isAmPm,
                            child: CupertinoPicker(
                              scrollController: _periodScrollController,
                              useMagnifier: true,
                              itemExtent: itemExtent,
                              onSelectedItemChanged: (value) {
                                _periodIndex = value;
                                finalPeriod = period[value];
                              },
                              children: List.generate(
                                period.length,
                                (index) => Center(
                                  child: Text(
                                    period[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          preferredTime =
                              '$finalHour:$finalMinute $finalPeriod';
                          int isAmPm =
                              finalPeriod.toLowerCase() == 'am' ? 0 : 12;
                          startTime =
                              "${int.parse(finalHour) + isAmPm}:$finalMinute:00";
                        });
                      },
                      child: Text('OK'))
                ],
              ),
            ),
          );
        }).then((value) {
      _periodScrollController.dispose();
      _minuteScrollController.dispose();
      _hourScrollController.dispose();
    });
  }

  void resheduleAppointment() {
    if (preferredTime.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please select time",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    var body = {
      'client_mobile': _vlccShared.mobileNum,
      'auth_token': _vlccShared.authToken,
      'device_id': _vlccShared.deviceId,
      'appointment_date': _currentDate.toString(),
      'appointment_start_time': startTime,
      'appointment_end_time': '20:00:00',
      'AppointmentId': widget.appointmentListModel!
          .appointmentDetails![widget.index].appointmentId,
      'cancellation_comment': "test",
    };
    _services
        .callApi(body,
            '/api/api_appointment_reschedule_rbs.php?request=appointment_reschedule',
            apiName: 'Reshedule Appointment')
        .then((value) {
      resheduleAppointmentModel = resheduleAppointmentModelFromJson(value);
      if (resheduleAppointmentModel!.status == 2000) {
        time = TimeOfDay(
            hour: int.parse(startTime.split(":")[0]),
            minute: int.parse(startTime.split(":")[1]));
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PendingAppointment(
              appointmentListModel: widget.appointmentListModel,
              currentDate: _currentDate,
              time: time,
              index: widget.index,
              originalDate: originalDate,
              originalTime: originalTime,
              vlccShared: _vlccShared,
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
      }
    });
  }

  Future<void> _selectedDate(BuildContext context) async {
    var today = DateTime.now();
    final DateTime? _selDate = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: today,
      lastDate: DateTime(today.year + 1),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.orange,
              onPrimary: Colors.white,
              surface: Colors.orange,
            ),
            dialogBackgroundColor: AppColors.backgroundColor,
          ),
          child: child ?? SizedBox(),
        );
      },
    );

    if (_selDate != null) {
      setState(() {
        _currentDate = _selDate;
      });
    }
  }
}
