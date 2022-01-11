import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/expert/upcoming_appoint_expert.dart';
import 'package:vlcc/expert/upcoming_appointment_expert.dart';
import 'package:vlcc/expert/upcoming_consultation_expert.dart';
import 'package:vlcc/models/appointment_expert_model.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/providers/notification_provider_expert.dart';
import 'package:vlcc/providers/reminder_provider.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/packages/package_routes.dart';
import 'package:vlcc/widgets/appointment_widgets/appointment_widgets.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_widgets.dart';
import 'package:vlcc/widgets/fixed_shimmer.dart';
import 'future_consultation.dart';

class ExpertDashboardScreen extends StatefulWidget {
  final int appointmentId;
  final bool isFromNotification;

  const ExpertDashboardScreen(
      {Key? key, this.appointmentId = 0, this.isFromNotification = false})
      : super(key: key);

  @override
  _ExpertDashboardScreenState createState() => _ExpertDashboardScreenState();
}

class _ExpertDashboardScreenState extends State<ExpertDashboardScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final Services _services = Services();
  AppointmentExpertModel? _appointmentExpertModel;
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final NotificationProviderExpert _notificationProvider =
      NotificationProviderExpert();
  int generalAppointment = 0;
  int videoAppointment = 0;
  int fistVideoIndex = 0;
  bool _apiHit = false;
  int firstGeneral = 0;
  int firstConsultation = 0;
  bool generalFound = false;
  bool consultationFound = false;
  int upcomingAppoint = 0;
  int upcomingConsultaion = 0;
  num unreadCount = 0;

  @override
  void initState() {
    super.initState();
    expertAppointApi();
    _getUnreadCount();
  }

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
                .appointmentexpertDetails![i].appointmentType! ==
            'Video Consultations') {
          videoAppointment++;
        }
      }

      for (int i = 0;
          i < _appointmentExpertModel!.appointmentexpertDetails!.length;
          i++) {
        // ignore: unrelated_type_equality_checks
        if (_appointmentExpertModel!
                    .appointmentexpertDetails![i].appointmentType!
                    .toLowerCase() ==
                'general' &&
            DateTime.parse(_appointmentExpertModel!
                    .appointmentexpertDetails![i].appointmentDate!)
                .isAfter(DateTime.now())) {
          firstGeneral = i;
          generalFound = true;
          break;
        }
      }

      for (int i = 0;
          i < _appointmentExpertModel!.appointmentexpertDetails!.length;
          i++) {
        // ignore: unrelated_type_equality_checks
        if (_appointmentExpertModel!
                    .appointmentexpertDetails![i].appointmentType!
                    .toLowerCase() ==
                'general' &&
            DateTime.parse(_appointmentExpertModel!
                    .appointmentexpertDetails![i].appointmentDate!)
                .isAfter(DateTime.now())) {
          upcomingAppoint++;
        }
      }

      for (int i = 0;
          i < _appointmentExpertModel!.appointmentexpertDetails!.length;
          i++) {
        // ignore: unrelated_type_equality_checks
        if (_appointmentExpertModel!
                    .appointmentexpertDetails![i].appointmentType!
                    .toLowerCase() ==
                'video consultations' &&
            DateTime.parse(_appointmentExpertModel!
                    .appointmentexpertDetails![i].appointmentDate!)
                .isAfter(DateTime.now())) {
          upcomingConsultaion++;
        }
      }

      for (int i = 0;
          i < _appointmentExpertModel!.appointmentexpertDetails!.length;
          i++) {
        if (_appointmentExpertModel!
                    .appointmentexpertDetails![i].appointmentType!
                    .toLowerCase() ==
                'video consultations' &&
            DateTime.parse(_appointmentExpertModel!
                    .appointmentexpertDetails![i].appointmentDate!)
                .isAfter(DateTime.now())) {
          firstConsultation = i;
          consultationFound = true;
          break;
        }
      }

      if (_appointmentExpertModel!.status == 2000) {
        setState(() {
          _apiHit = true;
        });
      }
    });
  }

  // Future<void> apiCall() async {
  //   await _packageProvider.getPackageModelData();
  //   await _packageProvider.getCashInvoice();
  //   _databaseHelper.getUniqueSpeciality();
  //   await _dashboardProvider.getAppointmentList();
  //   _dashboardProvider.getProfileDetails();
  //   await _dashboardProvider.getGeneralAppointmentList();
  // }

  @override
  Widget build(BuildContext context) {
    final _sharedPrefs = context.watch<VlccShared>();

    return _apiHit
        ? Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              elevation: 0,
              centerTitle: false,
              title: Text(
                "Dashboard",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: FontSize.heading),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                            context, PackageRoutes.notificationsExpert)
                        .then((value) => _getUnreadCount);
                  },
                  icon: Badge(
                    animationType: BadgeAnimationType.scale,
                    animationDuration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(4.0),
                    showBadge: unreadCount == 0 ? false : true,
                    badgeContent: Text(
                      '${unreadCount.ceil()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.extraSmall,
                      ),
                    ),
                    position: BadgePosition.topEnd(end: -4),
                    child: SvgPicture.asset(
                      SVGAsset.notification,
                      color: Colors.black,
                    ),
                  ),
                ),
                InkWell(
                  onTap: showMenuDialog,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(PNGAsset.avatar),
                    onBackgroundImageError: (obj, stack) {
                      Image.asset(PNGAsset.avatar);
                    },
                  ),
                ),
                SizedBox(width: 16)
              ],
            ),
            body: SafeArea(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  _getUnreadCount();
                },
                child: SingleChildScrollView(
                  child: body(),
                ),
              ),
            ))
        : MyShimmer();
  }

  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 16),
        appointmentCard(),
        upcomingCard(),
        SizedBox(height: 30),
        UpcomingAppointExpert(
            appointmentExpertModel: _appointmentExpertModel,
            firstGeneral: firstGeneral,
            generalFound: generalFound),
        //UpcomingAppointment(),
        SizedBox(height: 26),
        UpcomingConsultationExpert(
            appointmentExpertModel: _appointmentExpertModel,
            firstConsultation: firstConsultation,
            consultationFound: consultationFound),
        SizedBox(height: 26),
      ],
    );
  }

  Widget appointmentCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
            2,
            (index) => Expanded(
                  child: Card(
                    child: Stack(
                      children: [
                        Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.orange1.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  index == 0
                                      ? SVGAsset.expertPeopleAsset
                                      : SVGAsset.videoAsset,
                                  color: AppColors.orange,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            )),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 30),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '${index == 0 ? generalAppointment : videoAppointment}',
                                  style: TextStyle(
                                      color: AppColors.profileEnabled,
                                      fontSize: 38,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  index == 0
                                      ? "Total Appointments"
                                      : "Total Consultations",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }

  Widget upcomingCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
            2,
            (index) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      index == 0
                          ? Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: UpcomingAppointmentExpert(
                                      appointmentExpertModel:
                                          _appointmentExpertModel)))
                          : Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: FutureConsultaion(
                                      appointmentExpertModel:
                                          _appointmentExpertModel)));
                    },
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.orange1.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    index == 0
                                        ? SVGAsset.expertPeopleAsset
                                        : SVGAsset.videoAsset,
                                    color: AppColors.orange,
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              )),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 30),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    '${index == 0 ? upcomingAppoint : upcomingConsultaion}',
                                    style: TextStyle(
                                        color: AppColors.profileEnabled,
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    index == 0
                                        ? "Upcoming Appointments"
                                        : "Upcoming Consultations",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  showMenuDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext c) {
        return ProfileDialouge(
          isCustomerApp: false,
        );
      },
    );
  }

  _getUnreadCount() {
    _notificationProvider.getNotifications().then((value) {
      setState(() {
        unreadCount = _notificationProvider.unreadCount;
      });
    });
  }
}
