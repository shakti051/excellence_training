// import 'package:eduarno/constants.dart';
// import 'package:eduarno/repo/bloc/assessment/filter_data.dart';
// import 'package:eduarno/widgets/bottom_sheet.dart';
// import 'package:eduarno/widgets/custom_text_field.dart';
// import 'package:eduarno/widgets/multi_select_drop_down.dart';
// import 'package:eduarno/widgets/select_specialization_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AddInterestSheet extends StatefulWidget {
//   Function(String, List<Map<String, dynamic>>) onAdded;

//   AddInterestSheet({Key key, @required this.onAdded}) : super(key: key);

//   @override
//   _AddInterestSheetState createState() => _AddInterestSheetState();
// }

// class _AddInterestSheetState extends State<AddInterestSheet> {
//   final TextEditingController _specializationController =
//       TextEditingController();

//   String specialization, topic;
//   List<Map<String, dynamic>> topicList;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints:
//           BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.50),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               'Select Interest',
//               style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             FutureBuilder(
//               future: FilterBloc().specializations(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(child: Text('No data'));
//                 }
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return Consumer<FilterBloc>(builder: (context, data, child) {
//                     _specializationController.text =
//                         data.selectedSpecialization;
//                     return CustomTextField(
//                       // isRequired: false,
//                       isReadOnly: true,
//                       label: 'Specialisation',
//                       title: 'Specialisation',
//                       hint: 'Science',
//                       titleColor: kIconColor,
//                       textColor: Colors.black,
//                       maxLine: 1,
//                       controller: _specializationController,
//                       onTap: () {
//                         kShowOptions(
//                             context,
//                             SelectSpecializationBottomSheet(
//                               title: "Specialisation",
//                               options: Provider.of<FilterBloc>(context,
//                                       listen: false)
//                                   .specializationList,
//                               onSelected: (value, id) {
//                                 print('Specialisation value ======> $value');
//                                 Provider.of<FilterBloc>(context, listen: false)
//                                     .selectedSpecialization = value;
//                                 Provider.of<FilterBloc>(context, listen: false)
//                                     .selectedSpecializationId = id;
//                                 Provider.of<FilterBloc>(context, listen: false)
//                                     .isSpecializationSelected = 'loading';
//                                 specialization = value;
//                                 FilterBloc().getTopics(id).then((value) => {
//                                       if (value)
//                                         {
//                                           Provider.of<FilterBloc>(context,
//                                                   listen: false)
//                                               .isSpecializationSelected = 'true'
//                                         }
//                                     });
//                                 Navigator.pop(context);
//                               },
//                             ));
//                       },
//                     );
//                   });
//                 }
//                 return Center(child: CircularProgressIndicator());
//               },
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Consumer<FilterBloc>(builder: (context, data, child) {
//               return data.isSpecializationSelected != 'false'
//                   ? data.isSpecializationSelected == 'loading'
//                       ? Center(child: CircularProgressIndicator())
//                       : SelectMultiOption(
//                           list: data.topicList,
//                           onItemsSelected: (list) {
//                             if (list.isEmpty) {
//                               topicList.clear();
//                             } else
//                               topicList = list;
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
//                         widget.onAdded(specialization, topicList);
//                         Navigator.of(context).pop();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: kBlueColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12), // <-- Radius
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 10),
//                         child: Text(
//                           "Add",
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
