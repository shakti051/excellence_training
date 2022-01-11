import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/consultation/consultation_feedback.dart';
import 'package:vlcc/widgets/consultation_widgets/cancel_consultation.dart';
import 'package:vlcc/widgets/consultation_widgets/reshedule_consultation.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class ApproveConsultation extends StatefulWidget {
  const ApproveConsultation({Key? key}) : super(key: key);

  @override
  _ApproveConsultationState createState() => _ApproveConsultationState();
}

class _ApproveConsultationState extends State<ApproveConsultation> {
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
    time = TimeOfDay.now();
    super.initState();
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
    _showCancelDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext c) {
            return CancelConsultation();
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
                child: Text("Consultation Details",
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.black87,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.extraLarge)),
              ),
              Text("Approved",
                  style: TextStyle(
                      color: AppColors.aquaGreen,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
            ],
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 24, top: 8),
                child:
                    SvgPicture.asset(SVGAsset.reminder, color: Colors.black87)),
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
              // ClinicName(),
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
                        child: Text("Speciality",
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
                            Text("Dermatalogist",
                                style: TextStyle(
                                    fontFamily: FontName.frutinger,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.large)),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.only(left: 12, top: 12),
                        child: Text("Services",
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
                            Text("Skin Allergy",
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
                                    child: Text("Preferred date",
                                        style: TextStyle(
                                            fontFamily: FontName.frutinger,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize.normal)),
                                  ),
                                  SizedBox(height: 4),
                                  InkWell(
                                    onTap: () {
                                      _selectedDate(context);
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
                                              DateFormat("dd/MM/yyyy")
                                                  .format(_currentDate)
                                                  .toString(),
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
                                      margin: EdgeInsets.only(
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
                                              time!.format(context),
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
                      SizedBox(height: 12)
                    ],
                  )),
              SizedBox(height: 25),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                shadowColor: AppColors.whiteShodow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12, top: 12),
                      child: Text("Problem description (Optional)",
                          style: TextStyle(
                              fontFamily: FontName.frutinger,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal)),
                    ),
                    SizedBox(height: 4),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: AppColors.backBorder),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                          '''I think my child has been exposed to chickenpox, what should I do? How long does it take to show signs of chickenpoxafter being exposed?''',
                          style: TextStyle(
                              height: 1.5,
                              fontFamily: FontName.frutinger,
                              fontWeight: FontWeight.w400,
                              fontSize: FontSize.large)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Text("Attachments (Optional)",
                          style: TextStyle(
                              fontFamily: FontName.frutinger,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal)),
                    ),
                    SizedBox(height: 24),
                    Container(
                        height: 56,
                        margin:
                            EdgeInsets.symmetric(horizontal: MarginSize.middle),
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
                    SizedBox(height: 12)
                  ],
                ),
              ),
              SizedBox(height: 24),
              GradientButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConsultationFeedback()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: MarginSize.small),
                      child: Text("Video Call",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.large,
                              color: Colors.white)),
                    ),
                    SvgPicture.asset(SVGAsset.videoAsset, color: Colors.white),
                  ],
                ),
              ),
              SizedBox(height: 24),
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
                                        child: ResheduleCOnsultation())));
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
                      // ignore: unnecessary_lambdas
                      onTap: () {
                        _showCancelDialog();
                      },
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
      )),
    );
  }
}
