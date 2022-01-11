import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/screens/appointments/appointment_card.dart';
import 'package:vlcc/screens/appointments/customer_appointment_history.dart';
import 'package:vlcc/screens/appointments/reminders.dart';
import 'package:vlcc/screens/search/search_page.dart';
import 'package:vlcc/widgets/appointment_widgets/appointment_widgets.dart';
import 'package:vlcc/widgets/custom_shimmers.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import 'package:vlcc/widgets/nodata.dart';

import '../../main.dart';

class Appointments extends StatefulWidget {
  final int appointmentId;
  final bool isFromNotification;
  const Appointments(
      {Key? key, this.appointmentId = 0, this.isFromNotification = false})
      : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> with RouteAware {
  final Services _services = Services();
  final VlccShared vlccShared = VlccShared();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool _apiHit = false;
  final DatabaseHelper databaseHelper = DatabaseHelper();
  VlccReminderModel vlccReminderModel = VlccReminderModel();
  final DashboardProvider _dashboardProvider = DashboardProvider();
  AppointmentListModel _appointmentListModel = AppointmentListModel();
  AppointmentListModel appointmentListModel = AppointmentListModel();
  late DatabaseHelper databaseProvider;
  late Future<List<VlccReminderModel>> _remindersList;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    log('callback viewwillappear');
    _init();
    log('callback viewwillappear init');
  }

  Future<void> _init() async {
    return appointListApi().then((value) {
      if (mounted) {
        log('callback viewwillappear setState');
        setState(() {});
      }
      if (widget.isFromNotification) {
        databaseHelper
            .getRemindersQuery(appointmentId: widget.appointmentId)
            .then((value) {
          _getReminders();
          viewReminderDialog(vlccReminderModel: value);
        });
      }
    });
  }

