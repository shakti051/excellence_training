import 'dart:math';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/assessment/filter_data.dart';
import 'package:eduarno/repo/bloc/profile/academic_experience_api/academic_data.dart';
import 'package:eduarno/repo/bloc/profile/model/experience_model.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/repo/utils/validator.dart';
import 'package:eduarno/widgets/custom_button.dart';
import 'package:eduarno/widgets/custom_text_field.dart';
import 'package:eduarno/widgets/select_specialization_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'bottom_sheet.dart';

class AddExperienceDetails extends StatefulWidget {
  final bool isUpdate;
  final Experience options;
  final void Function() onSelected;

  const AddExperienceDetails(
      {Key key, this.onSelected, this.options, this.isUpdate})
      : super(key: key);

  @override
  _AddExperienceDetailsState createState() => _AddExperienceDetailsState();
}

class _AddExperienceDetailsState extends State<AddExperienceDetails> {
  ExperienceDetailGetResponse _data;
  final TextEditingController _expInstituteController = TextEditingController();
  final TextEditingController _expSubjectController = TextEditingController();
  final TextEditingController _expFromMonthController = TextEditingController();
  final TextEditingController _expFromYearController = TextEditingController();
  final TextEditingController _expToMonthController = TextEditingController();
  final TextEditingController _expToYearController = TextEditingController();
  final GlobalKey<FormState> _formExpKey = GlobalKey<FormState>();
  bool isHere = false;
  //bool isUpdate = false;
  bool _isLoading = false;
  String indexId;
  var random = new Random();

