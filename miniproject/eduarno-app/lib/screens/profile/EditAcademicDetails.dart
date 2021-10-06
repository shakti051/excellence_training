// import 'dart:math';
// import 'package:eduarno/constants.dart';
// import 'package:eduarno/repo/bloc/assessment/filter_data.dart';
// import 'package:eduarno/repo/bloc/profile/academic_experience_api/academic_data.dart';
// import 'package:eduarno/repo/bloc/profile/model/academic_model.dart';
// import 'package:eduarno/repo/bloc/user.dart';
// import 'package:eduarno/repo/utils/validator.dart';
// import 'package:eduarno/widgets/custom_button.dart';
// import 'package:eduarno/widgets/custom_text_field.dart';
// import 'package:eduarno/widgets/select_specialization_sheet.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// import 'bottom_sheet.dart';

// class EditAcademicDetails extends StatefulWidget {
//   final bool isUpdate;
//   final Academic options;
//   final void Function() onSelected;

//   const EditAcademicDetails(
//       {Key key, this.onSelected, this.options, this.isUpdate})
//       : super(key: key);

//   @override
//   _EditAcademicDetails createState() => _EditAcademicDetails();
// }

// class _EditAcademicDetails extends State<EditAcademicDetails> {
//   AcademicDetailResponse _data;

//   final TextEditingController _eduInstituteController = TextEditingController();
//   final TextEditingController _eduDegreeController = TextEditingController();
//   final TextEditingController _eduSpecializationController =
//       TextEditingController();
//   final TextEditingController _eduFromMonthController = TextEditingController();
//   final TextEditingController _eduFromYearController = TextEditingController();
//   final TextEditingController _eduToMonthController = TextEditingController();
//   final TextEditingController _eduToYearController = TextEditingController();
//   final TextEditingController _academicAwardsController =
//       TextEditingController();
//   final TextEditingController _bioController = TextEditingController();
//   final GlobalKey<FormState> _formEduKey = GlobalKey<FormState>();
//   bool isHere = false;
//   bool _isLoading = false;
//   String indexId;
//   var random = new Random();
//   bool _autovalidate = false;

//   @override
//   void initState() {
//     super.initState();
//     FilterBloc().specializations();

