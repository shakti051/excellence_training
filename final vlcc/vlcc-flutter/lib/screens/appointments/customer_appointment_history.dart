import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/widgets/custom_shimmers.dart';
import 'package:vlcc/widgets/nodata.dart';

import 'appointment_card.dart';

class CustomerAppointmentHistory extends StatefulWidget {
  const CustomerAppointmentHistory({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerAppointmentHistory> createState() =>
      _CustomerAppointmentHistoryState();
}

class _CustomerAppointmentHistoryState
    extends State<CustomerAppointmentHistory> {
  final Services _services = Services();
  late AppointmentListModel _appointmentListModel;
  int generalAppointment = 0;
  int videoAppointment = 0;
  bool _apiHit = false;
  final VlccShared _vlccShared = VlccShared();
  late DatabaseHelper databaseHelper;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>(debugLabel: '_refreshIndicatorKey');

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    return appointListApi();
  }

  @override
  Widget build(BuildContext context) {
    databaseHelper = context.watch<DatabaseHelper>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _appBar(),
        body: _apiHit
            ? RefreshIndicator(
                onRefresh: _init,
                key: _refreshIndicatorKey,
                child: FutureBuilder(
                    future: null,
                    builder: (context, _) {
                      var general = _appointmentListModel.appointmentDetails!
                          .where((appointment) =>
                              appointment.appointmentType.toLowerCase() ==
                              'general');
                      var video = _appointmentListModel.appointmentDetails!
                          .where((appointment) =>
                              appointment.appointmentType.toLowerCase() !=
                              'general');
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
                                      : generalBooking(),
                                  _appointmentListModel
                                              .appointmentDetails!.isEmpty ||
                                          video.isEmpty
                                      ? NoDataScreen(
                                          noDataSelect:
                                              NoDataSelectType.appointment,
                                        )
                                      : videoAppointmentListView()
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

  ListView videoAppointmentListView() {
    return ListView.builder(
        itemCount: _appointmentListModel.appointmentDetails!.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          DateTime dateTime = _appointmentListModel
                  .appointmentDetails![index].appointmentDate ??
              DateTime.now();

          String timeString = DateFormat.jm().format(DateFormat("hh:mm:ss")
              .parse(_appointmentListModel
                  .appointmentDetails![index].appointmentTime));

          String dateString = Jiffy(dateTime).yMMMEd;
          if (_appointmentListModel.appointmentDetails![index].appointmentType
                  .toLowerCase() !=
              'general') {
            return AppointmentCard(
              appointmentListModel: _appointmentListModel,
              index: index,
              timeString: timeString,
              dateString: dateString,
              isReminderActive: false,
              vlccReminderModelList: const [],
              callback: () {},
            );
          } else {
            return SizedBox();
          }
        });
  }

  ListView generalBooking() {
    return ListView.builder(
        itemCount: _appointmentListModel.appointmentDetails?.length ?? 0,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          bool isReminderActive = false;

          DateTime date = _appointmentListModel
                  .appointmentDetails![index].appointmentDate ??
              DateTime.now();

          String timeString = DateFormat.jm().format(DateFormat("hh:mm:ss")
              .parse(_appointmentListModel
                  .appointmentDetails![index].appointmentTime));
          String dateString = Jiffy(date).yMMMEd;
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
              vlccReminderModelList: const [],
              callback: () {},
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
          title: Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              "History",
              style: TextStyle(
                color: Colors.black87,
                fontFamily: FontName.frutinger,
                fontWeight: FontWeight.w700,
                fontSize: FontSize.extraLarge,
              ),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ));
  }

  Future<void> appointListApi() async {
    var body = {
      'client_mobile': _vlccShared.mobileNum,
      'auth_token': _vlccShared.authToken,
      'device_id': _vlccShared.deviceId,
    };
    _services
        .callApi(body,
            '/api/api_client_rbs_appointment_list.php?request=client_rbs_appointment_list',
            apiName: 'appointment list')
        .then((value) async {
      var testVal = value;

      _appointmentListModel = appointmentListModelFromJson(testVal);

      for (int i = 0;
          i < (_appointmentListModel.appointmentDetails?.length ?? 0);
          i++) {
        _appointmentListModel.appointmentDetails?.sort((a, b) {
          return b.appointmentDate!.compareTo(a.appointmentDate!);
        });
      }

      _appointmentListModel.appointmentDetails!.removeWhere((element) {
        bool isTrue = DateTime.fromMillisecondsSinceEpoch(
                element.appointmentStartDateTime * 1000)
            .isAfter(
          DateTime.now(),
        );

        return isTrue;
      });

      setState(() {
        _apiHit = true;
      });
    });
  }
}
