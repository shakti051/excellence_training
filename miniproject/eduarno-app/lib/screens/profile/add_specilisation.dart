import 'package:eduarno/repo/bloc/assessment/model/topic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:eduarno/repo/bloc/assessment/filter_data.dart';
import 'package:eduarno/repo/utils/validator.dart';
import 'package:eduarno/widgets/bottom_sheet.dart';
import 'package:eduarno/widgets/custom_text_field.dart';
import 'package:eduarno/widgets/multi_select_drop_down.dart';
import 'package:eduarno/widgets/select_specialization_sheet.dart';
import '../../Utilities/constants.dart';

// class Specilisation extends StatefulWidget {
//   final bool isEdit;
//   final String specialisation;
//   List<String> topics;
//   Function(String, List<Map<String, dynamic>>) onAdded;

//   Specilisation(
//       {Key key, this.isEdit, this.topics, this.specialisation, this.onAdded})
//       : super(key: key);

//   @override
//   _SpecilisationState createState() => _SpecilisationState();
// }

// class _SpecilisationState extends State<Specilisation> {
//   final TextEditingController _addSpecilsation = TextEditingController();
//   final TextEditingController _addTopic = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   FToast fToast;

//   String specialization, topic;
//   List<Map<String, dynamic>> topicList = [];
//   List<Topic> topics = [];

//   @override
//   void initState() {
//     super.initState();
//     if (widget.isEdit) {
//       specialization = widget.specialisation;
//       _addSpecilsation.text = widget.specialisation;

//       widget.topics.forEach((topicName) {
//         var data = {'user_topic': topicName};
//         Topic topic = Topic(topic: topicName);
//         topicList.insert(0, data);
//         topics.add(topic);
//       });
//       setState(() {});
//     }
//     fToast = FToast();
//     fToast.init(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           backwardsCompatibility: true,
//           systemOverlayStyle:
//               SystemUiOverlayStyle(statusBarColor: Colors.white),
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             widget.isEdit ? "Edit specialisation" : "Add specialisation",
//             style: TextStyle(
//                 fontSize: 24.0,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: "Poppins",
//                 fontStyle: FontStyle.normal),
//           ),
//           leading: IconButton(
//             icon: SvgPicture.asset("assets/back.svg"),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             FutureBuilder(
// future: FilterBloc().specializations(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return Consumer<FilterBloc>(
//                     builder: (context, data, child) {
//                       _addSpecilsation.text = data.selectedSpecialization;
//                       return Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 25, right: 25, top: 0),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   FocusScopeNode currentFocus =
//                                       FocusScope.of(context);
//                                   if (!currentFocus.hasPrimaryFocus) {
//                                     currentFocus.unfocus();
//                                   }
//                                 },
//                                 child: CustomTextField(
//                                   isReadOnly: true,
//                                   label: "Specilisation",
//                                   titleColor: kIconColor,
//                                   hintColor: Colors.black54,
//                                   textColor: Colors.black,
//                                   title: "",
//                                   hint: 'Specilisation',
//                                   controller: _addSpecilsation,
//                                   validator: (value) =>
//                                       Validators.validateRequired(
//                                           value.trim(), 'Specilisation'),
//                                   onTap: () {
//                                     kShowOptions(
//                                         context,
//                                         SelectSpecializationBottomSheet(
//                                           title: "Specialisation",
//                                           options: Provider.of<FilterBloc>(
//                                                   context,
//                                                   listen: false)
//                                               .specializationList,
//                                           onSelected: (value, id) {
//                                             print(
//                                                 'Specialization value ======> $value');
//                                             Provider.of<FilterBloc>(context,
//                                                     listen: false)
//                                                 .selectedSpecialization = value;
//                                             Provider.of<FilterBloc>(context,
//                                                     listen: false)
//                                                 .selectedSpecializationId = id;
//                                             Provider.of<FilterBloc>(context,
//                                                         listen: false)
//                                                     .isSpecializationSelected =
//                                                 'loading';
//                                             specialization = value;
//                                             FilterBloc()
//                                                 .getTopics(id)
//                                                 .then((value) => {
//                                                       if (value)
//                                                         {
//                                                           Provider.of<FilterBloc>(
//                                                                   context,
//                                                                   listen: false)
//                                                               .isSpecializationSelected = 'true'
//                                                         }
//                                                     });
//                                             Navigator.pop(context);
//                                           },
//                                         ));
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return Column(
//                   children: [
//                     SizedBox(
//                         height: MediaQuery.of(context).size.height / 2 - 100),
//                     Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ],
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             Consumer<FilterBloc>(builder: (context, data, child) {
//               return data.isSpecializationSelected != 'false'
//                   ? data.isSpecializationSelected == 'loading'
//                       ? Center(child: CircularProgressIndicator())
//                       : Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: SelectMultiOption(
//                                 list: data.topicList,
//                                 onItemsSelected: (list) {
//                                   topicList = list;
//                                 },
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 25, right: 25, top: 32),
//                               child: InkWell(
//                                   onTap: () {
//                                     if (_formKey.currentState.validate()) {
//                                       print('topic list final $topicList');
//                                       if (topicList != null &&
//                                           topicList.isNotEmpty) {
//                                         widget.onAdded(
//                                             specialization, topicList);

//                                         Navigator.of(context).pop();
//                                       } else {
//                                         _showToast(
//                                             message: 'Please select a topic');
//                                       }
//                                     }
//                                   },
//                                   child: Container(
//                                     height: 56,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8),
//                                       color: Color(0xff41C36C),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         widget.isEdit ? "Update" : "Save",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 16,
//                                             fontFamily: "Poppins",
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   )),
//                             ),
//                           ],
//                         )
//                   : SizedBox();
//             }),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ));
//   }

