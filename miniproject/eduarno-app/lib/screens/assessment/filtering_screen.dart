// import 'dart:ui';
// import 'package:eduarno/constants.dart';
// import 'package:eduarno/repo/bloc/assessment/filter_data.dart';
// import 'package:eduarno/repo/bloc/profile/interest_detail_data.dart';
// import 'package:eduarno/repo/bloc/user.dart';
// import 'package:eduarno/screens/assessment/assesment_listing.dart';
// import 'package:eduarno/widgets/bottom_sheet.dart';
// import 'package:eduarno/widgets/custom_text_field.dart';
// import 'package:eduarno/widgets/multi_select_drop_down.dart';
// import 'package:eduarno/widgets/select_specialization_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class Filtering extends StatefulWidget {
//   const Filtering({Key key}) : super(key: key);

//   @override
//   _FilteringState createState() => _FilteringState();
// }

// class _FilteringState extends State<Filtering> {
//   final TextEditingController _specializationController =
//       TextEditingController();

//   String specialization, topic;
//   List<Map<String, dynamic>> topicList;

//   @override
//   void initState() {
//     super.initState();
//     FilterBloc().specializations();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kLightGray,
//       appBar: AppBar(
//         brightness: Brightness.light,
//         backgroundColor: kLightGray,
//         backwardsCompatibility: false,
//         systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: kLightGray),
//         elevation: 0,
//         title: Text(
//           "Filter",
//           style: TextStyle(fontSize: 16.0, color: Colors.black),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//             icon: Icon(Icons.keyboard_backspace, color: Colors.black),
//             onPressed: () => {
//                   // Navigator.pushReplacement(
//                   //     context, MaterialPageRoute(builder: (_) => Quiz())),
//                 }),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             FutureBuilder(
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return Consumer<FilterBloc>(
//                         builder: (context, data, child) {
//                       _specializationController.text =
//                           data.selectedSpecialization;
//                       return CustomTextField(
//                         // isRequired: false,
//                         isReadOnly: true,
//                         label: 'Specialisation',
//                         title: 'Specialisation',
//                         hint: 'Science',
//                         titleColor: Colors.black,
//                         maxLine: 1,
//                         controller: _specializationController,
//                         onTap: () {
//                           kShowOptions(
//                               context,
//                               SelectSpecializationBottomSheet(
//                                 title: "Specialisation",
//                                 options: Provider.of<FilterBloc>(context,
//                                         listen: false)
//                                     .specializationList,
//                                 onSelected: (value, id) {
//                                   //   print('Specialization value ======> $value');
//                                   Provider.of<FilterBloc>(context,
//                                           listen: false)
//                                       .selectedSpecialization = value;
//                                   Provider.of<FilterBloc>(context,
//                                           listen: false)
//                                       .selectedSpecializationId = id;
//                                   Provider.of<FilterBloc>(context,
//                                           listen: false)
//                                       .isSpecializationSelected = 'loading';
//                                   FilterBloc().getTopics(id).then((value) => {
//                                         if (value)
//                                           {
//                                             Provider.of<FilterBloc>(context,
//                                                         listen: false)
//                                                     .isSpecializationSelected =
//                                                 'true'
//                                           }
//                                       });
//                                   Navigator.pop(context);
//                                 },
//                               ));
//                         },
//                       );
//                     });
//                   }
//                   return CircularProgressIndicator();
//                 }),
//             SizedBox(
//               height: 20,
//             ),
//             Consumer<FilterBloc>(builder: (context, data, child) {
//               return data.isSpecializationSelected != 'false'
//                   ? data.isSpecializationSelected == 'loading'
//                       ? CircularProgressIndicator()
//                       : SelectMultiOption(
//                           list: data.topicList,
//                           onItemsSelected: (list) {
//                             topicList = list;
//                           },
//                         )
//                   : SizedBox();
//             }),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width - 32,
//                   height: MediaQuery.of(context).size.height * 0.06,
//                   child: ElevatedButton(
//                       onPressed: () {
//                         InterestProvider()
//                             .setInterestDetail(
//                                 User().userId,
//                                 Provider.of<FilterBloc>(context, listen: false)
//                                     .selectedSpecialization,
//                                 topicList)
//                             .then((value) => {
//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) => AssessmentListing()))
//                                 });
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: Color(0xff2C34DB),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12), // <-- Radius
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 10),
//                         child: Text(
//                           "Apply",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700),
//                         ),
//                       )),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
