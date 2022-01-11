import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/appointments/book_service.dart';

class PopularSpeciality extends StatefulWidget {
  const PopularSpeciality({Key? key}) : super(key: key);

  @override
  State<PopularSpeciality> createState() => _PopularSpecialityState();
}

class _PopularSpecialityState extends State<PopularSpeciality> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    // _databaseHelper.initializeDatabase().then((value) {
    //   log('Database Initialized');
    //   // loadReminders();
    //   // count++;
    // });
    loadServices();
    super.initState();
  }

  void loadServices() {
    _databaseHelper.getServices();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = context.watch<DatabaseHelper>();
    // var popularService = databaseProvider.serviceMasterDbList
    //     .where((service) => service.popularService.toLowerCase() == 'yes')
    //     .toList;
    return Visibility(
      visible: databaseProvider.popularServices.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text("Popular services",
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: FontSize.extraLarge)),
          SizedBox(height: 20),
          ListView.builder(
              itemCount: databaseProvider.popularServices.length,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(),
                  color: index % 2 == 0
                      ? AppColors.greyBackground
                      : AppColors.backgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Badge(
                            showBadge: false,
                            // databaseProvider
                            //         .popularServices[index].serviceAppFor
                            //         .toLowerCase() ==
                            //     'video consultations',
                            badgeColor: Colors.transparent,
                            padding: const EdgeInsets.all(0),
                            badgeContent: SvgPicture.asset(SVGAsset.videoAsset),
                            child: Text(
                                databaseProvider
                                    .popularServices[index].serviceName,
                                style: TextStyle(
                                    fontFamily: FontName.frutinger,
                                    fontWeight: FontWeight.w400,
                                    fontSize: FontSize.large)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: AppColors.orange,
                                ),
                              ),
                              primary: index % 2 == 0
                                  ? AppColors.greyBackground
                                  : AppColors.backgroundColor,
                              onPrimary: AppColors.orange),
                          onPressed: () {
                            databaseProvider.centerMasterFilterList =
                                databaseProvider.centerMasterDbList;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return BookService(
                                  isFromSearch: true,
                                  centerMasterDatabase:
                                      databaseProvider.centerMasterDbList[0],
                                  serviceMasterDatabase:
                                      databaseProvider.popularServices[index],
                                );
                              }),
                            );
                          },
                          child: Text('Book'),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
