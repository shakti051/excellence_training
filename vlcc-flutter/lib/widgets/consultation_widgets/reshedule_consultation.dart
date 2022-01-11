import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/consultation/pending_consultations.dart';

import '../gradient_button.dart';

class ResheduleCOnsultation extends StatefulWidget {
  const ResheduleCOnsultation({Key? key}) : super(key: key);

  @override
  _ResheduleCOnsultationState createState() => _ResheduleCOnsultationState();
}

class _ResheduleCOnsultationState extends State<ResheduleCOnsultation> {
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
    return Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.only(top: 8, bottom: 20),
                      height: 2,
                      width: 70,
                      color: AppColors.backBorder)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reshedule Consultation",
                      style: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.large)),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, color: Colors.grey))
                ],
              ),
              SizedBox(height: 20),
              Divider(height: 2, color: AppColors.backBorder),
              SizedBox(height: 20),
              SizedBox(
                height: 75,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: MarginSize.middle),
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
                              margin: EdgeInsets.only(left: MarginSize.middle),
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
                              margin: EdgeInsets.only(right: MarginSize.middle),
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
              RichText(
                text: TextSpan(
                  text: 'Note: Resheduling an ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.small),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Approved consultation',
                      style: TextStyle(
                          color: AppColors.aquaGreen,
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.small),
                    ),
                    TextSpan(
                      text: ' will change its status back to ',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.black87,
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.small),
                    ),
                    TextSpan(
                      text: 'Pending',
                      style: TextStyle(
                          color: AppColors.pink,
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.small),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26),
              GradientButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: SizedBox(
                        height: 18,
                        child: const Text(
                          'Consultation Resheduled',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      duration: const Duration(milliseconds: 5000),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      action: SnackBarAction(
                        textColor: AppColors.orange,
                        label: 'Undo',
                        onPressed: () {
                          // Code to execute.
                        },
                      ),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PendingConsultation()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: MarginSize.small),
                      child: Text("Reshedule Consultation",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.large,
                              color: Colors.white)),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26)
            ]),
          ),
        ));
  }
}
