import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/models/reshedule_appointment_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import '../gradient_button.dart';

class ResheduleUpcomingAppoint extends StatefulWidget {
  final int index;
  final DashboardProvider dashboardProvider;
  late var generalAppointment = dashboardProvider.generalAppointmentList;
  final AppointmentListModel? appointmentListModel;

  ResheduleUpcomingAppoint(
      {Key? key,
      this.index = 0,
      this.appointmentListModel,
      required this.generalAppointment,
      required this.dashboardProvider})
      : super(key: key);

  @override
  _ResheduleUpcomingAppointState createState() =>
      _ResheduleUpcomingAppointState();
}

class _ResheduleUpcomingAppointState extends State<ResheduleUpcomingAppoint> {
  DateTime _currentDate = DateTime.now();
  TimeOfDay? time;
  TimeOfDay? picked;
  final Services _services = Services();
  ResheduleAppointmentModel? resheduleAppointmentModel;

  bool _navigate = false;
  bool uploading = false;

  void resheduleAppointment() {
    var body = {
      'client_mobile': VlccShared().mobileNum,
      'auth_token': VlccShared().authToken,
      'device_id': VlccShared().deviceId,
      'appointment_date': widget.appointmentListModel!
          .appointmentDetails![widget.index].appointmentDate
          .toString(),
      'appointment_start_time': time!.format(context),
      'appointment_end_time': '13:00:00',
      'AppointmentId': widget.appointmentListModel!
          .appointmentDetails![widget.index].appointmentId,
      'cancellation_comment': "test",
    };
    _services
        .callApi(body,
            '/api/api_appointment_reschedule_rbs.php?request=appointment_reschedule',
            apiName: 'Reshedule Appointment')
        .then((value) {
      var testVal = value;
      resheduleAppointmentModel = resheduleAppointmentModelFromJson(testVal);
      if (resheduleAppointmentModel!.status == 2000) {
        setState(() {
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              action: SnackBarAction(
                textColor: AppColors.orange,
                label: 'Undo',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => PendingAppointment(
          //           appointmentListModel: widget.appointmentListModel,
          //           currentDate: _currentDate,
          //           time: time,
          //           index: widget.index)),
          // );
        });
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          _navigate = false;
        });
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

  @override
  void initState() {
    time = TimeOfDay.now();
    super.initState();
  }

  Future<void> _selectTime(BuildContext context) async {
    picked = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 09, minute: 00));
    if (picked != null) {
      setState(() {
        time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                              _selectTime(context);
                            },
                            child: Container(
                              height: 46,
                              //  margin: EdgeInsets.only(right: MarginSize.middle),
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
                                      time!.format(context),
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
}
