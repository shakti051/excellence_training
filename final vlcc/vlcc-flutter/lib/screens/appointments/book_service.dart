import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/center_master_model.dart';
import 'package:vlcc/models/profile_model.dart';
import 'package:vlcc/models/service_master_model.dart';
import 'package:vlcc/payU/payu_money.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/resources/util_functions.dart';
import 'package:vlcc/resources/vlcc_theme.dart';
import 'package:vlcc/widgets/custom_alert_dialog.dart';
import 'package:vlcc/widgets/custom_loader.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import 'package:vlcc/widgets/gradient_button.dart';
import 'package:vlcc/widgets/heading_title_text.dart';
import 'package:vlcc/widgets/nodata.dart';
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';

import 'appointment_requested.dart';

class BookService extends StatefulWidget {
  final String centerCode;
  final String bookingTypePackage;
  final String serviceName;
  final String serviceCode;
  final String centerName;
  final String bookingId;
  final String bookingItemId;
  final bool isBookViaPackage;
  final CenterMasterDatabase centerMasterDatabase;
  final ServiceMasterDatabase serviceMasterDatabase;
  final bool isFromSearch;
  const BookService({
    Key? key,
    required this.centerMasterDatabase,
    required this.serviceMasterDatabase,
    this.isFromSearch = false,
    this.centerCode = '',
    this.serviceName = '',
    this.centerName = '',
    this.serviceCode = '',
    this.isBookViaPackage = false,
    this.bookingId = '',
    this.bookingItemId = '',
    this.bookingTypePackage = 'General',
  }) : super(key: key);

  @override
  State<BookService> createState() => _BookServiceState();
}

class _BookServiceState extends State<BookService> {
  final TextEditingController _problemDesc = TextEditingController();
  final TextEditingController _searchCenterController = TextEditingController();
  final DatabaseHelper dbh = DatabaseHelper();
  DateTime _currentDate = DateTime.now();
  FixedExtentScrollController _periodScrollController =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _hourScrollController =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _minuteScrollController =
      FixedExtentScrollController(initialItem: 0);
  TimeOfDay? time;
  TimeOfDay? picked;
  String serviceCategory = '';
  VlccShared sharedPrefs = VlccShared();
  String centerCode = '';
  String _filePath = '';
  String finalHour = '08';
  String finalMinute = '00';
  String finalPeriod = 'AM';
  String preferredTime = '';
  int _hourIndex = 0;
  int _minuteIndex = 0;
  String centreName = '';
  int _periodIndex = 0;

  final picker = ImagePicker();
  final ProfileProvider profilePro = ProfileProvider();
  CenterMasterDatabase selectedCenter = CenterMasterDatabase();
  ProfileModel profileModel = ProfileModel(
      clientProfileDetails:
          ClientProfileDetails(clientDateofBirth: DateTime.now()));
  @override
  void initState() {
    super.initState();
    setState(() {
      preferredTime = '$finalHour:$finalMinute $finalPeriod';
    });
    if (widget.isBookViaPackage) {
      getServiceCategory().then((value) {
        setState(() {
          serviceCategory = value;
        });
      });
    } else {
      profilePro.setServicePriceApi(
          centerCode: widget.centerMasterDatabase.centerCode,
          serviceCode: widget.serviceMasterDatabase.serviceCode,
          serviceType: widget.serviceMasterDatabase.serviceType);
    }
    // getProfileDetails();

    time = TimeOfDay.now();
  }

