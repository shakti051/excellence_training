import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/components/add_clinic_logo.dart';
import 'package:vlcc/expert/expert_view_details.dart';
import 'package:vlcc/models/appointment_expert_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/fixed_shimmer.dart';
import 'package:vlcc/widgets/nodata.dart';

class ExpertAppointmentHistory extends StatefulWidget {
  const ExpertAppointmentHistory({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpertAppointmentHistory> createState() =>
      _ExpertAppointmentHistoryState();
}

class _ExpertAppointmentHistoryState extends State<ExpertAppointmentHistory> {
  final Services _services = Services();
  AppointmentExpertModel? _appointmentExpertModel;
  int generalAppointment = 0;
  int videoAppointment = 0;
  bool _apiHit = false;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final VlccShared _vlccShared = VlccShared();

  Future<void>? expertAppointApi() {
    var body = {
      'client_mobile': _vlccShared.mobileNum,
      'auth_token': _vlccShared.authToken,
      'employee_code': _vlccShared.employeCode,
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
        if (_appointmentExpertModel!.status == 2000) {
          setState(() {
            _apiHit = true;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    expertAppointApi();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text("History",
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.black87,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.extraLarge)),
            ),
            actions: [
              Container(
                  margin: EdgeInsets.only(right: 24, top: 8),
                  child: SvgPicture.asset(SVGAsset.history,
                      color: Colors.black87)),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                child: TabBarView(
                  children: [
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
                                              .isBefore(DateTime.now()))
                                      ? Container(
                                          padding: const EdgeInsets.all(12),
                                          margin: EdgeInsets.only(bottom: 12),
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
                                                        Text(
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
                                                                      .orange,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      FontSize
                                                                          .small),
                                                            ),
                                                            Text(
                                                              Jiffy(DateTime.parse(_appointmentExpertModel!
                                                                      .appointmentexpertDetails![
                                                                          index]
                                                                      .appointmentDate!))
                                                                  .yMMMEd,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      FontSize
                                                                          .small),
                                                            ),
                                                          ],
                                                        )
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
                                                            fontSize: FontSize
                                                                .normal),
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
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ExpertViewDetails(
                                                                      appointmentExpertModel:
                                                                          _appointmentExpertModel,
                                                                      index:
                                                                          index,
                                                                      isVideoCall:
                                                                          false)),
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
                                                                      color:
                                                                          AppColors
                                                                              .orangeProfile,
                                                                      width:
                                                                          1.0),
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
                                                        Visibility(
                                                          visible: false,
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/reminder.svg",
                                                            color: AppColors
                                                                .orange,
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
                        : MyShimmer(),
                    // second tab bar viiew widget
                    videoAppointment == 0
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
                                              .appointmentexpertDetails![index]
                                              .appointmentType!
                                              .toLowerCase() ==
                                          'video consultations' &&
                                      DateTime.parse(_appointmentExpertModel!
                                              .appointmentexpertDetails![index]
                                              .appointmentDate!)
                                          .isBefore(DateTime.now()))
                                  ? Container(
                                      padding: const EdgeInsets.all(12),
                                      margin: EdgeInsets.only(bottom: 12),
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
                                                    Text(
                                                      _appointmentExpertModel!
                                                          .appointmentexpertDetails![
                                                              index]
                                                          .clientname!,
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize:
                                                              FontSize.large),
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
                                                                  .orange,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: FontSize
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
                                                                  .blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: FontSize
                                                                  .small),
                                                        ),
                                                      ],
                                                    )
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
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ExpertViewDetails(
                                                                      appointmentExpertModel:
                                                                          _appointmentExpertModel,
                                                                      index:
                                                                          index,
                                                                      isVideoCall:
                                                                          false)),
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
                                                    Visibility(
                                                      visible: false,
                                                      child: SvgPicture.asset(
                                                        "assets/images/reminder.svg",
                                                        color: AppColors.orange,
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
                            }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