//   _showToast({String message}) {
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25.0), color: Colors.redAccent),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             message,
//             style: TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );

//     fToast.showToast(
//       child: toast,
//       gravity: ToastGravity.BOTTOM,
//       toastDuration: Duration(seconds: 2),
//     );
//   }
// }

class Specialisation extends StatefulWidget {
  final String specialisation;
  final bool isEdit;
  List<String> topics;
  Function(String, List<Map<String, dynamic>>) onAdded;
  Specialisation(
      {Key key, this.isEdit, this.topics, this.specialisation, this.onAdded})
      : super(key: key);

  @override
  _SpecialisationState createState() => _SpecialisationState();
}

class _SpecialisationState extends State<Specialisation> {
  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   FilterBloc().specializations();
  // }

  final TextEditingController _addSpecilsation = TextEditingController();
  final TextEditingController _addTopic = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FToast fToast;

  String specialization, topic;
  List<Map<String, dynamic>> topicList = [];
  List<Topic> topics = [];

  void initState() {
    super.initState();
    FilterBloc().specializations();
    if (widget.isEdit) {
      specialization = widget.specialisation;
      _addSpecilsation.text = widget.specialisation;

      widget.topics.forEach((topicName) {
        var data = {'user_topic': topicName};
        Topic topic = Topic(topic: topicName);
        topicList.insert(0, data);
        topics.add(topic);
      });
      // setState(() {});
    }
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final filterSpecialisation = context.watch<FilterBloc>();
    _addSpecilsation.text = filterSpecialisation.selectedSpecialization;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        backwardsCompatibility: true,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              CupertinoIcons.back,
              color: kChatColor,
            )),
        title: Text(
          'Add specialisation',
          style: TextStyle(fontSize: 24),
        ),
        // backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // SizedBox(height: 27),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
                  child: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: CustomTextField(
                      isReadOnly: true,
                      label: 'Specilisation',
                      titleColor: kIconColor,
                      hintColor: Colors.black54,
                      textColor: Colors.black,
                      title: '',
                      hint: 'Specilisation',
                      controller: _addSpecilsation,
                      validator: (value) => Validators.validateRequired(
                          value.trim(), 'Specilisation'),
                      onTap: () {
                        kShowOptions(
                          context,
                          SelectSpecializationBottomSheet(
                            title: 'Specialisation',
                            options: filterSpecialisation.specializationList,
                            onSelected: (value, id) {
                              print('Specialization value ======> $value');
                              filterSpecialisation.selectedSpecialization =
                                  value;
                              filterSpecialisation.selectedSpecializationId =
                                  id;
                              filterSpecialisation.isSpecializationSelected =
                                  'loading';
                              specialization = value;
                              filterSpecialisation
                                  .getTopics(id)
                                  .then((value) => {
                                        if (value)
                                          {
                                            filterSpecialisation
                                                    .isSpecializationSelected =
                                                'true',
                                            filterSpecialisation
                                                .isSaveButtonActivate = false
                                          }
                                      });
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Consumer<FilterBloc>(builder: (context, data, child) {
          // final filterSpecialisation = context.watch<FilterBloc>();
          filterSpecialisation.isSpecializationSelected != 'false'
              ? filterSpecialisation.isSpecializationSelected == 'loading'
                  ? Center(
                      child: CircularProgressIndicator(
                      color: kPrimaryGreenColor,
                    ))
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectMultiOption(
                            list: filterSpecialisation.topicList,
                            onItemsSelected: (list) {
                              topicList = list;
                              filterSpecialisation.isSaveButtonActivate = true;
                              // if (list.isEmpty) {
                              //   topicList.clear();
                              //   filterSpecialisation.isSaveButtonActivate =
                              //       true;
                              // }
                              // else
                              // filterSpecialisation.isSaveButtonActivate =
                              //     true;
                            },
                          ),
                        ),
                        Consumer<FilterBloc>(builder: (context, data, child) {
                          final isSaved = context.watch<FilterBloc>();
                          return isSaved.isSaveButtonActivate
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, top: 32),
                                  child: InkWell(
                                      onTap: () {
                                        if (_formKey.currentState.validate()) {
                                          print('topic list final $topicList');
                                          if (topicList != null &&
                                              topicList.isNotEmpty) {
                                            widget.onAdded(
                                                specialization, topicList);
                                            Navigator.of(context).pop();
                                          } else {
                                            _showToast(
                                                message:
                                                    'Please select a topic');
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 56,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xff41C36C),
                                        ),
                                        child: Center(
                                          child: Text(
                                            widget.isEdit ? 'Update' : 'Save',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.white),
                                          ),
                                        ),
                                      )),
                                )
                              : SizedBox();
                        })
                      ],
                    )
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  _showToast({String message}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.redAccent),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
