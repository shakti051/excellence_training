// import 'package:eduarno/constants.dart';
// import 'package:eduarno/repo/bloc/assessment/filter_data.dart';
// import 'package:eduarno/repo/bloc/profile/interest_detail_data.dart';
// import 'package:eduarno/repo/bloc/profile/model/interest.dart';
// import 'package:eduarno/repo/bloc/user.dart';
// import 'package:eduarno/screens/assessment/assesment_listing.dart';
// import 'package:eduarno/screens/profile/add_specilisation.dart';
// import 'package:eduarno/widgets/add_interest_bottom.dart';
// import 'package:eduarno/widgets/bottom_app_bar.dart';
// import 'package:eduarno/widgets/bottom_sheet.dart';
// import 'package:eduarno/widgets/no_data_screen.dart';
// import 'package:eduarno/widgets/shimmer_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class InterestScreen extends StatefulWidget {
//   // final bool isSignUp;
//   // final bool newUser;

//   const InterestScreen({
//     Key key,
//     // this.isSignUp = false,
//   }) : super(key: key);

//   @override
//   _InterestScreenState createState() => _InterestScreenState();
// }

// class _InterestScreenState extends State<InterestScreen> {
//   bool isNext = false;
//   // bool updateListener = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Future.value(true),
//       // widget.newUser ? SystemNavigator.pop : Future.value(true),
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           backwardsCompatibility: true,
//           systemOverlayStyle:
//               SystemUiOverlayStyle(statusBarColor: Colors.white),
//           elevation: 0,
//           title: Text(
//             'Specialisation',
//             style: TextStyle(
//                 fontSize: 24.0,
//                 color: Color(0xff303030),
//                 fontWeight: FontWeight.w600),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//                   icon: Icon(CupertinoIcons.back, color: Colors.black),
//                   onPressed: () => {
//                     Navigator.pop(context),
//                   },
//                 ),
//         ),
//         body: FutureBuilder(
//             future: InterestProvider().getInterestDetail(User().userId),
//             builder: (context, snapshot) {
//               final interests = context.watch<InterestProvider>();
//               if (snapshot.hasError) {
//                 return MyNoData();
//               }
//               if (snapshot.connectionState == ConnectionState.done) {
//                 Provider.of<User>(context, listen: false).isUpdateListener =
//                     Provider.of<InterestProvider>(context, listen: false)
//                         .interestList
//                         .isNotEmpty;

//                 if (Provider.of<InterestProvider>(context)
//                     .interestList
//                     .isNotEmpty) {
//                   Provider.of<User>(context, listen: false).interestAdded =
//                       true;
//                 } else {
//                   User().interestAdded = false;
//                 }
//                 return Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     widget.isSignUp
//                         ? SizedBox()
//                         : Expanded(
//                             child: getInterestList(interests.interestList)),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 );
//               }
//               return MyShimmer();
//             }),
//         // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         floatingActionButton: InkWell(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               Provider.of<FilterBloc>(context, listen: false)
//                   .isSpecializationSelected = 'false';
//               Provider.of<FilterBloc>(context, listen: false)
//                   .selectedSpecialization = '';
//               return Specilisation(
//                 isEdit: false,
//                 onAdded: (specialization, topics) {
//                   print('V1 $specialization  V2 $topics');
//                   InterestProvider()
//                       .setInterestDetail(User().userId, specialization, topics)
//                       .then((value) => {
//                             setState(() {
//                               isNext = true;
//                             }),
//                           });
//                 },
//               );
//             }));
//           },
//           child: Container(
//             height: 44,
//             width: 140,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               color: Color(0xff41C36C),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.add,
//                   // size: 14,
//                   color: Colors.white,
//                 ),
//                 Text(
//                   "Add new",
//                   style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget getInterestList(List<Interest> list) {
//     return ListView.builder(
//       itemCount: list.length,
//       itemBuilder: (BuildContext context, int index) {
//         return listItem(list[index], currentIndex: index);
//       },
//     );
//   }

