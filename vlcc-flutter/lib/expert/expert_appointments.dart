import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/components/add_clinic_logo.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/expert/expert_view_details.dart';
import 'package:vlcc/models/appointment_expert_model.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/providers/reminder_provider.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/appointments/expert_appointment_history.dart';
import 'package:vlcc/screens/appointments/reminders.dart';
import 'package:vlcc/widgets/appointment_widgets/add_reminder.dart';
import 'package:vlcc/widgets/appointment_widgets/view_reminder.dart';
import 'package:vlcc/widgets/custom_shimmers.dart';
import 'package:vlcc/widgets/nodata.dart';

class ExpertAppointmentScreen extends StatefulWidget {
  final int appointmentId;
  final bool isFromNotification;

  const ExpertAppointmentScreen(
      {Key? key, this.appointmentId = 0, this.isFromNotification = false})
      : super(key: key);

  @override
  _ExpertAppointmentScreenState createState() =>
      _ExpertAppointmentScreenState();
}

class _ExpertAppointmentScreenState extends State<ExpertAppointmentScreen> {
  final Services _services = Services();

  AppointmentExpertModel? _appointmentExpertModel;
  int generalAppointment = 0;
  int videoAppointment = 0;
  bool _apiHit = false;
  final DatabaseHelper databaseHelper = DatabaseHelper();
  VlccReminderModel vlccReminderModel = VlccReminderModel();
  late DatabaseHelper databaseProvider;
  late Future<List<VlccReminderModel>> _remindersList;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  //String dateString = Jiffy(dateTime).yMMMEd;
  Future<void>? expertAppointApi() {
    var body = {
      'client_mobile': VlccShared().mobileNum,
      'auth_token': VlccShared().authToken,
      'employee_code': VlccShared().employeCode,
      'device_id': Provider.of<VlccShared>(context, listen: false).deviceId,
    };
    _services
        .callApi(body,
            '/api/api_client_appointment_expert_list.php?request=client_appointmentexpert_list',
            apiName: 'Expert Appointment list')
        .then((value) {
      _appointmentExpertModel = appointmentExpertModelFromJson(value);

      for (int i = 0;
          i < _appointmentExpertModel!.appointmentexpertDetails!.length;
          i++) {
        if (_appointmentExpertModel!
                .appointmentexpertDetails![i].appointmentType!
                .toLowerCase() ==
            'general') {
          generalAppointment++;
        } else if (_appointmentExpertModel!
                .appointmentexpertDetails![i].appointmentType!
                .toLowerCase() ==
            'video consultations') {
          videoAppointment++;
        }
      }
      if (_appointmentExpertModel!.status == 2000) {
        setState(() {
          _apiHit = true;
        });
      }
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
  void initState() {
    expertAppointApi();
    // _init();
    super.initState();
  }

  Future<void> _init() async {
    return expertAppointApi()!.then((value) {
      if (widget.isFromNotification) {
        databaseHelper
            .getRemindersQuery(appointmentId: widget.appointmentId)
            .then((value) {
          viewReminderDialog(vlccReminderModel: value);
        });
      }
    });
  }

  Future<List<VlccReminderModel>> _getReminders() async {
    _remindersList = databaseProvider.getReminders();
    return _remindersList;
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

  bool isBeforeToday({required DateTime temp}) {
    var result = temp.isBefore(DateTime.now());
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // viewReminderDialog() {
    //   return showDialog(
    //       context: context,
    //       builder: (BuildContext c) {
    //         return ViewReminder();
    //       });
    // }
    databaseProvider = context.watch<DatabaseHelper>();
    _remindersList = databaseProvider.getReminders();
    final remindProvider = context.watch<ReminderProvider>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExpertAppointmentHistory()),
                  );
                },
                child: Container(
                    // margin:
                    //     const EdgeInsets.symmetric(horizontal: MarginSize.small),
                    child: SvgPicture.asset(SVGAsset.remind, height: 21)),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Reminders()),
                  );
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: MarginSize.small),
                    child: SvgPicture.asset(SVGAsset.reminder,
                        height: 21, color: AppColors.calanderColor)),
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: AppBar(
                  backgroundColor: AppColors.backgroundColor,
                  elevation: 0,
                  bottom: TabBar(
                    isScrollable: true,
                    labelColor: Colors.black87,
                    indicatorColor: Colors.black87,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelStyle: TextStyle(
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.heading),
                    labelStyle: TextStyle(
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.heading),
                    tabs: const [
                      Tab(
                        text: "Appointments",
                      ),
                      Tab(
                        text: "Video Consultation",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: TabBarView(children: [
                  _apiHit
                      ? generalAppointment == 0
                          ? NoDataScreen(
                              noDataSelect: NoDataSelectType.appointment,
                            )
                          : ListView.builder(
                              itemCount: _appointmentExpertModel!
                                  .appointmentexpertDetails!.length,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return (_appointmentExpertModel!
                                                .appointmentexpertDetails![
                                                    index]
                                                .appointmentType!
                                                .toLowerCase() ==
                                            'general' &&
                                        DateTime.parse(_appointmentExpertModel!
                                                .appointmentexpertDetails![
                                                    index]
                                                .appointmentDate!)
                                            .isAfter(DateTime.now()))
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            bottom: MarginSize.normal),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 64, 128, 0.04),
                                                blurRadius: 10,
                                                offset: Offset(0,
                                                    5), // changes position of shadow
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AddClinicLogo(),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          _appointmentExpertModel!
                                                              .appointmentexpertDetails![
                                                                  index]
                                                              .clientname!,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: FontSize
                                                                  .large),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _appointmentExpertModel!
                                                                .appointmentexpertDetails![
                                                                    index]
                                                                .appointmentStatus!,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .aquaGreen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    FontSize
                                                                        .small),
                                                          ),
                                                          Text(
                                                            Jiffy(DateTime.parse(
                                                                    _appointmentExpertModel!
                                                                        .appointmentexpertDetails![
                                                                            index]
                                                                        .appointmentDate!))
                                                                .yMMMEd,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .orange,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    FontSize
                                                                        .small),
                                                          ),
                                                          Text(
                                                            _appointmentExpertModel!
                                                                .appointmentexpertDetails![
                                                                    index]
                                                                .appointmentStartTime!,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .orange,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    FontSize
                                                                        .small),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical:
                                                            MarginSize.small),
                                                    child: Text(
                                                      _appointmentExpertModel!
                                                          .appointmentexpertDetails![
                                                              index]
                                                          .bookingId!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              FontSize.normal),
                                                    ),
                                                  ),
                                                  Text(
                                                    _appointmentExpertModel!
                                                        .appointmentexpertDetails![
                                                            index]
                                                        .appointmentServiceexpertDtl![
                                                            0]
                                                        .serviceName!,
                                                    style: TextStyle(
                                                        color: AppColors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize:
                                                            FontSize.normal),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          bool isVideoCall =
                                                              false;
                                                          if (_appointmentExpertModel
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
                                                                builder:
                                                                    (context) =>
                                                                        ExpertViewDetails(
                                                                          appointmentExpertModel:
                                                                              _appointmentExpertModel,
                                                                          index:
                                                                              index,
                                                                          isVideoCall:
                                                                              isVideoCall,
                                                                        )),
                                                          );
                                                        },
                                                        child: Container(
                                                            margin: const EdgeInsets
                                                                    .symmetric(
                                                                vertical:
                                                                    MarginSize
                                                                        .small),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .orangeProfile,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    PaddingSize
                                                                        .extraLarge,
                                                                vertical: 8),
                                                            child: Text(
                                                              "View Details",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .orange,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      FontSize
                                                                          .large),
                                                            )),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (!remindProvider
                                                              .reminderAddedAt
                                                              .contains(_appointmentExpertModel!
                                                                  .appointmentexpertDetails![
                                                                      index]
                                                                  .appointmentId!)) {
                                                            addReminderDialog(
                                                              appointmentType:
                                                                  0,
                                                              appointmentSeconds:
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .appointmentStartDateTime!,
                                                              index: index,
                                                              title: _appointmentExpertModel!
                                                                  .appointmentexpertDetails![
                                                                      index]
                                                                  .appointmentServiceexpertDtl![
                                                                      0]
                                                                  .serviceName!,
                                                              addressLine1:
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .centerCode!,
                                                              addressLine2:
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .centerName!,
                                                              appointmentDate: DateTime.parse(
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .appointmentDate!),
                                                              appointmentId:
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .appointmentId!,
                                                            );
                                                          } else {
                                                            viewReminderDialog(
                                                                vlccReminderModel:
                                                                    VlccReminderModel(
                                                              addressLine1:
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .centerCode!,
                                                              addressLine2:
                                                                  _appointmentExpertModel!
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
                                                                  .contains(_appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .appointmentId!)
                                                              ? AppColors.orange
                                                              : Colors.grey,
                                                        ),
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
                              })
                      : CustomShimmer(shimmers: ShimmerType.assessment),
                  _apiHit
                      ? videoAppointment == 0
                          ? NoDataScreen(
                              noDataSelect: NoDataSelectType.appointment,
                            )
                          : ListView.builder(
                              itemCount: _appointmentExpertModel!
                                  .appointmentexpertDetails!.length,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return (_appointmentExpertModel!
                                                .appointmentexpertDetails![
                                                    index]
                                                .appointmentType!
                                                .toLowerCase() ==
                                            'video consultations' &&
                                        DateTime.parse(_appointmentExpertModel!
                                                .appointmentexpertDetails![
                                                    index]
                                                .appointmentDate!)
                                            .isAfter(DateTime.now()))
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            bottom: MarginSize.normal),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 64, 128, 0.04),
                                                blurRadius: 10,
                                                offset: Offset(0,
                                                    5), // changes position of shadow
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          _appointmentExpertModel!
                                                              .appointmentexpertDetails![
                                                                  index]
                                                              .clientname!,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: FontSize
                                                                  .large),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _appointmentExpertModel!
                                                                .appointmentexpertDetails![
                                                                    index]
                                                                .appointmentStatus!,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .aquaGreen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    FontSize
                                                                        .small),
                                                          ),
                                                          Text(
                                                            Jiffy(DateTime.parse(
                                                                    _appointmentExpertModel!
                                                                        .appointmentexpertDetails![
                                                                            index]
                                                                        .appointmentDate!))
                                                                .yMMMEd,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .orange,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    FontSize
                                                                        .small),
                                                          ),
                                                          Text(
                                                            _appointmentExpertModel!
                                                                .appointmentexpertDetails![
                                                                    index]
                                                                .appointmentStartTime!,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .orange,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    FontSize
                                                                        .small),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical:
                                                            MarginSize.small),
                                                    child: Text(
                                                      _appointmentExpertModel!
                                                          .appointmentexpertDetails![
                                                              index]
                                                          .bookingId!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              FontSize.normal),
                                                    ),
                                                  ),
                                                  Text(
                                                    _appointmentExpertModel!
                                                        .appointmentexpertDetails![
                                                            index]
                                                        .appointmentServiceexpertDtl![
                                                            0]
                                                        .serviceName!,
                                                    style: TextStyle(
                                                        color: AppColors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize:
                                                            FontSize.normal),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          bool isVideoCall =
                                                              false;
                                                          if (_appointmentExpertModel
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
                                                                builder:
                                                                    (context) =>
                                                                        ExpertViewDetails(
                                                                          appointmentExpertModel:
                                                                              _appointmentExpertModel,
                                                                          index:
                                                                              index,
                                                                          isVideoCall:
                                                                              isVideoCall,
                                                                        )),
                                                          );
                                                        },
                                                        child: Container(
                                                            margin: const EdgeInsets
                                                                    .symmetric(
                                                                vertical:
                                                                    MarginSize
                                                                        .small),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .orangeProfile,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    PaddingSize
                                                                        .extraLarge,
                                                                vertical: 8),
                                                            child: Text(
                                                              "View Details",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .orange,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      FontSize
                                                                          .large),
                                                            )),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (!remindProvider
                                                              .reminderAddedAt
                                                              .contains(_appointmentExpertModel!
                                                                  .appointmentexpertDetails![
                                                                      index]
                                                                  .appointmentId!)) {
                                                            addReminderDialog(
                                                              appointmentType:
                                                                  1,
                                                              appointmentSeconds:
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .appointmentStartDateTime!,
                                                              index: index,
                                                              title: _appointmentExpertModel!
                                                                  .appointmentexpertDetails![
                                                                      index]
                                                                  .appointmentServiceexpertDtl![
                                                                      0]
                                                                  .serviceName!,
                                                              addressLine1:
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .centerCode!,
                                                              addressLine2:
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .centerName!,
                                                              appointmentDate: DateTime.parse(
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .appointmentDate!),
                                                              // appointmentDate:
                                                              //     DateTime
                                                              //         .now(),
                                                              appointmentId:
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .appointmentId!,
                                                            );
                                                          } else {
                                                            viewReminderDialog(
                                                                vlccReminderModel:
                                                                    VlccReminderModel(
                                                              addressLine1:
                                                                  _appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .centerCode!,
                                                              addressLine2:
                                                                  _appointmentExpertModel!
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
                                                                  .contains(_appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .appointmentId!)
                                                              ? AppColors.orange
                                                              : Colors.grey,
                                                        ),
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
                              })
                      : CustomShimmer(shimmers: ShimmerType.assessment),
                ]),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