  Future<void> appointListApi() async {
    if (mounted) {
      setState(() {
        _apiHit = false;
      });
    }
    var body = {
      'client_mobile': vlccShared.mobileNum,
      'auth_token': vlccShared.authToken,
      'device_id': vlccShared.deviceId,
    };
    _services
        .callApi(body,
            '/api/api_client_rbs_appointment_list.php?request=client_rbs_appointment_list',
            apiName: 'appointment list')
        .then((value) async {
      var testVal = value;

      _appointmentListModel = appointmentListModelFromJson(testVal);

      for (int i = 0;
          i < _appointmentListModel.appointmentDetails!.length;
          i++) {
        _appointmentListModel.appointmentDetails!.sort((a, b) {
          return b.appointmentDate!.compareTo(a.appointmentDate!);
        });
      }

      var generalAppointmentList =
          await _dashboardProvider.getGeneralAppointmentList();
      for (var generalAppointment
          in generalAppointmentList.appointmentDetails!) {
        _appointmentListModel.appointmentDetails!.add(AppointmentDetail(
          appointmentId: generalAppointment.appointmentId,
          centerName: generalAppointment.centerName,
          centerCode: generalAppointment.centerCode,
          bookingNumber: generalAppointment.bookingNumber,
          clientId: generalAppointment.clientId,
          appointmentRemark: generalAppointment.appointmentRemark,
          areaName: generalAppointment.areaName,
          cityName: generalAppointment.cityName,
          centerLatitude: generalAppointment.centerLatitude,
          centerLongitude: generalAppointment.centerLongitude,
          addressLine1: generalAppointment.addressLine1,
          addressLine2: generalAppointment.addressLine2,
          addressLine3: generalAppointment.addressLine3,
          appointmentDate: generalAppointment.appointmentDate,
          appointmentTime: generalAppointment.appointmentStartTime,
          appointmentStartDateTime: generalAppointment.appointmentStartDateTime,
          appointmentStatus: generalAppointment.appointmentStatus,
          appointmentAttDoc: generalAppointment.appointmentAttDoc,
          serviceName:
              generalAppointment.appointmentServiceDtl!.first.serviceName,
          stateName: generalAppointment.stateName,
          centerMap: generalAppointment.centerMap,
          appointmentType: generalAppointment.appointmentType,
          appointmentRoom: generalAppointment.appointmentRoom,
          appointmentToken: generalAppointment.appointmentToken,
        ));
      }
      _appointmentListModel.appointmentDetails!.removeWhere((element) {
        bool isBeforeNow = DateTime.fromMillisecondsSinceEpoch(
                element.appointmentStartDateTime * 1000)
            .isBefore(
          DateTime.now(),
        );
        bool isCancelled =
            element.appointmentStatus.toLowerCase() == 'cancelled';

        return isBeforeNow || isCancelled;
      });
      if (mounted) {
        Future.delayed(const Duration(seconds: 0), () {
          log('callback api call setState');
          setState(() {
            _apiHit = true;
          });
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

  Future<List<VlccReminderModel>> _getReminders() async {
    _remindersList = databaseProvider.getReminders();
    return _remindersList;
  }

  @override
  Widget build(BuildContext context) {
    databaseProvider = context.watch<DatabaseHelper>();
    _remindersList = databaseProvider.getReminders();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(8),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontSize: FontSize.defaultFont)),
          ),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: SearchPage(
                      pageTitle: 'Book Appointment',
                      isBook: true,
                      isBack: true,
                      isComingFromBookNow: true,
                    ),
                    type: PageTransitionType.rightToLeftWithFade));
          },
          child: Text('Book Now'),
        ),
        backgroundColor: AppColors.backgroundColor,
        appBar: _appBar(),
        body: _apiHit
            ? RefreshIndicator(
                onRefresh: _init,
                key: _refreshIndicatorKey,
                child: FutureBuilder<List<VlccReminderModel>>(
                    future: _remindersList,
                    builder: (context, snapshot) {
                      var general = _appointmentListModel.appointmentDetails!
                          .where((appointment) =>
                              appointment.appointmentType.toLowerCase() ==
                              'general');
                      var video = _appointmentListModel.appointmentDetails!
                          .where((appointment) =>
                              appointment.appointmentType.toLowerCase() !=
                              'video cosultations');
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PaddingSize.extraLarge),
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
                                  _appointmentListModel
                                              .appointmentDetails!.isEmpty ||
                                          general.isEmpty
                                      ? NoDataScreen(
                                          noDataSelect:
                                              NoDataSelectType.appointment,
                                        )
                                      : generalBooking(snapshot),
                                  _appointmentListModel
                                              .appointmentDetails!.isEmpty ||
                                          video.isEmpty
                                      ? NoDataScreen(
                                          noDataSelect:
                                              NoDataSelectType.appointment,
                                        )
                                      : videoAppointment(snapshot)
                                ]),
                              ),
                            ],
                          ));
                    }),
              )
            : CustomShimmer(
                shimmers: ShimmerType.assessment,
              ),
      ),
    );
  }

  ListView videoAppointment(AsyncSnapshot<List<VlccReminderModel>> snapshot) {
    List<VlccReminderModel> vlccReminderModelList = [];
    return ListView.builder(
        itemCount: _appointmentListModel.appointmentDetails!.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          bool isReminderActive = false;
          if (snapshot.hasData) {
            vlccReminderModelList = snapshot.data ?? [];
            for (var element in vlccReminderModelList) {
              if (element.reminderTitle ==
                      _appointmentListModel
                          .appointmentDetails![index].serviceName &&
                  element.appointmentId ==
                      int.parse(_appointmentListModel
                          .appointmentDetails![index].appointmentId)) {
                isReminderActive = true;
              }
            }
          }
          DateTime dateTime = _appointmentListModel
                  .appointmentDetails![index].appointmentDate ??
              DateTime.now();

          String timeString = DateFormat.jm().format(DateFormat("hh:mm:ss")
              .parse(_appointmentListModel
                  .appointmentDetails![index].appointmentTime));

          String dateString = Jiffy(dateTime).yMMMEd;
          // String timeString = Jiffy(dateTime).jm;
          if (_appointmentListModel.appointmentDetails![index].appointmentType
                  .toLowerCase() !=
              'general') {
            return AppointmentCard(
              appointmentListModel: _appointmentListModel,
              index: index,
              timeString: timeString,
              dateString: dateString,
              isReminderActive: isReminderActive,
              vlccReminderModelList: vlccReminderModelList,
              callback: _init,
            );
          } else {
            return SizedBox();
          }
        });
  }

  ListView generalBooking(AsyncSnapshot<List<VlccReminderModel>> snapshot) {
    List<VlccReminderModel> vlccReminderModelList = [];
    return ListView.builder(
        itemCount: _appointmentListModel.appointmentDetails?.length ?? 0,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          bool isReminderActive = false;
          vlccReminderModelList = snapshot.data ?? [];
          if (snapshot.hasData) {
            vlccReminderModelList = snapshot.data ?? [];
            for (var element in vlccReminderModelList) {
              if (element.reminderTitle ==
                      _appointmentListModel
                          .appointmentDetails![index].serviceName &&
                  element.appointmentId ==
                      int.parse(
                        _appointmentListModel
                            .appointmentDetails![index].appointmentId,
                      )) {
                isReminderActive = true;
              }
            }
          }

          DateTime date = _appointmentListModel
                  .appointmentDetails![index].appointmentDate ??
              DateTime.now();

          String timeString = DateFormat.jm().format(DateFormat("hh:mm:ss")
              .parse(_appointmentListModel
                  .appointmentDetails![index].appointmentTime));
          String dateString = Jiffy(date).yMMMEd;
          // String timeString = Jiffy(time).jm;
          if (_appointmentListModel
              .appointmentDetails![index].serviceName.toTitleCase.isEmpty) {
            _appointmentListModel.appointmentDetails?[index].serviceName =
                'Pseudo Service Name';
          }

          if (_appointmentListModel.appointmentDetails![index].appointmentType
                  .toLowerCase() ==
              'general') {
            return AppointmentCard(
              appointmentListModel: _appointmentListModel,
              index: index,
              timeString: timeString,
              dateString: dateString,
              isReminderActive: isReminderActive,
              vlccReminderModelList: vlccReminderModelList,
              callback: _init,
            );
          } else {
            return SizedBox();
          }
        });
  }

  PreferredSize _appBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: Text(
            'VLCC',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.logoOrange,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.heading,
              fontFamily: FontName.frutinger,
            ),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerAppointmentHistory()),
                );
              },
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: MarginSize.small),
                  child: SvgPicture.asset(SVGAsset.invitation,
                      height: 21, color: AppColors.calanderColor)),
            ),
            SizedBox(width: 16),
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Reminders();
                  }));
                },
                child: SvgPicture.asset(SVGAsset.reminder,
                    color: AppColors.calanderColor, height: 21)),
            SizedBox(width: 24)
          ],
        ));
  }
}
