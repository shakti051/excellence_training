import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/providers/reminder_consultation_provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class ReminderConsultationDialouge extends StatefulWidget {
  const ReminderConsultationDialouge({Key? key}) : super(key: key);

  @override
  _ReminderConsultationState createState() => _ReminderConsultationState();
}

class _ReminderConsultationState extends State<ReminderConsultationDialouge> {
  final _customTime = TextEditingController();
  final List<ListItem> _dropdownItems = [
    ListItem(1, "Mins"),
    ListItem(2, "Hours"),
    ListItem(3, "Days"),
  ];

  List<DropdownMenuItem<ListItem>>? _dropdownMenuItems;
  ListItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems![0].value;
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

  @override
  Widget build(BuildContext context) {
    final _remindDuration = context.watch<ReminderConsultationProvider>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 425,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                      opacity: 0, child: Icon(Icons.clear, color: Colors.grey)),
                  Text("Edit Reminder ",
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
              SizedBox(height: 18),
              Divider(height: 2, color: AppColors.backBorder),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        // ignore: unnecessary_lambdas
                        onTap: () {
                          _remindDuration.selectOnTime();
                        },
                        child: Container(
                          width: 56,
                          height: 56,
                          padding: EdgeInsets.symmetric(
                              horizontal: PaddingSize.normal),
                          decoration: BoxDecoration(
                            color: _remindDuration.getOnTime
                                ? AppColors.orange
                                : null,
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SvgPicture.asset(SVGAsset.time,
                              height: 50,
                              color: _remindDuration.getOnTime
                                  ? Colors.white
                                  : AppColors.navyBlue),
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Text("On time",
                            style: TextStyle(
                                color: _remindDuration.getOnTime
                                    ? Colors.black87
                                    : Colors.grey,
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w400,
                                fontSize: FontSize.normal)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        // ignore: unnecessary_lambdas
                        onTap: () {
                          _remindDuration.selectFifteenMin();
                        },
                        child: Container(
                          width: 56,
                          height: 56,
                          padding: EdgeInsets.only(top: PaddingSize.middle),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
                            color: Provider.of<ReminderConsultationProvider>(
                                        context)
                                    .getFifteen
                                ? AppColors.orange
                                : AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text("15m",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _remindDuration.getFifteen
                                      ? Colors.white
                                      : AppColors.navyBlue,
                                  fontFamily: FontName.oswald,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize.extraLarge)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Text("15 min \nbefore",
                            style: TextStyle(
                                color: _remindDuration.getFifteen
                                    ? Colors.black87
                                    : Colors.grey,
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w400,
                                fontSize: FontSize.normal)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        // ignore: unnecessary_lambdas
                        onTap: () {
                          _remindDuration.selectOneHour();
                        },
                        child: Container(
                          width: 56,
                          height: 56,
                          padding: EdgeInsets.only(top: PaddingSize.middle),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
                            borderRadius: BorderRadius.circular(15),
                            color: _remindDuration.getOneHour
                                ? AppColors.orange
                                : AppColors.backgroundColor,
                          ),
                          child: Text("1h",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _remindDuration.getOneHour
                                      ? Colors.white
                                      : AppColors.navyBlue,
                                  fontFamily: FontName.oswald,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize.extraLarge)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Text("1 hour \nbefore",
                            style: TextStyle(
                                color: _remindDuration.getOneHour
                                    ? Colors.black87
                                    : Colors.grey,
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w400,
                                fontSize: FontSize.normal)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        // ignore: unnecessary_lambdas
                        onTap: () {
                          _remindDuration.selectOneDay();
                        },
                        child: Container(
                          width: 56,
                          height: 56,
                          padding: EdgeInsets.only(top: PaddingSize.middle),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
                            borderRadius: BorderRadius.circular(15),
                            color: _remindDuration.getOneDay
                                ? AppColors.orange
                                : null,
                          ),
                          child: Text("1d",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _remindDuration.getOneDay
                                      ? Colors.white
                                      : AppColors.navyBlue,
                                  fontFamily: FontName.oswald,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize.extraLarge)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Text("1 day \nbefore",
                            style: TextStyle(
                                color: _remindDuration.getOneDay
                                    ? Colors.black87
                                    : Colors.grey,
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w400,
                                fontSize: FontSize.normal)),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 26),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Custom time",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.normal)),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4, right: 16),
                    height: 38,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border:
                            Border.all(width: 1, color: AppColors.backBorder)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: _selectedItem,
                          items: _dropdownMenuItems,
                          onChanged: (ListItem? value) {
                            setState(() {
                              _selectedItem = value;
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 38,
                    width: 156,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      controller: _customTime,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter time here',
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.backBorder, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.orangeProfile),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                      onSaved: (text) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: AppColors.backBorder),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 4),
                          child: Text("Cancel",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.normal)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 26, width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: GradientButton(
                        height: 50,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Edit Reminder",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w400,
                                fontSize: FontSize.large)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
