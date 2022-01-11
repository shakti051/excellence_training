import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:vlcc/models/appointment_list_model.dart';
import 'package:vlcc/models/cancel_appointment_model.dart';
import 'package:vlcc/models/enablex_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/apiHandler/api_url/api_url.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/resources/util_functions.dart';
import 'package:vlcc/screens/appointments/reshedule_appointment.dart';
import 'package:vlcc/screens/enable_x/av_call.dart';
import 'package:vlcc/screens/enable_x/video_call.dart';
import 'package:vlcc/widgets/appointment_widgets/appointment_widgets.dart';
import 'package:vlcc/widgets/gradient_button.dart';
import 'package:vlcc/widgets/heading_title_text.dart';

class ViewDetails extends StatefulWidget {
  final int index;
  final bool isVideoCall;
  final AppointmentListModel? appointmentListModel;

  const ViewDetails({
    Key? key,
    this.index = 0,
    required this.appointmentListModel,
    required this.isVideoCall,
  }) : super(key: key);

  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  final TextEditingController _problemDesc = TextEditingController();
  final Services _services = Services();
  CancelAppointmentModel? cancelAppointmentModel;
  final DateTime _currentDate = DateTime.now();
  TimeOfDay? time;
  TimeOfDay? picked;
  bool isCancelled = false;

  String kBaseURL = "https://api.enablex.io/video/v2/";
  /* To try the app with Enablex hosted service you need to set the kTry = true */
  static bool kTry = true;
  /*Use enablec portal to create your app and get these following credentials*/

  static const String kAppId = "613f4b836e698c498006add6";
  static const String kAppkey = "qaTyPaPetyNezuteYedy5aRyBeAaSuDyuaVe";

  static String token = "";
  bool permissionError = false;
  VlccShared sharedPrefs = VlccShared();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  AppointmentDetail _appointmentDetail =
      AppointmentDetail(appointmentRoom: '', appointmentToken: '');

  var header = kTry
      ? {
          "x-app-id": kAppId,
          "x-app-key": kAppkey,
          "Content-Type": "application/json"
        }
      : {
          "Content-Type": "application/json",
        };

