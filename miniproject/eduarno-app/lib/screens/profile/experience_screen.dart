import 'dart:math';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/profile/academic_experience_api/academic_data.dart';
import 'package:eduarno/repo/bloc/profile/model/experience_model.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/widgets/add_experience_sheet.dart';
import 'package:eduarno/widgets/bottom_sheet.dart';
import 'package:eduarno/widgets/no_data_screen.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({Key key}) : super(key: key);

  @override
  _ExperienceScreenState createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  bool isLoading = false;
  var random = new Random();
  //List<Experience> experienceDetailList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (
                context,
              ) =>
                      AddExperienceDetails(
                        isUpdate: false,
                      )));
        },
        child: Container(
          height: 44,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xff41C36C),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              Text(
                "Add new",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: true,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 0,
        title: Text(
          "Experience information",
          style: TextStyle(
            fontSize: 24.0,
            // color: Colors.black,
            // fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset("assets/back.svg"),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: FutureBuilder(
          future: AcademicProvide()
              .getExperienceData(Provider.of<User>(context).userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // if (experienceDetailList.isEmpty)
              if (Provider.of<AcademicProvide>(context)
                  .experience_detail_List
                  .isEmpty) {
                return MyNoData();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: getExperienceList(//experienceDetailList
                          Provider.of<AcademicProvide>(context)
                              .experience_detail_List),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
            return MyShimmer();
          }),
    );
  }

  Widget getExperienceList(List<Experience> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return getListWidget(list[index]);
      },
    );
  }

  Future<Null> _showDeleteDialog({@required Experience data}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sure, you want to delete this?",
                      style: TextStyle(
                          color: Color(0xff303030),
                          fontWeight: FontWeight.w700),
                    ),
                    // SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 110,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                Navigator.pop(context);
                                Provider.of<AcademicProvide>(context,
                                        listen: false)
                                    .experience_detail_List
                                    .remove(data);
                                //experienceDetailList.remove(data);
                                AcademicProvide()
                                    .deleteExperienceData(
                                        id: User().userId,
                                        institutionName: data.institutionName,
                                        subject: data.subject,
                                        fromMonth: data.fromMonth,
                                        toMonth: data.toMonth,
                                        fromYear: data.fromYear,
                                        toYear: data.toYear,
                                        isCurrentlyHere: data.isCurrentlyHere)
                                    .then((value) => {setState(() {})});
                              },
                              child: Text("Confirm"),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff41C36C)),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Abort"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget getListWidget(Experience data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: kNeutralGray,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xffEEEEEE), width: 2))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${data.subject}',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryGreenColor),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              kShowOptions(
                                  context,
                                  SelectOptionBottomSheet(
                                    title: 'Action',
                                    options: [/*'Edit',*/ 'Delete'],
                                    onSelected: (option) {
                                      // if (option.toLowerCase() ==
                                      //     'Edit'.toLowerCase()) {
                                      //   Navigator.of(context).pop();

                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (
                                      //         context,
                                      //       ) =>
                                      //           AddExperienceDetails(
                                      //         options: data,
                                      //         isUpdate: true,
                                      //         onSelected: () {
                                      //           setState(() {});
                                      //         },
                                      //       ),
                                      //     ),
                                      //   );
                                      // }
                                      if (option.toLowerCase() ==
                                          "Delete".toLowerCase()) {
                                        Navigator.of(context).pop();
                                        _showDeleteDialog(data: data);
                                      }
                                    },
                                  ));
                            },
                            child: Icon(Icons.more_vert, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data.institutionName,
                        // '${data['degree']} with ${data['specialization']}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                data.isCurrentlyHere
                    ? '${data.fromMonth} ${data.fromYear} - Present'
                    : '${data.fromMonth} ${data.fromYear} - ${data.toMonth} ${data.toYear}',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// {
//   // List<Map<String, dynamic>> eduList = [];
//   // List<Map<String, dynamic>> expList = [];
//   bool isLoading = false;
//   var random = new Random();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         backwardsCompatibility: true,
//         systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
//         elevation: 0,
//         title: Text(
//           "Experience Details",
//           style: TextStyle(
//               fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w700),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.keyboard_backspace, color: Colors.black),
//           onPressed: () => {
//             Navigator.pop(context),
//           },
//         ),
//       ),
//       body: FutureBuilder(
//           future: AcademicProvide()
//               .getExperienceData(Provider.of<User>(context).userId),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return MyNoData();
//             }
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (Provider.of<AcademicProvider>(context).expList.isEmpty) {
//                 return MyNoData();
//               }
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                         child: getExperienceList(
//                             Provider.of<AcademicProvide>(context)
//                                 .experience_detail_List)),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return MyShimmer();
//           }),
//       floatingActionButton: InkWell(
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (
//                 context,
//               ) =>
//                       AddExperienceDetails()));
//         },
//         child: Container(
//           height: 44,
//           width: 140,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Color(0xff41C36C),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.add,
//                 // size: 14,
//                 color: Colors.white,
//               ),
//               Text(
//                 "Add new",
//                 style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 16,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500),
//               )
//             ],
//           ),
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   backgroundColor: kBlueColor,
//       //   onPressed: () {
//       //     kShowOptions(context, AddExperienceDetails(
//       //       onSelected: () {
//       //         setState(() {});
//       //       },
//       //     ));
//       //   },
//       //   child: Icon(Icons.add),
//       // ),
//     );
//   }

//   Widget getExperienceList(List<Map<String, dynamic>> list) {
//     return ListView.builder(
//       itemCount: list.length,
//       itemBuilder: (BuildContext context, int index) {
//         return getListWidget(list[index]);
//       },
//     );
//   }

//   Widget getListWidget(Map<String, dynamic> data) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 0.0),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       data['institutionName'],
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: InkWell(
//                       onTap: () {
//                         kShowOptions(
//                             context,
//                             AddExperienceDetails(
//                               options: data,
//                               isUpdate: true,
//                               onSelected: () {
//                                 setState(() {});
//                               },
//                             ));
//                       },
//                       child: Icon(Icons.edit, color: Colors.blueAccent),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: InkWell(
//                       onTap: () {
//                         Provider.of<AcademicProvide>(context, listen: false)
//                             .experience_detail_List
//                             .remove(data);
//                         // AcademicProvider()
//                         //     .setAcademicDetail(User().userId)
//                         //     .then((value) => {setState(() {})});
//                       },
//                       child: Icon(Icons.delete, color: Colors.blueAccent),
//                     ),
//                   )
//                 ],
//               ),
//               Text(
//                 data['subject'],
//                 style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey,
//                     fontWeight: FontWeight.w300),
//               ),
//               Text(
//                 data['isCurrentlyHere'] == true
//                     ? '${data['fromMonth']} ${data['fromYear']} to Present'
//                     : '${data['fromMonth']} ${data['fromYear']} to ${data['toMonth']} ${data['toYear']}',
//                 style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey,
//                     fontWeight: FontWeight.w300),
//               ),
//               SizedBox(
//                 height: 10,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