//   Future<Null> _showDeleteDialog(
//       {@required Interest list, @required int index}) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           final interest = context.watch<InterestProvider>();
//           return Dialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0)), //this right here
//             child: Container(
//               height: 200,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Sure, you want to delete this?",
//                       style: TextStyle(
//                           color: Color(0xff303030),
//                           fontWeight: FontWeight.w700),
//                     ),
//                     // SizedBox(height: 10),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 32.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           SizedBox(
//                               width: 90,
//                               //flex: 1,
//                               child: ElevatedButton(
//                                 style: ButtonStyle(
//                                     shape: MaterialStateProperty.all(
//                                       RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(50.0),
//                                       ),
//                                     ),
//                                     backgroundColor:
//                                         MaterialStateProperty.all(Colors.red)),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   interest.interestList.removeAt(index);
//                                   interest
//                                       .deleteInterestDetail(
//                                     User().userId,
//                                     list.specialization,
//                                   )
//                                       .then((value) {
//                                     // setState(() {});
//                                   });
//                                 },
//                                 child: Text("Confirm"),
//                               )),
//                           SizedBox(
//                               width: 90,
//                               //flex: 1,
//                               child: ElevatedButton(
//                                 style: ButtonStyle(
//                                   shape: MaterialStateProperty.all(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(50.0),
//                                     ),
//                                   ),
//                                   backgroundColor: MaterialStateProperty.all(
//                                       Color(0xff41C36C)),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text("Abort"),
//                               )),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   Widget listItem(Interest interest, {int currentIndex}) {
//     return Card(
//       color: AppColors.neutralGray,
//       borderOnForeground: false,
//       elevation: 0,
//       shadowColor: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       clipBehavior: Clip.antiAlias,
//       margin: EdgeInsets.only(left: 24, right: 24, top: 6, bottom: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '${interest.specialization}',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 24,
//                           color: Color(0xff41C36C)),
//                     ),
//                     InkWell(
//                         onTap: () {
//                           kShowOptions(
//                             context,
//                             SelectOptionBottomSheet(
//                               title: 'Action',
//                               options: [/*'Edit',*/ 'Delete'],
//                               onSelected: (option) {
//                                 if (option.toLowerCase() ==
//                                     "Delete".toLowerCase()) {
//                                   Navigator.pop(context);
//                                   _showDeleteDialog(
//                                       list: interest, index: currentIndex);
//                                 }
//                               },
//                             ),
//                           );
//                         },
//                         child: Icon(Icons.more_vert,
//                             size: 20, color: AppColors.primaryColor)),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                   height: 2, child: Container(color: AppColors.centerBorder)),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 0, top: 12, right: 10, bottom: 12),
//                 child: Wrap(
//                   children: [
//                     for (String s in interest.topic) getTopic(s),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget getTopic(String item) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
//       child: Container(
//         height: 22,
//         padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
//         decoration: BoxDecoration(
//           color: AppColors.tosqa,
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//         ),
//         child: Text(
//           item,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/assessment/filter_data.dart';
import 'package:eduarno/repo/bloc/profile/interest_detail_data.dart';
import 'package:eduarno/repo/bloc/profile/model/interest.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/screens/assessment/assesment_listing.dart';
import 'package:eduarno/screens/profile/add_specilisation.dart';
import 'package:eduarno/widgets/add_interest_bottom.dart';
import 'package:eduarno/widgets/bottom_app_bar.dart';
import 'package:eduarno/widgets/bottom_sheet.dart';
import 'package:eduarno/widgets/no_data_screen.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class InterestScreen extends StatefulWidget {
  // final bool isSignUp;
  // final bool newUser;

  const InterestScreen({
    Key key,
    // this.isSignUp = false,
  }) : super(key: key);

  @override
  _InterestScreen createState() => _InterestScreen();
}

class _InterestScreen extends State<InterestScreen> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    InterestProvider().getInterestDetail(User().userId);
  }

  Widget build(BuildContext context) {
    final interests = context.watch<InterestProvider>();
    return WillPopScope(
        onWillPop: () => Future.value(true),
        // widget.newUser ? SystemNavigator.pop : Future.value(true),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              backwardsCompatibility: true,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.white),
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(CupertinoIcons.back),
                color: kChatColor,
              ),
              title: Text(
                'Specialisation',
                style: TextStyle(
                  fontSize: 24.0,
                  // color: Color(0xff303030),
                  // fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            body: interests.interestList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyNoData(
                        message: 'Add specialisation to give assessment',
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            Provider.of<FilterBloc>(context, listen: false)
                                .isSpecializationSelected = 'false';
                            Provider.of<FilterBloc>(context, listen: false)
                                .selectedSpecialization = '';
                            return Specialisation(
                              isEdit: false,
                              onAdded: (specialization, topics) {
                                interests.setInterestDetail(
                                    User().userId, specialization, topics);
                              },
                            );
                          }));
                        },
                        child: Container(
                          height: 44,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.primaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                // size: 14,
                                color: Colors.white,
                              ),
                              Text(
                                'Add new',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : getInterestList(interests.interestList),
            floatingActionButton: interests.interestList.isNotEmpty
                ? InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        Provider.of<FilterBloc>(context, listen: false)
                            .isSpecializationSelected = 'false';
                        Provider.of<FilterBloc>(context, listen: false)
                            .selectedSpecialization = '';
                        return Specialisation(
                          isEdit: false,
                          onAdded: (specialization, topics) {
                            print('V1 $specialization  V2 $topics');
                            interests.setInterestDetail(
                                User().userId, specialization, topics);
                          },
                        );
                      }));
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
                          Icon(
                            Icons.add,
                            // size: 14,
                            color: Colors.white,
                          ),
                          Text(
                            'Add new',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  )
                : null));
  }

  Widget getInterestList(List<Interest> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return listItem(list[index], currentIndex: index);
      },
    );
  }

  Future<Null> _showDeleteDialog(
      {@required Interest list, @required int index}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final interest = context.watch<InterestProvider>();
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
                    'Sure, you want to delete this?',
                    style: TextStyle(
                        color: Color(0xff303030), fontWeight: FontWeight.w700),
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
                              interest.interestList.removeAt(index);
                              interest
                                  .deleteInterestDetail(
                                User().userId,
                                list.specialization,
                              )
                                  .then((value) {
                                // setState(() {});
                              });
                            },
                            child: Text('Confirm'),
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
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff41C36C)),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Abort'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget listItem(Interest interest, {int currentIndex}) {
    return Card(
      color: AppColors.neutralGray,
      borderOnForeground: false,
      elevation: 0,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(left: 24, right: 24, top: 6, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${interest.specialization}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(0xff41C36C)),
                    ),
                    InkWell(
                      onTap: () {
                        kShowOptions(
                          context,
                          SelectOptionBottomSheet(
                            title: 'Action',
                            options: [/*'Edit',*/ 'Delete'],
                            onSelected: (option) {
                              if (option.toLowerCase() ==
                                  'Delete'.toLowerCase()) {
                                Navigator.pop(context);
                                _showDeleteDialog(
                                    list: interest, index: currentIndex);
                              }
                            },
                          ),
                        );
                      },
                      child: Icon(Icons.more_vert,
                          size: 20, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 2, child: Container(color: AppColors.centerBorder)),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, top: 12, right: 10, bottom: 12),
                child: Wrap(
                  children: [
                    for (String s in interest.topic) getTopic(s),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getTopic(String item) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
      child: Container(
        height: 22,
        padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: AppColors.tosqa,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Text(
          item,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
