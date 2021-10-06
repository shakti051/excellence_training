import 'dart:math';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/profile/academic_experience_api/academic_data.dart';
import 'package:eduarno/repo/bloc/profile/model/academic_model.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/widgets/add_academic_sheet.dart';
import 'package:eduarno/widgets/bottom_sheet.dart';
import 'package:eduarno/widgets/no_data_screen.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AcademicScreen extends StatefulWidget {
  const AcademicScreen({Key key}) : super(key: key);

  @override
  _AcademicScreenState createState() => _AcademicScreenState();
}

class _AcademicScreenState extends State<AcademicScreen> {
  bool isLoading = false;
  var random = new Random();

  @override
  Widget build(BuildContext context) {
    // var ListLength = academicDetailList.length;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: true,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 0,
        title: Text(
          'Academic information',
          style: TextStyle(
            fontSize: 24.0,
            //  color: Colors.black,
            // fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/back.svg'),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: FutureBuilder(
          future: AcademicProvide()
              .getAcademicData(Provider.of<User>(context).userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // if (academicDetailList.isEmpty)
              if (Provider.of<AcademicProvide>(context)
                  .academic_detail_List
                  .isEmpty)
              // (Provider.of<AcademicProvider>(context).eduList.isEmpty)
              {
                return MyNoData();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: getAcademicList(
                        Provider.of<AcademicProvide>(context)
                            .academic_detail_List,
                      ),
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
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (
                context,
              ) =>
                      AddAcademicDetails(
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
                // visible: ListLength < 1,
                child: Icon(
                  Icons.add,
                  // size: 14,
                  color: Colors.white,
                ),
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
    );
  }

  Widget getAcademicList(List<Academic> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return getListWidget(list[index]);
      },
    );
  }

  Future<Null> _showDeleteDialog({@required Academic data}) {
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
                      'Sure, you want to delete this?',
                      style: TextStyle(
                          color: Color(0xff303030),
                          fontWeight: FontWeight.w700),
                    ),
                    //SizedBox(height: 10),
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
                                    .academic_detail_List
                                    .remove(data);
                                //Delete API Call pending
                                AcademicProvide()
                                    .deleteAcademicData(
                                      id: User().userId,
                                      institutionName: data.institutionName,
                                      degree: data.degree,
                                      fromMonth: data.fromMonth,
                                      fromYear: data.fromYear,
                                      toMonth: data.toMonth,
                                      toYear: data.toYear,
                                      academicRecord: data.academicRecord,
                                      bio: data.bio,
                                      isCurrentlyHere: data.isCurrentlyHere,
                                      specialisation: data.specialisation,
                                    )
                                    .then((value) => {setState(() {})});
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
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff41C36C))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Abort'),
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

  Widget getListWidget(Academic data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        // height: 124,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppColors.neutralGray,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: RichText(
                                text: TextSpan(
                                    text: '${data.degree}',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryGreenColor),
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: ' with ',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        color: kPrimaryGreenColor),
                                  ),
                                  TextSpan(
                                    text: '${data.specialisation}',
                                  )
                                ])),
                          ),
                          // Text(
                          //         '${data.degree}',
                          //         style: TextStyle(
                          //             fontSize: 24,
                          //             fontWeight: FontWeight.w600,
                          //             color: kPrimaryGreenColor),
                          //       ),
                          //       Text(
                          //         ' with ',
                          //         style: TextStyle(
                          //             fontSize: 24,
                          //             fontWeight: FontWeight.w400,
                          //             color: kPrimaryGreenColor),
                          //       ),
                          //       Text(
                          //         '${data.specialisation}',
                          //         style: TextStyle(
                          //             fontSize: 24,
                          //             fontWeight: FontWeight.w600,
                          //             color: kPrimaryGreenColor),
                          //       ),
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
                                        //           AddAcademicDetails(
                                        //               isUpdate: true,
                                        //               options: data),
                                        //     ),
                                        //   );
                                        // }
                                        if (option == 'Delete') {
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
                          '${data.institutionName}',
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
      ),
    );
  }
}
