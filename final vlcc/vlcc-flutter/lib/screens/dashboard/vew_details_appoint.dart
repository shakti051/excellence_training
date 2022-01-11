import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/widgets/dashboard_widgets/cancelupcomingdialouge.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import 'package:vlcc/widgets/dashboard_widgets/resheduleupcoming_appoint.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class AppointmentDetails extends StatefulWidget {
  final DashboardProvider dashboardProvider;
  late var generalAppointment = dashboardProvider.generalAppointmentList;
  AppointmentDetails(
      {Key? key,
      required this.dashboardProvider,
      required this.generalAppointment})
      : super(key: key);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  Services? services;

  final TextEditingController _problemDesc = TextEditingController();
  final Services _services = Services();
  DateTime _currentDate = DateTime.now();
  TimeOfDay? time;
  TimeOfDay? picked;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  Future<void> _selectedDate(BuildContext context) async {
    var today = DateTime.now();
    final DateTime? _selDate = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(today.year - 1),
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

  Future<void> selectTime(BuildContext context) async {
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
    showCancelDialogAppoint() {
      return showDialog(
          context: context,
          builder: (BuildContext c) {
            return CancelUpcomingDialouge(
              index: 0,
              generalAppointment: widget.generalAppointment,
              dashboardProvider: widget.dashboardProvider,
            );
          });
    }

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
                child: Text("Appointment Details",
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.black87,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.extraLarge)),
              ),
              Text(widget.generalAppointment.first.appointmentStatus,
                  style: TextStyle(
                      color:
                          widget.generalAppointment.first.appointmentStatus ==
                                  'Approved'
                              ? AppColors.aquaGreen
                              : AppColors.orange,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
            ],
          ),
          actions: [
            // FutureBuilder<List<VlccReminderModel>>(
            // future: databaseHelper.getReminders(),
            // builder: (context, snapshot) {
            //   List<VlccReminderModel> snap = [];
            //   if (snapshot.hasData) {
            //     snap = snapshot.data!
            //         .where(
            //           (element) =>
            //               element.appointmentId ==
            //               int.parse(generalAppointment.first.appointmentId),
            //         )
            //         .toList();
            //   }})
            //  InkWell(
            //                     onTap: () {
            //                       if (snap.isEmpty) {
            //                         addReminderDialog(
            //                             index: 0,
            //                             addressLine1: generalAppointment
            //                                 .first.addressLine1,
            //                             addressLine2: generalAppointment
            //                                 .first.addressLine2,
            //                             appointmentId: generalAppointment
            //                                 .first.appointmentId,
            //                             appointmentDate: generalAppointment
            //                                     .first.appointmentDate ??
            //                                 DateTime.now(),
            //                             title: generalAppointment
            //                                 .first.serviceName,
            //                             appointmentSeconds: convertToTime(
            //                               temp: generalAppointment
            //                                       .first.appointmentDate ??
            //                                   DateTime.now(),
            //                             ));
            //                       } else {
            //                         viewReminderDialog(
            //                           vlccReminderModel:
            //                               snapshot.data![findSnapshotIndex(
            //                             appointmentId: int.parse(
            //                                 generalAppointment
            //                                     .first.appointmentId),
            //                             listReminder: snapshot.data ?? [],
            //                           )],
            //                         );
            //                       }
            //                     },
            //                     child: SvgPicture.asset(
            //                       "assets/images/reminder.svg",
            //                       color: snap.isEmpty
            //                           ? AppColors.grey
            //                           : AppColors.orange,
            //                     ),
            //                   )
            //                 ,
            Container(
                margin: EdgeInsets.only(right: 24, top: 8),
                child: SvgPicture.asset(
                  SVGAsset.reminder,
                  color: Colors.black,
                )),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: MarginSize.small),
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
                          height: 56,
                          width: 56,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.all(MarginSize.middle),
                          child: Image.asset(PNGAsset.clinicLogo),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12),
                              Text(
                                widget.generalAppointment.first.serviceName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.defaultFont,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.generalAppointment.first.appointmentType,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal,
                                ),
                              ),
                              SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  text: widget
                                      .generalAppointment.first.centerName
                                      .toLowerCase()
                                      .toTitleCase,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.normal,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                            ],
                          ),
                        )
                      ],
                    )),
                SizedBox(height: 32),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    shadowColor: AppColors.whiteShodow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 12, top: 12, bottom: 4),
                          child: Text("Service",
                              style: TextStyle(
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal)),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: PaddingSize.small),
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              color: AppColors.greyBackground,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: SvgPicture.asset(
                                      "assets/images/category.svg")),
                              Flexible(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: MarginSize.small),
                                  child: Text(
                                      widget
                                          .generalAppointment.first.serviceName,
                                      style: TextStyle(
                                          fontFamily: FontName.frutinger,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.large)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          margin: EdgeInsets.only(left: 12, top: 12,bottom: 4),
                          child: Text("City",
                              style: TextStyle(
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal)),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: MarginSize.middle),
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              color: AppColors.greyBackground,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: SvgPicture.asset(
                                      "assets/images/health_clinic.svg")),
                              Text(widget.generalAppointment.first.cityName,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: MarginSize.middle),
                                      child: Text("Appointment date",
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
                                                  color:
                                                      AppColors.calanderColor),
                                            ),
                                            Container(
                                              height: 45,
                                              padding: EdgeInsets.only(top: 15),
                                              child: Text(
                                                _dateFormatter.format(widget
                                                        .generalAppointment
                                                        .first
                                                        .appointmentDate ??
                                                    DateTime.now()),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily:
                                                        FontName.frutinger,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: MarginSize.middle),
                                      child: Text("Appointment time",
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
                                                  color:
                                                      AppColors.calanderColor),
                                            ),
                                            Container(
                                              height: 45,
                                              padding: EdgeInsets.only(top: 15),
                                              child: Text(
                                                widget.generalAppointment.first
                                                    .appointmentTime,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily:
                                                        FontName.frutinger,
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
                      ],
                    )),
                SizedBox(height: 24),
                GradientButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SubscribedPackages()));
                    },
                    child: Row(
                      children: [
                        Spacer(),
                        Text("Show Directions",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.large,
                                color: Colors.white)),
                        SizedBox(width: 8),
                        SvgPicture.asset(SVGAsset.mapIcon, color: Colors.white),
                        Spacer(),
                      ],
                    )),
                SizedBox(height: 24),
                if (widget.generalAppointment.first.appointmentStatus
                        .toLowerCase() !=
                    'cancelled')
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) =>
                                    SingleChildScrollView(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: ResheduleUpcomingAppoint(
                                              index: 0,
                                              dashboardProvider:
                                                  widget.dashboardProvider,
                                              generalAppointment:
                                                  widget.generalAppointment,
                                            ))));
                          },
                          child: Text("Reshedule",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.large,
                                  color: AppColors.orange1)),
                        ),
                      ),
                      Container(height: 15, width: 2, color: Colors.grey),
                      Expanded(
                        child: GestureDetector(
                          onTap: showCancelDialogAppoint,
                          child: Text("Cancel",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.large,
                                  color: AppColors.pink)),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 42)
              ],
            ),
          ),
        ),
      )),
    );
  }
}