//     if (widget.isUpdate) {
//       _eduInstituteController.text = widget.options.institutionName;
//       _eduDegreeController.text = widget.options.degree;
//       _eduSpecializationController.text = widget.options.specialisation;
//       _eduFromMonthController.text = widget.options.fromMonth;
//       _eduFromYearController.text = widget.options.fromYear;
//       _eduToMonthController.text = widget.options.toMonth;
//       _eduToYearController.text = widget.options.toYear;
//       isHere = widget.options.isCurrentlyHere;
//       _academicAwardsController.text = widget.options.academicRecord;
//       _bioController.text = widget.options.bio;
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         backwardsCompatibility: true,
//         systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
//         elevation: 0,
//         title: Text(
//           "${widget.isUpdate ? "Edit" : "Add"} academic info",
//           overflow: TextOverflow.visible,
//           style: TextStyle(
//               fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//         // centerTitle: true,
//         leading: IconButton(
//           icon: SvgPicture.asset("assets/back.svg"),
//           onPressed: () => {Navigator.pop(context)},
//         ),
//       ),
//       body: Container(
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Form(
//               key: _formEduKey,
//               //autovalidateMode: AutovalidateMode.onUserInteraction,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomTextField(
//                       isRequired: true,
//                       titleColor: kIconColor,
//                       textColor: Colors.black,
//                       hintColor: Colors.black54,
//                       title: "",
//                       label: "Institution details",
//                       hint: 'Institution details',
//                       controller: _eduInstituteController,
//                       validator: (value) =>
//                           Validators.validateName(value.trim(), 'Institution'),
//                     ),
//                     CustomTextField(
//                       isRequired: true,
//                       titleColor: kIconColor,
//                       textColor: Colors.black,
//                       hintColor: Colors.black54,
//                       label: "Degree",
//                       title: "",
//                       hint: 'Degree',
//                       controller: _eduDegreeController,
//                       validator: (value) =>
//                           Validators.validateName(value.trim(), 'Degree'),
//                     ),
//                     Consumer<FilterBloc>(builder: (context, data, child) {
//                       return CustomTextField(
//                         isRequired: true,
//                         titleColor: kIconColor,
//                         textColor: Colors.black,
//                         hintColor: Colors.black54,
//                         title: "",
//                         hint: 'Specialisation',
//                         label: 'Specialisation',
//                         controller: _eduSpecializationController,
//                         onTap: () {
//                           kShowOptions(
//                               context,
//                               SelectSpecializationBottomSheet(
//                                 title: "Specialisation",
//                                 options: Provider.of<FilterBloc>(context,
//                                         listen: false)
//                                     .specializationList,
//                                 onSelected: (value, id) {
//                                   print('Specialisation value ======> $value');
//                                   Provider.of<FilterBloc>(context,
//                                           listen: false)
//                                       .selectedSpecialization = value;
//                                   // Provider.of<FilterBloc>(context,
//                                   //         listen: false)
//                                   //     .selectedSpecializationId = id;
//                                   // Provider.of<FilterBloc>(context,
//                                   //             listen: false)
//                                   //         .isSpecializationSelected =
//                                   //     'loading';
//                                   //specialization = value;
//                                   // FilterBloc()
//                                   //     .getTopics(id)
//                                   //     .then((value) => {
//                                   //           if (value)
//                                   //             {
//                                   //               Provider.of<FilterBloc>(
//                                   //                           context,
//                                   //                           listen: false)
//                                   //                       .isSpecializationSelected =
//                                   //                   'true'
//                                   //             }
//                                   //         });
//                                   Navigator.pop(context);
//                                 },
//                               ));
//                         },
//                       );
//                     }),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 18),
//                       child: Text(
//                         'From',
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: "Poppins",
//                             color: kIconColor,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 8),
//                             child: new TextFormField(
//                               readOnly: true,
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               style: TextStyle(color: kTitleColor),
//                               controller: _eduFromMonthController,
//                               decoration: InputDecoration(
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide:
//                                       BorderSide(color: Colors.red, width: 0),
//                                 ),
//                                 border: InputBorder.none,
//                                 fillColor: Color(0xffF6F7FA),
//                                 enabledBorder: InputBorder.none,
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide:
//                                       BorderSide(color: Colors.green, width: 1),
//                                 ),
//                                 filled: true,
//                                 labelText: "Month",
//                                 labelStyle: TextStyle(color: Color(0xff9D9FA0)),
//                                 hintText: '',
//                                 hintStyle: TextStyle(
//                                   color: Colors.black54,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                                 suffixIcon: Icon(
//                                   Icons.expand_more,
//                                   color: Color(0xff41C36C),
//                                 ),
//                               ),
//                               onTap: () {
//                                 kShowOptions(
//                                     context,
//                                     SelectOptionBottomSheet(
//                                       options: months,
//                                       title: 'Month',
//                                       onSelected: (value) {
//                                         setState(() {
//                                           _eduFromMonthController.text = value;
//                                         });
//                                         print('$value');
//                                         Navigator.of(context).pop();
//                                       },
//                                     ));
//                               },
//                               validator: (value) =>
//                                   Validators.validateRequired(value, "Month"),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 8),
//                             child: new TextFormField(
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               readOnly: true,
//                               controller: _eduFromYearController,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 fillColor: Color(0xffF6F7FA),
//                                 enabledBorder: InputBorder.none,
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide:
//                                       BorderSide(color: Colors.red, width: 0),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide:
//                                       BorderSide(color: Colors.green, width: 1),
//                                 ),
//                                 filled: true,
//                                 labelText: "Year",
//                                 labelStyle: TextStyle(color: Color(0xff9D9FA0)),
//                                 hintText: '',
//                                 hintStyle: TextStyle(
//                                   color: Colors.black54,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                                 suffixIcon: Icon(
//                                   Icons.expand_more,
//                                   color: Color(0xff41C36C),
//                                 ),
//                               ),
//                               onTap: () {
//                                 kShowOptions(
//                                   context,
//                                   SelectOptionBottomSheet(
//                                     options: year,
//                                     title: 'Year',
//                                     onSelected: (value) {
//                                       setState(() {
//                                         _eduFromYearController.text = value;
//                                       });
//                                       print('$value');
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 );
//                               },
//                               validator: (value) =>
//                                   Validators.validateRequired(value, "Year"),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 10.0, bottom: 10, right: 10, left: 4),
//                           child: SizedBox(
//                             height: 12.0,
//                             width: 12.0,
//                             child: Checkbox(
//                               activeColor: Colors.green,
//                               // disabledColor: Colors.grey,
//                               value: isHere,
//                               onChanged: (bool x) {
//                                 setState(() {
//                                   isHere = x;
//                                   if (x) {
//                                     _eduToMonthController.text = '';
//                                     _eduToYearController.text = '';
//                                   }
//                                 });
//                               },
//                               materialTapTargetSize:
//                                   MaterialTapTargetSize.shrinkWrap,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 4),
//                           child: Text(
//                             "Currently working here.",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: "Poppins"),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Visibility(
//                       visible: !isHere,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'To',
//                             style: TextStyle(
//                                 color: isHere
//                                     ? Color(0xff303030)
//                                     : Color(0xff303030),
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16),
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 8),
//                                   child: new TextFormField(
//                                     readOnly: true,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     style: TextStyle(color: kTitleColor),
//                                     controller: _eduToMonthController,
//                                     decoration: InputDecoration(
//                                       errorBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                         borderSide: BorderSide(
//                                             color: Colors.red, width: 0),
//                                       ),
//                                       border: InputBorder.none,
//                                       fillColor: Color(0xffF6F7FA),
//                                       enabledBorder: InputBorder.none,
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                         borderSide: BorderSide(
//                                             color: Colors.green, width: 1),
//                                       ),
//                                       filled: true,
//                                       labelText: "Month",
//                                       labelStyle:
//                                           TextStyle(color: Color(0xff9D9FA0)),
//                                       hintText: '',
//                                       hintStyle: TextStyle(
//                                         color: Colors.black54,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                       suffixIcon: Icon(
//                                         Icons.expand_more,
//                                         color: Color(0xff41C36C),
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       kShowOptions(
//                                         context,
//                                         SelectOptionBottomSheet(
//                                           options: months,
//                                           title: 'Month',
//                                           onSelected: (value) {
//                                             setState(() {
//                                               _eduToMonthController.text =
//                                                   value;
//                                             });
//                                             print('$value');
//                                             Navigator.of(context).pop();
//                                           },
//                                         ),
//                                       );
//                                     },
//                                     validator: (value) =>
//                                         Validators.validateRequired(
//                                             value, "Month"),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 8),
//                                   child: new TextFormField(
//                                     readOnly: true,
//                                     controller: _eduToYearController,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     style: TextStyle(color: kTitleColor),
//                                     decoration: InputDecoration(
//                                       errorBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                         borderSide: BorderSide(
//                                             color: Colors.red, width: 0),
//                                       ),
//                                       border: InputBorder.none,
//                                       fillColor: Color(0xffF6F7FA),
//                                       enabledBorder: InputBorder.none,
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                         borderSide: BorderSide(
//                                             color: Colors.green, width: 1),
//                                       ),
//                                       filled: true,
//                                       labelText: "Month",
//                                       labelStyle:
//                                           TextStyle(color: Color(0xff9D9FA0)),
//                                       hintText: '',
//                                       hintStyle: TextStyle(
//                                         color: Colors.black54,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                       suffixIcon: Icon(
//                                         Icons.expand_more,
//                                         color: Color(0xff41C36C),
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       kShowOptions(
//                                           context,
//                                           SelectOptionBottomSheet(
//                                             options: year,
//                                             title: 'Year',
//                                             onSelected: (value) {
//                                               setState(() {
//                                                 _eduToYearController.text =
//                                                     value;
//                                               });
//                                               print('$value');
//                                               Navigator.of(context).pop();
//                                             },
//                                           ));
//                                     },
//                                     validator: (value) =>
//                                         Validators.validateRequired(
//                                             value, "Year"),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     CustomTextField(
//                       titleColor: kIconColor,
//                       textColor: Colors.black,
//                       hintColor: Colors.black54,
//                       title: "",
//                       hint: "Academic records",
//                       label: "Academic records",
//                       inputFormatter: [
//                         FilteringTextInputFormatter.allow(
//                             RegExp('[a-zA-Z0-9 ]')),
//                       ],
//                       controller: _academicAwardsController,
//                     ),
//                     CustomTextField(
//                       titleColor: kIconColor,
//                       textColor: Colors.black,
//                       hintColor: Colors.black54,
//                       title: "",
//                       label: "Summary",
//                       hint: "Summary",
//                       inputFormatter: [
//                         FilteringTextInputFormatter.allow(
//                             RegExp('[a-zA-Z0-9 ]')),
//                       ],
//                       controller: _bioController,
//                       maxLine: 8,
//                       minLine: 2,
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Button(
//                       isLoading: _isLoading,
//                       formKey: _formEduKey,
//                       bgColor: Color(0xff41C36C),
//                       textColor: Colors.white,
//                       title: widget.isUpdate ? 'Update' : 'Save',
//                       onTap: () async {
//                         setState(() {
//                           _isLoading = true;
//                         });
//                         if (_formEduKey.currentState.validate()) {
//                           AcademicProvide _service = AcademicProvide();
//                           // _service.setAcademicData = {
//                           //   'institutionName':
//                           //       _eduInstituteController.text.trim(),
//                           //   'degree': _eduDegreeController.text.trim(),
//                           //   'specialisation':
//                           //       _eduSpecializationController.text.trim(),
//                           //   'fromMonth': _eduFromMonthController.text.trim(),
//                           //   'fromYear': _eduFromYearController.text.trim(),
//                           //   'toMonth': _eduToMonthController.text.trim(),
//                           //   'toYear': _eduToYearController.text.trim(),
//                           //   'isCurrentlyHere': isHere,
//                           //   'academicRecord':
//                           //       _academicAwardsController.text.trim(),
//                           //   'bio': _bioController.text.trim(),
//                           // };
//                           final AcademicDetailResponse data =
//                               await _service.postAcademicData(
//                             id: User().userId,
//                             institutionName:
//                                 _eduInstituteController.text.trim(),
//                             degree: _eduDegreeController.text.trim(),
//                             specialisation:
//                                 _eduSpecializationController.text.trim(),
//                             fromMonth: _eduFromMonthController.text.trim(),
//                             fromYear: _eduFromYearController.text.trim(),
//                             toMonth: _eduToMonthController.text.trim(),
//                             toYear: _eduToYearController.text.trim(),
//                             isCurrentlyHere: isHere,
//                             academicRecord:
//                                 _academicAwardsController.text.trim(),
//                             bio: _bioController.text.trim(),
//                           );
//                           //FocusScope.of(context).unfocus();
//                           setState(() {
//                             _isLoading = false;
//                             _data = data;
//                             Navigator.pop(context);
//                           });
//                           print(_data);
//                         }
//                       },
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
