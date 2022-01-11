import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_widgets.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class VideoCallDetails extends StatefulWidget {
  DashboardProvider dashboardProvider;
  late var videoAppointment = dashboardProvider.videoAppointmentList;

  VideoCallDetails(
      {Key? key,
      required this.dashboardProvider,
      required this.videoAppointment})
      : super(key: key);

  @override
  State<VideoCallDetails> createState() => _VideoCallDetailsState();
}

class _VideoCallDetailsState extends State<VideoCallDetails> {
  final TextEditingController _problemDesc = TextEditingController();
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
              Text(widget.videoAppointment.first.appointmentStatus,
                  style: TextStyle(
                      color: widget.videoAppointment.first.appointmentStatus ==
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
                child: SvgPicture.asset(
                  SVGAsset.reminder,
                  color: Colors.black,
                )),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Container(
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
                    SizedBox(height: 12),
                    Container(
                      width: 52,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(MarginSize.middle),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(PNGAsset.clinicLogo),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12),
                          Container(
                            margin: EdgeInsets.only(right: MarginSize.middle),
                            child: Text(
                                widget.videoAppointment.first.serviceName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: FontSize.defaultFont)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: MarginSize.small),
                            child: Text(
                              widget.videoAppointment.first.appointmentType
                                  .toLowerCase()
                                  .toTitleCase,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: widget.videoAppointment.first.centerName
                                  .toLowerCase()
                                  .toTitleCase,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal),
                            ),
                          ),
                          SizedBox(height: 12)
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
                        height: 48,
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
                              child: Text(
                                  widget.videoAppointment.first.serviceName,
                                  style: TextStyle(
                                      fontFamily: FontName.frutinger,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize.large)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        margin: EdgeInsets.only(left: 12, top: 12),
                        child: Text("City",
                            style: TextStyle(
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.normal)),
                      ),
                      Container(
                        height: 48,
                        margin: EdgeInsets.only(top: 4, left: 12, right: 12),
                        decoration: BoxDecoration(
                            color: AppColors.greyBackground,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                child: SvgPicture.asset(
                                    "assets/images/health_clinic.svg")),
                            Text(widget.videoAppointment.first.cityName,
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 14),
                                            child: SvgPicture.asset(
                                                "assets/images/invitation.svg",
                                                color: AppColors.calanderColor),
                                          ),
                                          Container(
                                            height: 45,
                                            padding: EdgeInsets.only(top: 15),
                                            child: Text(
                                              widget.videoAppointment.first
                                                  .appointmentDate
                                                  .toString()
                                                  .substring(0, 10),
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 14),
                                            child: SvgPicture.asset(
                                                "assets/images/clock.svg",
                                                color: AppColors.calanderColor),
                                          ),
                                          Container(
                                            height: 45,
                                            padding: EdgeInsets.only(top: 15),
                                            child: Text(
                                              widget.videoAppointment.first
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: MarginSize.small),
                      child: Text("Show Directions",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.large,
                              color: Colors.white)),
                    ),
                    SvgPicture.asset("assets/images/map.svg",
                        color: Colors.white)
                  ],
                ),
              ),
              SizedBox(height: 42)
            ],
          ),
        ),
      )),
    );
  }
}