  @override
  void initState() {
    super.initState();
    FilterBloc().specializations();
    if (widget.isUpdate) {
      _expInstituteController.text = widget.options.institutionName;
      _expSubjectController.text = widget.options.subject;
      _expFromMonthController.text = widget.options.fromMonth;
      _expFromYearController.text = widget.options.fromYear;
      _expToMonthController.text = widget.options.toMonth;
      _expToYearController.text = widget.options.toYear;
      isHere = widget.options.isCurrentlyHere;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: true,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 0,
        title: Text(
          "${widget.isUpdate ? "Edit" : "Add"} experience info",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 24.0,
            //  color: Colors.black, fontWeight: FontWeight.w600
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset("assets/back.svg"),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formExpKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      titleColor: kIconColor,
                      textColor: Colors.black,
                      hintColor: Colors.black54,
                      title: "",
                      label: 'Institution details',
                      hint: 'Institution details',
                      controller: _expInstituteController,
                      validator: (value) =>
                          Validators.validateName(value, 'Institution'),
                    ),
                    // CustomTextField(
                    //   titleColor: kIconColor,
                    //   textColor: Colors.black,
                    //   hintColor: Colors.black54,
                    //   title: "",
                    //   hint: 'Subject',
                    //   label: 'Subject',
                    //   controller: _expSubjectController,
                    //   validator: (value) =>
                    //       Validators.validateName(value, 'subject'),
                    // ),
                    Consumer<FilterBloc>(builder: (context, data, child) {
                      return CustomTextField(
                        isRequired: true,
                        titleColor: kIconColor,
                        textColor: Colors.black,
                        hintColor: Colors.black54,
                        title: "",
                        hint: 'Specialisation',
                        label: 'Specialisation',
                        controller: _expSubjectController,
                        validator: (value) => Validators.validateRequired(
                            value, "Specialisation"),
                        onTap: () {
                          kShowOptions(
                              context,
                              SelectSpecializationBottomSheet(
                                title: "Specialisation",
                                options: Provider.of<FilterBloc>(context,
                                        listen: false)
                                    .specializationList,
                                onSelected: (value, id) {
                                  Provider.of<FilterBloc>(context,
                                          listen: false)
                                      .selectedSpecialization = value;
                                  _expSubjectController.text = value;
                                  Navigator.pop(context);
                                },
                              ));
                        },
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Text(
                        'From',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Poppins",
                            color: kIconColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: new TextFormField(
                              readOnly: true,
                              style: TextStyle(color: kTitleColor),
                              controller: _expFromMonthController,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffF6F7FA),
                                  ),
                                ),
                                fillColor: AppColors.neutralGray,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: true,
                                labelText: "Month",
                                labelStyle: TextStyle(color: Color(0xff9D9FA0)),
                                hintText: 'Month',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                ),
                                suffixIcon: Icon(
                                  Icons.expand_more,
                                  color: Color(0xff41C36C),
                                ),
                              ),
                              validator: (value) =>
                                  Validators.validateRequired(value, "Month"),
                              onTap: () {
                                kShowOptions(
                                    context,
                                    SelectOptionBottomSheet(
                                      options: months,
                                      title: 'Month',
                                      onSelected: (value) {
                                        setState(() {
                                          _expFromMonthController.text = value;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ));
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: new TextFormField(
                              readOnly: true,
                              enabled: true,
                              validator: (value) =>
                                  Validators.validateRequired(value, "Year"),
                              controller: _expFromYearController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffF6F7FA),
                                  ),
                                ),
                                fillColor: AppColors.neutralGray,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: true,
                                labelText: "Year",
                                labelStyle: TextStyle(color: Color(0xff9D9FA0)),
                                hintText: '',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                ),
                                suffixIcon: Icon(
                                  Icons.expand_more,
                                  color: Color(0xff41C36C),
                                ),
                              ),
                              onTap: () {
                                kShowOptions(
                                    context,
                                    SelectOptionBottomSheet(
                                      options: year,
                                      title: 'Year',
                                      onSelected: (value) {
                                        setState(() {
                                          _expFromYearController.text = value;
                                        });
                                        print('$value');
                                        Navigator.of(context).pop();
                                      },
                                    ));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, right: 10, left: 4),
                          child: SizedBox(
                            height: 12.0,
                            width: 12.0,
                            child: Checkbox(
                              activeColor: Colors.green,
                              // disabledColor: Colors.grey,
                              value: isHere,
                              onChanged: (bool x) {
                                setState(() {
                                  isHere = x;
                                  if (x) {
                                    _expToMonthController.text = '';
                                    _expToYearController.text = '';
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "Currently working here.",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Visibility(
                      visible: !isHere,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To',
                            style: TextStyle(
                                color: isHere
                                    ? Color(0xff303030)
                                    : Color(0xff303030),
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: new TextFormField(
                                    readOnly: true,
                                    style: TextStyle(color: kTitleColor),
                                    controller: _expToMonthController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        //  borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Color(0xffF6F7FA),
                                        ),
                                      ),
                                      fillColor: Color(0xffF6F7FA),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      // errorBorder: InputBorder.none,
                                      // enabled: true,
                                      // disabledBorder: InputBorder.none,
                                      filled: true,
                                      labelText: "Month",
                                      labelStyle:
                                          TextStyle(color: Color(0xff9D9FA0)),
                                      hintText: '',
                                      hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.expand_more,
                                        color: Color(0xff41C36C),
                                      ),
                                    ),
                                    validator: (value) =>
                                        Validators.validateRequired(
                                            value, "Month"),
                                    onTap: () {
                                      kShowOptions(
                                          context,
                                          SelectOptionBottomSheet(
                                            options: months,
                                            title: 'Month',
                                            onSelected: (value) {
                                              setState(() {
                                                _expToMonthController.text =
                                                    value;
                                              });
                                              print('$value');
                                              Navigator.of(context).pop();
                                            },
                                          ));
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: new TextFormField(
                                    validator: (value) =>
                                        Validators.validateRequired(
                                            value, "Year"),
                                    readOnly: true,
                                    controller: _expToYearController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xffF6F7FA),
                                        ),
                                      ),
                                      fillColor: Color(0xffF6F7FA),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      // errorBorder: InputBorder.none,
                                      // enabled: true,
                                      // disabledBorder: InputBorder.none,
                                      filled: true,
                                      labelText: "Year",
                                      labelStyle:
                                          TextStyle(color: Color(0xff9D9FA0)),
                                      hintText: '',
                                      hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.expand_more,
                                        color: Color(0xff41C36C),
                                      ),
                                    ),
                                    onTap: () {
                                      kShowOptions(
                                          context,
                                          SelectOptionBottomSheet(
                                            options: year,
                                            title: 'Year',
                                            onSelected: (value) {
                                              setState(() {
                                                _expToYearController.text =
                                                    value;
                                              });
                                              print('$value');
                                              Navigator.of(context).pop();
                                            },
                                          ));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Button(
                      isLoading: _isLoading,
                      formKey: _formExpKey,
                      bgColor: Color(0xff41C36C),
                      textColor: Colors.white,
                      title: widget.isUpdate ? 'Update' : 'Save',
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        if (_formExpKey.currentState.validate()) {
                          AcademicProvide _service = AcademicProvide();

                          final ExperienceDetailGetResponse data =
                              await _service.postExperienceData(
                            isUpdate: widget.isUpdate,
                            id: User().userId,
                            institutionName:
                                _expInstituteController.text.trim(),
                            subject: _expSubjectController.text.trim(),
                            fromMonth: _expFromMonthController.text.trim(),
                            fromYear: _expFromYearController.text.trim(),
                            toMonth: _expToMonthController.text.trim(),
                            toYear: _expFromYearController.text.trim(),
                            isCurrentlyHere: isHere,
                          );
                          FocusScope.of(context).unfocus();
                          setState(() {
                            _isLoading = false;
                            _data = data;
                            Navigator.pop(context);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
