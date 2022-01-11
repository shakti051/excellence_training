import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/models/cancel_appointment_model.dart';
import 'package:vlcc/providers/appointments_provider.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';

class CancelUpcomingDialouge extends StatefulWidget {
  final int index;
  final DashboardProvider dashboardProvider;
  late var generalAppointment = dashboardProvider.generalAppointmentList;
  final AppointmentListModel? appointmentListModel;

  CancelUpcomingDialouge({
    Key? key,
    this.index = 0,
    this.appointmentListModel,
    required this.generalAppointment,
    required this.dashboardProvider,
  }) : super(key: key);

  @override
  _CancelUpcomingDialougeState createState() => _CancelUpcomingDialougeState();
}

class _CancelUpcomingDialougeState extends State<CancelUpcomingDialouge> {
  final Services _services = Services();
  CancelAppointmentModel? cancelAppointmentModel;
  final DateTime _currentDate = DateTime.now();

  void cancelAppointment() {
    var body = {
      'client_mobile': VlccShared().mobileNum,
      'auth_token': VlccShared().authToken,
      'device_id': VlccShared().deviceId,
      'appointment_cancel_date': _currentDate.toIso8601String(),
      'AppointmentId': widget.generalAppointment.first.appointmentId,
      'cancellation_comment': "test",
    };
    _services
        .callApi(body,
            '/api/api_appointment_cancel_rbs.php?request=appointment_cancel',
            apiName: 'Cancel Appointment rbs')
        .then((value) {
      var testVal = value;

      cancelAppointmentModel = cancelAppointmentModelFromJson(testVal);
      if (cancelAppointmentModel!.status == 2000) {
        Fluttertoast.showToast(
            msg: "Appointment Cancelled",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _ = context.watch<AppointmentsProvider>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 350,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                      opacity: 0.0,
                      child: Icon(Icons.clear, color: Colors.grey)),
                  Text("Cancel Appointment",
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
              SizedBox(height: 30),
              SvgPicture.asset(SVGAsset.warning),
              SizedBox(height: 30),
              Text("Cancel the appointment? it can't be undone",
                  style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.large)),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 50,
                          padding: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text("Never mind",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.large))),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        cancelAppointment();
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 50,
                          // width: 143,
                          padding: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.pink),
                          child: Text("Yes, cancel",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.large))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