  @override
  void initState() {
    time = TimeOfDay.now();
    _appointmentDetail =
        widget.appointmentListModel?.appointmentDetails?[widget.index] ??
            AppointmentDetail(appointmentRoom: '', appointmentToken: '');
    _problemDesc.text = _appointmentDetail.appointmentRemark.trim();
    isCancelled =
        _appointmentDetail.appointmentStatus.toLowerCase() == 'cancelled'
            ? true
            : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showCancelDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext c) {
            return CancelDialouge(
              index: widget.index,
              appointmentListModel: widget.appointmentListModel,
            );
          }).then((value) {
        isCancelled = value as bool;
        setState(() {});
      });
    }

    return Scaffold(
      backgroundColor: AppColors.whiteShodow,
      appBar: _appBar(),
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
                              Text(_appointmentDetail.serviceName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: FontSize.defaultFont)),
                              SizedBox(height: 4),
                              Text(
                                _appointmentDetail.centerName
                                    .toLowerCase()
                                    .toTitleCase,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.normal),
                              ),
                              SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  text: _appointmentDetail.cityName
                                      .toString()
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
                          child: Text("Service Name",
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
                                      "assets/images/category.svg")),
                              Flexible(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: MarginSize.middle),
                                  child: Text(_appointmentDetail.serviceName,
                                      style: TextStyle(
                                          fontFamily: FontName.frutinger,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.large)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12, top: 12, bottom: 4),
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
                              Text(_appointmentDetail.cityName,
                                  style: TextStyle(
                                      fontFamily: FontName.frutinger,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize.large)),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
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
                                    SizedBox(height: 8),
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
                                                        .appointmentListModel!
                                                        .appointmentDetails![
                                                            widget.index]
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
                        SizedBox(height: 8),
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
                                    SizedBox(height: 8),
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
                                                DateFormat.jm().format(
                                                    DateFormat("hh:mm:ss")
                                                        .parse(
                                                            _appointmentDetail
                                                                .appointmentTime
                                                                .toString())),
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
                        SizedBox(height: 8),
                      ],
                    )),
                SizedBox(height: 24),
                if (_appointmentDetail.appointmentRemark.trim().isNotEmpty) ...[
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    shadowColor: AppColors.whiteShodow,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Additional information",
                            style: TextStyle(
                              fontFamily: FontName.frutinger,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            maxLines: 5,
                            maxLength: 200,
                            readOnly: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.orangeProfile),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: _problemDesc.text,
                            ),
                            controller: _problemDesc,
                          ),
                          if (_appointmentDetail.appointmentAttDoc
                              .trim()
                              .isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                horizontalTitleGap: 0,
                                tileColor: AppColors.greyBackground,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                leading: Icon(Icons.picture_as_pdf,
                                    color: Colors.redAccent),
                                title: HeadingTitleText(
                                  fontSize: FontSize.normal,
                                  title: _appointmentDetail.appointmentAttDoc
                                      .trim(),
                                ),
                                onTap: () {
                                  String url = _appointmentDetail
                                      .appointmentAttDoc
                                      .trim();
                                  launch(url, forceWebView: false);
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 24),
                GradientButton(
                  gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.blue,
                        Colors.lightBlue,
                      ]),
                  child: Container(
                    height: 46,
                    margin: EdgeInsets.only(
                        left: MarginSize.middle, right: MarginSize.middle),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 45,
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            _appointmentDetail.phoneNumber
                                .toString()
                                .split(",")[0],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.normal),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  onPressed: () async {
                    String phoneNumber = _appointmentDetail.phoneNumber
                        .toString()
                        .split("/")
                        .first;
                    String url = "tel:$phoneNumber";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                SizedBox(height: 24),
                GradientButton(
                  onPressed: () {
                    if (widget.isVideoCall) {
                      _handleVideoAppointmentStartConultation();
                    } else {
                      _showDirections();
                    }
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                          widget.isVideoCall
                              ? 'Start Consultation'
                              : "Show Directions",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.large,
                              color: Colors.white)),
                      SizedBox(width: 8),
                      if (!widget.isVideoCall)
                        SvgPicture.asset(SVGAsset.mapIcon, color: Colors.white),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                !isCancelled &&
                        !isAppointmentDateBeforeNow(
                            DateTime.fromMillisecondsSinceEpoch(
                                _appointmentDetail.appointmentStartDateTime *
                                    1000))
                    ? Row(
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
                                      child: ResheduleAppointment(
                                        appointmentListModel:
                                            widget.appointmentListModel,
                                        index: widget.index,
                                      ),
                                    ),
                                  ),
                                );
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
                              onTap: showCancelDialog,
                              child: Text("Cancel",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: FontSize.large,
                                      color: AppColors.pink)),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(height: 42)
              ],
            ),
          ),
        ),
      )),
    );
  }

  _handleVideoAppointmentStartConultation() {
    // if (_appointmentDetail.appointmentStatus.toLowerCase() != 'approved') {
    //   UtilityFunctions.showToast(
    //     message:
    //         'Video consultation not approved yet.\nPlease try again after it is approved.',
    //     isErrorToast: true,
    //   );
    //   return;
    // }

    joinRoomValidations();
    createToken();
    // if (isAfterThisMoment(
    //   DateTime.fromMillisecondsSinceEpoch(widget
    //           .appointmentListModel!
    //           .appointmentDetails![widget.index]
    //           .appointmentStartDateTime *
    //       1000),
    // )) {
    //   joinRoomValidations();
    //   createToken();
    // } else {
    //   showToast(
    //       "You will be allowed to join at the selected time duration only.");
    // }
  }

  _showDirections() {
    double destinationLatitude =
        double.parse(_appointmentDetail.centerLatitude);
    double destinationLongitude =
        double.parse(_appointmentDetail.centerLongitude);
    UtilityFunctions.launchMapsUrl(
      sourceLatitude: destinationLatitude,
      sourceLongitude: destinationLongitude,
      destinationLatitude: destinationLatitude,
      destinationLongitude: destinationLongitude,
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
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
            Text(
                isCancelled
                    ? 'Cancelled'
                    : _appointmentDetail.appointmentStatus,
                style: TextStyle(
                    color: _appointmentDetail.appointmentStatus.toLowerCase() ==
                            'approved'
                        ? AppColors.aquaGreen
                        : AppColors.orange,
                    fontFamily: FontName.frutinger,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.normal)),
          ],
        ),
        actions: [
          _appointmentDetail.appointmentStatus.toLowerCase() == 'approved'
              ? Container(
                  margin: EdgeInsets.only(right: 24, top: 8),
                  child:
                      SvgPicture.asset(SVGAsset.reminder, color: Colors.black))
              : SizedBox(),
        ],
      ),
    );
  }

  void cancelAppointment() {
    var body = {
      'client_mobile': sharedPrefs.mobileNum,
      'auth_token': sharedPrefs.authToken,
      'device_id': sharedPrefs.deviceId,
      'appointment_cancel_date': _currentDate,
      'AppointmentId': _appointmentDetail.appointmentId,
      'cancellation_comment': "test",
    };
    _services
        .callApi(body,
            '/api/api_appointment_cancel_rbs.php?request=appointment_cancel',
            apiName: 'Cancel Appointment RBI')
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

  bool isAppointmentDateBeforeNow(DateTime date) {
    var now = DateTime.now();
    return date.isBefore(now);
  }

  Future<void> joinRoomValidations() async {
    log('joinRoomValidations');
    await _handleCameraAndMic();
    if (permissionError) {
      Fluttertoast.showToast(
          msg: "Plermission denied",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    // if (nameController.text.isEmpty) {
    //   Fluttertoast.showToast(
    //       msg: "Please Enter your name",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //   isValidated = false;
    // } else if (roomIdController.text.isEmpty) {
    //   Fluttertoast.showToast(
    //       msg: "Please Enter your roomId",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //   isValidated = false;
    // } else {
    //   isValidated = true;
    // }
  }

  Future<String> getRoomID() async {
    var baseUrl = "https://enablextestserver.herokuapp.com/api/create-room";
    var response = await http.get(Uri.parse(baseUrl));
    var roomId = '';
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final enableXModel = enableXModelFromJson(response.body);
      roomId = enableXModel.room!.roomId;
    }
    return roomId;
  }

  Future<void> updateRoomID({
    required String roomID,
    required String token,
  }) async {
    var body = {
      "appointment_token": token,
      "appointment_room": roomID,
      "auth_token": sharedPrefs.authToken,
      "device_id": sharedPrefs.deviceId,
      "client_mobile": sharedPrefs.mobileNum,
      "appointment_id": _appointmentDetail.appointmentId,
    };
    var response =
        await _services.callApi(body, ApiUrl.videoAppointmentTokenUpdate);
    log('$response', name: 'enable');
  }

  Future<String> createToken() async {
    // log('create room id');
    var roomId = _appointmentDetail.appointmentRoom;
    // log('getRoomID $roomId');
    var value = {
      'user_ref': Uuid().v4().hashCode.toString(),
      // "roomId": roomId,
      "role": "participant",
      "name": sharedPrefs.name.isNotEmpty ? sharedPrefs.name : '',
    };
    // log(jsonEncode(value).toString());

    String kBaseURL1 = "https://api.enablex.io/video/v2";
    String key = '$kAppId:$kAppkey';

    final encoded = base64.encode(utf8.encode(key));
    header = {
      'Authorization': 'Basic $encoded',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.post(
      Uri.parse(
        // "${kBaseURL}createToken",
        '$kBaseURL1/rooms/$roomId/tokens',
      ), // replace FQDN with Your Server API URL
      headers: header,
      body: jsonEncode(value),
    );
    log(response.statusCode.toString(), name: 'enablex create token status');
    log(response.body.toString(), name: 'enablex create token reponse');
    if (response.statusCode == 200) {
      log(response.body, name: 'create token');
      Map<String, dynamic> user = jsonDecode(response.body);
      setState(() => token = user['token'].toString());

      if (sharedPrefs.employeCode.isEmpty) {
        // await updateRoomID(roomID: roomId, token: token);
      }

      // log('updateRoomID token - $token');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            // return MyConfApp(token: token);

            return AVCallScreen(
              isVideoCall: true,
              isAudioCallOngoing: true,
              isVideoCallOngoing: true,
              token: token,
              otherUserName: '',
              videoRoomID: roomId,
            );
          },
        ),
      );
      return response.body;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<void> _handleCameraAndMic() async {
    var cam = await Permission.camera.request();
    var mic = await Permission.microphone.request();
    var store = await Permission.storage.request();
    var result = cam.isGranted && mic.isGranted && store.isGranted;
  }
}