  @override
  void dispose() {
    _periodScrollController.dispose();
    _hourScrollController.dispose();
    _minuteScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var db = DateFormat.yMMMMd('en_US').format(_currentDate).toString();
    final profileProvider = context.watch<ProfileProvider>();
    final dashboardProvider = context.watch<DashboardProvider>();
    final database = context.watch<DatabaseHelper>();
    centreName = widget.isBookViaPackage
        ? widget.centerName
        : widget.centerMasterDatabase.centerName;

    return WillPopScope(
      onWillPop: () {
        dashboardProvider.centerName = '';
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _appBar(
          dashboardProvider: dashboardProvider,
          database: database,
          context: context,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSize.extraLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text("Book Appointment",
                      style: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.heading)),
                  Visibility(
                    visible: !widget.isFromSearch,
                    child: bookingCards(
                      onTap: () {},
                      fieldLabel: 'Clinic name',
                      imagePath: 'assets/images/services.svg',
                      fieldContent: centreName,
                    ),
                  ),
                  bookingCards(
                      onTap: () {},
                      fieldLabel: 'Speciality',
                      imagePath: 'assets/images/category.svg',
                      fieldContent: widget.isBookViaPackage
                          ? serviceCategory
                          : widget.serviceMasterDatabase.serviceCategory),
                  bookingCards(
                      onTap: () {},
                      fieldLabel: 'Service',
                      imagePath: 'assets/images/health_clinic.svg',
                      fieldContent: widget.isBookViaPackage
                          ? widget.serviceName
                          : widget.serviceMasterDatabase.serviceName),
                  Visibility(
                    visible: widget.isFromSearch,
                    child: bookingCards(
                        onTap: () => showModalBottomSheet(
                              context: context,
                              isDismissible: true,
                              isScrollControlled: true,
                              constraints: BoxConstraints(
                                minHeight: 200,
                              ),
                              enableDrag: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              )),
                              builder: (context) => Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewPadding
                                          .bottom),
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 24),
                                          child: TextField(
                                            controller: _searchCenterController,
                                            onChanged: (value) => _runFilter(
                                                value.trim(), database),
                                            decoration: const InputDecoration(
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .orangeProfile),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                borderSide: BorderSide(
                                                  color:
                                                      AppColors.greyBackground,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                borderSide: BorderSide(
                                                  color:
                                                      AppColors.greyBackground,
                                                ),
                                              ),
                                              fillColor:
                                                  AppColors.greyBackground,
                                              hintText:
                                                  'Search location, clinic, speciality...',
                                              prefixIcon: Icon(
                                                CupertinoIcons.search,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (database.centerMasterFilterList
                                            .isNotEmpty) ...[
                                          SizedBox(
                                            height: 300,
                                            child: ListView.builder(
                                                itemCount: database
                                                    .centerMasterFilterList
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      selectedCenter = database
                                                              .centerMasterFilterList[
                                                          index];
                                                      dashboardProvider
                                                              .centerName =
                                                          database
                                                              .centerMasterFilterList[
                                                                  index]
                                                              .centerName;
                                                      Navigator.pop(context);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 4),
                                                      child: ListTile(
                                                        // tileColor: ,
                                                        title: Text(
                                                          database
                                                              .centerMasterFilterList[
                                                                  index]
                                                              .centerName
                                                              .toLowerCase()
                                                              .toTitleCase,
                                                        ),
                                                        subtitle: Text(
                                                            "${database.centerMasterFilterList[index].areaName.toLowerCase().toTitleCase}\n${database.centerMasterFilterList[index].addressLine1.toLowerCase().toTitleCase}"),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                        ],
                                        if (database.centerMasterFilterList
                                            .isEmpty) ...[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 24),
                                            child: NoDataScreen(
                                              noDataSelect:
                                                  NoDataSelectType.package,
                                            ),
                                          ),
                                        ]
                                      ],
                                    ),
                                  )),
                            ),
                        isShowIcon: true,
                        fieldContent: dashboardProvider.centerName,
                        fieldLabel: 'Select center',
                        imagePath: 'assets/images/services.svg'),
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
                        SizedBox(width: 16),
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
                                  _selectTime(
                                    context,
                                    dashboardProvider: dashboardProvider,
                                  );
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
                                          preferredTime,
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
                  SizedBox(height: 25),
                  Text(
                    "Additional information  (Optional)",
                    style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                      maxLines: 5,
                      maxLength: 200,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.orangeProfile),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          hintText: 'Add info here ...'),
                      controller: _problemDesc,
                      keyboardType: TextInputType.text),
                  SizedBox(height: 8),
                  Text("Attachments (Optional)",
                      style: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.normal)),
                  Visibility(
                    visible: profileProvider
                        .bookAppointmentAttachment.path.isNotEmpty,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: PaddingSize.extraLarge),
                      child: ListTile(
                        horizontalTitleGap: 0,
                        tileColor: AppColors.greyBackground,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        leading:
                            Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                        title: HeadingTitleText(
                          fontSize: FontSize.normal,
                          title: basename(
                              profileProvider.bookAppointmentAttachment.path),
                        ),
                        trailing: InkWell(
                          child: Icon(Icons.close_outlined),
                          onTap: () {
                            profileProvider.bookAppointmentAttachment =
                                File('');
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: VlccColor.lightOrange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                width: 1, color: AppColors.backBorder),
                          )),
                      onPressed: () {
                        getFile(profileProvider);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(SVGAsset.attachIcon),
                          SizedBox(width: 16),
                          Text("Add Attachments",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.large,
                                  color: Colors.grey)),
                        ],
                      )),
                  SizedBox(height: 32),
                  GradientButton(
                    onPressed: () {
                      if (profileProvider.isLoading) {
                        return;
                      }
                      profileProvider.isLoading = true;
                      final snackBar = SnackBar(
                        content: Text(
                          'Sorry we were unable to process your request at the moment.',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        // behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.orange,
                      );
                      final selectCentreSnackBar = SnackBar(
                        content: Text(
                          'Please select a center to proceed.',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: AppColors.orange,
                      );

                      if (centreName.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(selectCentreSnackBar);
                        profileProvider.isLoading = false;
                        return;
                      }

                      if (widget.isBookViaPackage) {
                        packageBook(
                                profileProvider: profileProvider,
                                dashboardProvider: dashboardProvider)
                            .then((value) {
                          if (!isAfterThisHour()) {
                            profileProvider.isLoading = false;
                            final snackBar = SnackBar(
                              content: Text(
                                'This time slot is not available.',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: AppColors.orange,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          if (value && isAfterThisHour()) {
                            profileProvider.isLoading = false;
                            profileProvider.bookAppointmentAttachment =
                                File('');
                            var centerName = !widget.isFromSearch
                                ? widget.centerMasterDatabase.centerName
                                : selectedCenter.centerName;
                            var serviceName =
                                widget.serviceMasterDatabase.serviceName;
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomAlertDialog(
                                    title:
                                        'Do you want to continue without paying?',
                                    onNo: () {
                                      Navigator.pop(context);
                                      PayUMoneyVlcc().callPaymentMethod(
                                        amount: '1',
                                        centerName: centerName,
                                        preferredTime: preferredTime,
                                        serviceName: serviceName,
                                        db: db,
                                      );
                                    },
                                    onYes: () {
                                      cashBook(
                                              centerMasterDatabase: !widget
                                                      .isFromSearch
                                                  ? widget.centerMasterDatabase
                                                  : selectedCenter,
                                              profileProvider: profileProvider,
                                              dashboardProvider:
                                                  dashboardProvider)
                                          .then((value) {
                                        log('$value', name: 'book');
                                        if (value) {
                                          profileProvider.isLoading = false;
                                          profileProvider
                                                  .bookAppointmentAttachment =
                                              File('');
                                          var centerName = !widget.isFromSearch
                                              ? widget.centerMasterDatabase
                                                  .centerName
                                              : selectedCenter.centerName;
                                          var serviceName = widget
                                              .serviceMasterDatabase
                                              .serviceName;

                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              PageTransition(
                                                child: AppointmentRequested(
                                                  willConsultPrice:
                                                      profileProvider
                                                                  .servicePrice !=
                                                              ''
                                                          ? false
                                                          : true,
                                                  centerName: centerName,
                                                  serviceName: serviceName,
                                                  date: db,
                                                  time: preferredTime,
                                                ),
                                                type: PageTransitionType.fade,
                                              ),
                                              (route) => false);
                                        } else {
                                          profileProvider.isLoading = false;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      });
                                    },
                                  );
                                });
                          } else {
                            profileProvider.isLoading = false;
                            final snackBar = SnackBar(
                              content: Text(
                                'Sorry we were unable to process your request at the moment.',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: AppColors.orange,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      } else {
                        centreName = selectedCenter.centerName;
                        if (centreName.trim().isEmpty && widget.isFromSearch) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(selectCentreSnackBar);
                          profileProvider.isLoading = false;
                          return;
                        } else if (!isAfterThisHour()) {
                          profileProvider.isLoading = false;
                          final snackBar = SnackBar(
                            content: Text(
                              'This time slot is not available.',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: AppColors.orange,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        if ((!widget.isFromSearch ||
                                (centreName.trim().isNotEmpty &&
                                    widget.isFromSearch)) &&
                            isAfterThisHour()) {
                          dashboardProvider.centerName = '';
                          profileProvider.isLoading = false;
                          profileProvider.bookAppointmentAttachment = File('');
                          var centerName = !widget.isFromSearch
                              ? widget.centerMasterDatabase.centerName
                              : selectedCenter.centerName;
                          var serviceName =
                              widget.serviceMasterDatabase.serviceName;
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomAlertDialog(
                                  title:
                                      'Do you want to continue without paying?',
                                  onNo: () {
                                    PayUMoneyVlcc().callPaymentMethod(
                                      amount: '1',
                                      centerName: centerName,
                                      preferredTime: preferredTime,
                                      serviceName: serviceName,
                                      db: db,
                                    );
                                    // Navigator.pop(context);
                                  },
                                  onYes: () {
                                    cashBook(
                                            centerMasterDatabase: !widget
                                                    .isFromSearch
                                                ? widget.centerMasterDatabase
                                                : selectedCenter,
                                            profileProvider: profileProvider,
                                            dashboardProvider:
                                                dashboardProvider)
                                        .then((value) {
                                      log('$value', name: 'book');
                                      if (value) {
                                        profileProvider.isLoading = false;
                                        profileProvider
                                                .bookAppointmentAttachment =
                                            File('');
                                        var centerName = !widget.isFromSearch
                                            ? widget
                                                .centerMasterDatabase.centerName
                                            : selectedCenter.centerName;
                                        var serviceName = widget
                                            .serviceMasterDatabase.serviceName;

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            PageTransition(
                                              child: AppointmentRequested(
                                                willConsultPrice:
                                                    profileProvider
                                                                .servicePrice !=
                                                            ''
                                                        ? false
                                                        : true,
                                                centerName: centerName,
                                                serviceName: serviceName,
                                                date: db,
                                                time: preferredTime,
                                              ),
                                              type: PageTransitionType.fade,
                                            ),
                                            (route) => false);
                                      } else {
                                        profileProvider.isLoading = false;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    });
                                  },
                                );
                              });
                        } else {
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: !profileProvider.isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Book Appointment",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.large,
                                          color: Colors.white)),
                                  Visibility(
                                    visible: !widget.isBookViaPackage &&
                                        profileProvider.servicePrice != '',
                                    child: Text(
                                      'Subtotal: ₹ ${profileProvider.servicePrice}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSize.extraSmall,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          )
                        : CustomLoader(
                            customLoaderType: CustomLoaderType.defaultCupertino,
                          ),
                  ),
                  SizedBox(height: 42)
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  PreferredSize _appBar(
      {required DashboardProvider dashboardProvider,
      required DatabaseHelper database,
      required BuildContext context}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: AppBar(
        actions: [
          Visibility(
              visible: widget.isBookViaPackage,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  border: Border.all(
                    color: AppColors.pink,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset(
                        SVGAsset.packageBookingStar,
                        color: AppColors.pink,
                      ),
                    ),
                    HeadingTitleText(
                      fontSize: FontSize.large,
                      fontWeight: FontWeight.w600,
                      color: AppColors.pink,
                      title: 'Booking through package',
                    ),
                  ],
                ),
              )),
          // Visibility(
          //     visible: !widget.isBookViaPackage &&
          //         profileProvider.servicePrice == '',
          //     child: Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(25),
          //           bottomLeft: Radius.circular(25),
          //         ),
          //         border: Border.all(
          //           color: AppColors.pink,
          //         ),
          //       ),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Flexible(
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 8),
          //               child: SvgPicture.asset(
          //                 SVGAsset.packageBookingStar,
          //                 color: AppColors.pink,
          //               ),
          //             ),
          //           ),
          //           Flexible(
          //             child: HeadingTitleText(
          //               fontSize: FontSize.large,
          //               fontWeight: FontWeight.w600,
          //               color: AppColors.pink,
          //               title: 'This service is not available',
          //             ),
          //           ),
          //         ],
          //       ),
          //     ))
        ],
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'VLCC',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.logoOrange,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.heading,
              fontFamily: FontName.frutinger,
            ),
          ),
        ),
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
                dashboardProvider.centerName =
                    database.centerMasterDbList.first.centerName;
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(SVGAsset.backButton),
            ),
          ),
        ),
      ),
    );
  }

  Widget bookingCards(
      {required String fieldLabel,
      required String imagePath,
      required String fieldContent,
      required void Function() onTap,
      bool isShowIcon = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(fieldLabel,
            style: TextStyle(
                fontFamily: FontName.frutinger,
                fontWeight: FontWeight.w600,
                fontSize: FontSize.normal)),
        GestureDetector(
          onTap: onTap,
          child: Card(
            color: AppColors.greyBackground,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SvgPicture.asset(imagePath),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              fieldContent.toLowerCase().toTitleCase,
                              style: TextStyle(
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.large),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isShowIcon,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.profileEnabled,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  Future<void> _selectTime(BuildContext context,
      {required DashboardProvider dashboardProvider}) async {
    _hourScrollController =
        FixedExtentScrollController(initialItem: _hourIndex);
    _minuteScrollController =
        FixedExtentScrollController(initialItem: _minuteIndex);

    _periodScrollController =
        FixedExtentScrollController(initialItem: _periodIndex);
    int initHour = 7;
    const List<String> period = ['AM', 'PM'];
    finalPeriod = period[_periodIndex];
    preferredTime = '$finalHour:$finalMinute $finalPeriod';
    var hours = List.generate(12, (index) {
      initHour = initHour + 1;
      return UtilityFunctions.hourConverter(initialTime: initHour);
    });
    picked = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          double itemExtent = 45.0;
          return SizedBox(
            height: 200,
            child: AlertDialog(
              title: HeadingTitleText(
                fontSize: FontSize.defaultFont,
                title: 'Preferred time',
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 300,
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: _hourScrollController,
                            useMagnifier: true,
                            looping: true,
                            itemExtent: itemExtent,
                            onSelectedItemChanged: (value) {
                              _hourIndex = value;

                              if (hours[value] >= 1 && hours[value] < 8 ||
                                  hours[value] == 12) {
                                _periodScrollController.animateToItem(1,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.ease);
                              } else {
                                _periodScrollController.animateToItem(0,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.ease);
                              }
                              finalHour = hours[value].toString();
                            },
                            children: List.generate(
                              hours.length,
                              (index) => Center(
                                child: Text(
                                  hours[index].toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: CupertinoPicker(
                          scrollController: _minuteScrollController,
                          useMagnifier: true,
                          itemExtent: itemExtent,
                          onSelectedItemChanged: (value) {
                            _minuteIndex = value;
                            finalMinute = value.toString().padLeft(2, '0');
                          },
                          children: List.generate(
                            60,
                            (index) => Center(
                                child: Text(index.toString().padLeft(2, '0'))),
                          ),
                        )),
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: dashboardProvider.isAmPm,
                            child: CupertinoPicker(
                              scrollController: _periodScrollController,
                              useMagnifier: true,
                              itemExtent: itemExtent,
                              onSelectedItemChanged: (value) {
                                _periodIndex = value;
                                finalPeriod = period[value];
                              },
                              children: List.generate(
                                period.length,
                                (index) => Center(
                                  child: Text(
                                    period[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          preferredTime =
                              '$finalHour:$finalMinute $finalPeriod';
                        });
                      },
                      child: Text('OK'))
                ],
              ),
            ),
          );
        }).then((value) {
      _periodScrollController.dispose();
      _minuteScrollController.dispose();
      _hourScrollController.dispose();
    });
  }

  Future<bool> packageBook({
    required ProfileProvider profileProvider,
    required DashboardProvider dashboardProvider,
  }) async {
    var db =
        '${_currentDate.year}-${(_currentDate.month).toString().padLeft(2, '0')}-${(_currentDate.day).toString().padLeft(2, '0')}';
    // var tme = time!.format(context);

    var attachDoc = profileProvider.bookAppointmentAttachment.path != ''
        ? await MultipartFile.fromFile(_filePath)
        : '';
    int isAmPm = finalPeriod.toLowerCase() == 'am' || int.parse(finalHour) == 12
        ? 0
        : 12;
    var startTime = "${int.parse(finalHour) + isAmPm}:$finalMinute:00";
    var endTime = "${int.parse(finalHour) + isAmPm + 2}:$finalMinute:00";
    FormData formData = FormData.fromMap({
      'client_mobile': sharedPrefs.mobileNum,
      'device_id': sharedPrefs.deviceId,
      'auth_token': sharedPrefs.authToken,
      'BookingId': widget.bookingId,
      'booking_item_id': widget.bookingItemId,
      'center_code': widget.centerCode,
      'appointment_date': db,
      'appointment_start_time': startTime,
      'appointment_end_time': endTime,
      'appointment_comment': _problemDesc.text,
      'att_doc': attachDoc,
      'appointment_type': widget.bookingTypePackage,
    });
    Dio dio = Dio();
    var response = await dio.post(
        '${Services.baseUrl}/api/api_book_appointment_pkg.php?request=book_appointment_pkg',
        data: formData);
    log(response.toString(), name: 'book service via package');
    if (response.data['Status'] == 2000) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> cashBook(
      {required DashboardProvider dashboardProvider,
      required CenterMasterDatabase centerMasterDatabase,
      required ProfileProvider profileProvider}) async {
    var db = '${_currentDate.year}-${_currentDate.month}-${_currentDate.day}';
    // var tme = time!.format(context);
    var attachDoc = profileProvider.bookAppointmentAttachment.path != ''
        ? await MultipartFile.fromFile(_filePath)
        : '';
    log('$attachDoc', name: 'book aatachment');
    int isAmPm = finalPeriod.toLowerCase() == 'am' ? 0 : 12;
    var startTime = "${int.parse(finalHour) + isAmPm}:$finalMinute:00";
    FormData formData = FormData.fromMap({
      'client_mobile': sharedPrefs.mobileNum,
      'device_id': sharedPrefs.deviceId,
      'auth_token': sharedPrefs.authToken,
      'client_gender':
          dashboardProvider.profileModel.clientProfileDetails.clientGender,
      'client_name': sharedPrefs.name,
      'client_emailid':
          dashboardProvider.profileModel.clientProfileDetails.clientEmailid,
      'service_code': widget.serviceMasterDatabase.serviceCode,
      'center_code': centerMasterDatabase.centerCode,
      'appointment_type': widget.serviceMasterDatabase.serviceAppFor,
      'appointment_date': db,
      'appointment_time': startTime,
      'appointment_comment': _problemDesc.text,
      'att_doc': attachDoc,
    });
    Dio dio = Dio();
    var response = await dio.post(
        '${Services.baseUrl}/api/api_book_new_appointment.php?request=client_book_new_appointment',
        data: formData);

    log(response.toString(), name: 'book service');
    if (response.data['Status'] == 2000) {
      return true;
    } else {
      return false;
    }
  }

  void _runFilter(String enteredKeyword, DatabaseHelper databaseHelper) {
    var centerList = databaseHelper.centerMasterDbList;
    databaseHelper.centerMasterFilterList = centerList;
    List<CenterMasterDatabase> _filterService = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      // results = serviceList;
      _filterService = databaseHelper.centerMasterDbList;
    } else {
      _filterService = centerList
          .where(
            (center) =>
                center.areaName.toLowerCase().contains(
                      enteredKeyword.toLowerCase(),
                    ) ||
                center.centerName.toLowerCase().contains(
                      enteredKeyword.toLowerCase(),
                    ),
          )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    databaseHelper.centerMasterFilterList = _filterService;
  }

  Future<String> getServiceCategory() async {
    var sort = dbh.serviceMasterDbList
        .firstWhere((element) => element.serviceCode == widget.serviceCode);
    return sort.serviceCategory;
  }

  Future<void> getFile(ProfileProvider profileProvider) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx']);
    if (result != null) {
      profileProvider.bookAppointmentAttachment =
          File(result.files.single.path ?? '');
      _filePath = profileProvider.bookAppointmentAttachment.path;
    } else {
      //If user canceled the picker
    }
  }

  Future<void> _selectedDate(BuildContext context) async {
    var today = DateTime.now();
    final DateTime? _selDate = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime.now(),
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

  bool isAfterThisHour() {
    var now = DateTime.now();
    // var hour = hourConverter(initialTime: now.hour);
    var hour = finalPeriod == 'AM' || int.parse(finalHour) == 12
        ? int.parse(finalHour)
        : int.parse(finalHour) + 12;
    if (_currentDate.day == now.day) {
      if (hour > now.hour) {
        return true;
      } else if (hour == now.hour) {
        if (int.parse(finalMinute) > now.minute) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
