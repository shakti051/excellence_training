import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/providers/consultation_provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/consultation/consultation_requested.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class ConsultationForm extends StatefulWidget {
  const ConsultationForm({Key? key}) : super(key: key);

  @override
  _ConsultationFormState createState() => _ConsultationFormState();
}

class _ConsultationFormState extends State<ConsultationForm> {
  final _problemDesc = TextEditingController();
  DateTime _currentDate = DateTime.now();
  TimeOfDay? time;
  TimeOfDay? picked;

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
    super.initState();
    time = TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
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
    final callType = context.watch<ConsultationProvider>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
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
              Text("Book Consultaion",
                  style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.heading)),
              SizedBox(height: 32),
              Text("Clinic name",
                  style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
              Container(
                height: 48,
                margin: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                    color: AppColors.greyBackground,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        child: SvgPicture.asset("assets/images/services.svg")),
                    Text("Safe Heakth clinic",
                        style: TextStyle(
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.large)),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text("Speciality",
                  style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
              Container(
                height: 48,
                margin: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                    color: AppColors.greyBackground,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        child: SvgPicture.asset("assets/images/category.svg")),
                    Text("Dermatalogist",
                        style: TextStyle(
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.large)),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text("Services",
                  style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
              Container(
                height: 48,
                margin: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                    color: AppColors.greyBackground,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        child: SvgPicture.asset(
                            "assets/images/health_clinic.svg")),
                    Text("Skin Allergy",
                        style: TextStyle(
                            fontFamily: FontName.frutinger,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.large)),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text("Call type",
                  style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
              Container(
                height: 48,
                margin: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                    //  color: AppColors.greyBackground,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    GestureDetector(
                      // ignore: unnecessary_lambdas
                      onTap: () {
                        callType.selectVideo();
                      },
                      child: Row(
                        children: [
                          callType.getVideo
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: SvgPicture.asset(SVGAsset.activeRadio))
                              : Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  width: 24.0,
                                  height: 24.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    border: Border.all(
                                        color: AppColors.backBorder,
                                        width: 2.0),
                                  ),
                                ),
                          Text("Video call",
                              style: TextStyle(
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.large)),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      // ignore: unnecessary_lambdas
                      onTap: () {
                        callType.selectAudio();
                      },
                      child: Row(
                        children: [
                          callType.getAudio
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: SvgPicture.asset(SVGAsset.activeRadio))
                              : Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  width: 24.0,
                                  height: 24.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    border: Border.all(
                                        color: AppColors.backBorder,
                                        width: 2.0),
                                  ),
                                ),
                          Container(
                            margin: EdgeInsets.only(right: 14),
                            child: Text("Audio call",
                                style: TextStyle(
                                    fontFamily: FontName.frutinger,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.large)),
                          ),
                        ],
                      ),
                    ),
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 14),
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
                              _selectTime(context);
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 14),
                                    child: SvgPicture.asset(
                                        "assets/images/clock.svg",
                                        color: AppColors.calanderColor),
                                  ),
                                  Container(
                                    height: 45,
                                    padding: EdgeInsets.only(top: 15),
                                    child: Text(
                                      time!.format(context),
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
              Text("Problem description (Optional)",
                  style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
              SizedBox(height: 4),
              TextFormField(
                  maxLines: 5,
                  maxLength: 1000,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.orangeProfile),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: 'Describe problem'),
                  controller: _problemDesc,
                  keyboardType: TextInputType.text),
              SizedBox(
                height: 30,
              ),
              Text("Attachments (Optional)",
                  style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
              SizedBox(height: 24),
              Container(
                  height: 56,
                  decoration: BoxDecoration(
                      color: AppColors.greyBackground,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: MarginSize.normal),
                          child: Icon(Icons.picture_as_pdf,
                              color: Colors.redAccent)),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Attachment-file.pdf",
                                style: TextStyle(
                                    fontFamily: FontName.frutinger,
                                    fontWeight: FontWeight.w400,
                                    fontSize: FontSize.normal)),
                            Text("12 kb",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: FontName.frutinger,
                                    fontWeight: FontWeight.w400,
                                    fontSize: FontSize.small)),
                          ],
                        ),
                      ),
                      CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                          )),
                      SizedBox(width: 16)
                    ],
                  )),
              SizedBox(height: 24),
              InkWell(
                highlightColor: Colors.blue.withOpacity(0.4),
                splashColor: AppColors.orangeProfile.withOpacity(0.5),
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.backBorder),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
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
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              GradientButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConsultationRequested()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Book Consultation",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.large,
                                color: Colors.white)),
                        Text("Subtotal: Rs. 1250",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.extraSmall,
                                color: Colors.white)),
                      ],
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
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
