import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/components/components.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/center_master_model.dart';
import 'package:vlcc/models/unique_service_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/appointments/book_service.dart';
import 'package:vlcc/screens/search/clinics.dart';
import 'package:vlcc/screens/search/specialities.dart';
import 'package:vlcc/widgets/nodata.dart';

class SearchSpeciality extends StatefulWidget {
  const SearchSpeciality({Key? key}) : super(key: key);

  @override
  _SearchSpecialityState createState() => _SearchSpecialityState();
}

class _SearchSpecialityState extends State<SearchSpeciality> {
  final TextEditingController _searchController = TextEditingController();
  final DatabaseHelper dbh = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    dbh.getUniqueSpeciality();
  }

  // void _runFilter(String enteredKeyword, DatabaseHelper databaseHelper) {
  //   var serviceList = databaseHelper.serviceMasterDbList;
  //   databaseHelper.serviceFilterList = serviceList;
  //   List<ServiceMasterDatabase> _filterService = [];
  //   if (enteredKeyword.isEmpty) {
  //     // if the search field is empty or only contains white-space, we'll display all users
  //     // results = serviceList;
  //     _filterService = databaseHelper.serviceMasterDbList;
  //   } else {
  //     _filterService = serviceList
  //         .where(
  //           (service) => service.serviceSubCategory2.toLowerCase().contains(
  //                 enteredKeyword.toLowerCase(),
  //               ),
  //         )
  //         .toList();
  //     // we use the toLowerCase() method to make it case-insensitive
  //   }

  //   // Refresh the UI
  //   databaseHelper.serviceFilterList = _filterService;
  // }
  void _runFilter(String enteredKeyword, DatabaseHelper databaseHelper) {
    var serviceList = databaseHelper.uniqueServiceList;
    var centerList = databaseHelper.centerMasterDbList;
    databaseHelper.centerMasterDbFilterList1 = centerList;
    databaseHelper.uniqueServiceListFilter = serviceList;
    List<UniqueServiceModel> _filterService = [];
    List<CenterMasterDatabase> _filterCenter = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      // results = serviceList;
      _filterCenter = databaseHelper.centerMasterDbFilterList1;
      _filterService = databaseHelper.uniqueServiceList;
    } else {
      _filterCenter = centerList
          .where(
            (center) => center.centerName.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
      _filterService = serviceList
          .where(
            (service) => service.serviceCategory.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    databaseHelper.centerMasterDbFilterList1 = _filterCenter;
    databaseHelper.uniqueServiceListFilter = _filterService;
  }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = context.watch<DatabaseHelper>();
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            toolbarHeight: 80,
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            //centerTitle: true,
            automaticallyImplyLeading: false,
            title: Container(
              margin: EdgeInsets.only(top: 10, right: 16, bottom: 4),
              // height: 48,
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.name,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(height: 1.2),
                decoration: InputDecoration(
                  hintText: 'Search location, clinic, speciality',
                  prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 5, right: 0, bottom: 15),
                      child: SizedBox(
                        height: 4,
                        child: SvgPicture.asset(SVGAsset.searchIcon),
                      )),
                  suffixIcon: InkWell(
                    onTap: () {
                      _searchController.text = '';
                    },
                    child: Icon(Icons.clear_rounded, color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.aquaGreen),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onChanged: (value) =>
                    _runFilter(value.trim(), databaseProvider),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 24, top: 32),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: AppColors.orange,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                        "Specialities (${databaseProvider.uniqueServiceListFilter.length})",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.extraLarge)),
                  ],
                ),

                SizedBox(height: 24),
                // SizedBox(
                //   height: 300,
                //   child: servicesList(databaseProvider,
                //       databaseProvider.centerMasterDbList.first),
                // ),
                databaseProvider.uniqueServiceListFilter.isNotEmpty
                    ? SizedBox(
                        height: 350,
                        child: ListView.builder(
                          clipBehavior: Clip.antiAlias,
                          shrinkWrap: true,
                          itemCount:
                              databaseProvider.uniqueServiceListFilter.length,
                          itemBuilder: (context, index) {
                            return Container(
                              // height: 58,
                              decoration: BoxDecoration(
                                  color: (index % 2 == 0)
                                      ? AppColors.greyBackground
                                      : AppColors.backgroundColor,
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.greyBackground),
                                  borderRadius: index == 0
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))
                                      : index == 4
                                          ? BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10))
                                          : BorderRadius.circular(0)),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: Specialities(
                                            uniqueServiceModel: databaseProvider
                                                .uniqueServiceListFilter[index],
                                          ),
                                          type:
                                              PageTransitionType.rightToLeft));
                                },
                                title: Text(
                                    databaseProvider
                                        .uniqueServiceListFilter[index]
                                        .serviceCategory,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: FontSize.normal)),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            );
                            // serviceNameCard(index, databaseProvider, context);
                          },
                        ),
                      )
                    : NoDataScreen(
                        noDataSelect: NoDataSelectType.package,
                      ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Text(
                        "Clinics (${databaseProvider.centerMasterDbFilterList1.length})",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.large)),
                  ],
                ),
                SizedBox(height: 20),
                databaseProvider.centerMasterDbFilterList1.isNotEmpty
                    ? ListView.builder(
                        itemCount:
                            databaseProvider.centerMasterDbFilterList1.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Clinics(
                                    centerMasterDatabase: databaseProvider
                                        .centerMasterDbFilterList1[index],
                                  ),
                                ),
                              );
                            },
                            child: ClinicName(
                              centerMasterDatabase: databaseProvider
                                  .centerMasterDbFilterList1[index],
                            ),
                          );
                        })
                    : NoDataScreen(
                        noDataSelect: NoDataSelectType.package,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card serviceNameCard(
      int index, DatabaseHelper databaseProvider, BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(),
      color:
          index % 2 == 0 ? AppColors.greyBackground : AppColors.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Badge(
                showBadge: databaseProvider
                        .serviceFilterList[index].serviceAppFor
                        .toLowerCase() ==
                    'video consultations',
                badgeColor: Colors.transparent,
                padding: const EdgeInsets.all(0),
                badgeContent: SvgPicture.asset(SVGAsset.videoAsset),
                child: Text(
                    databaseProvider.serviceFilterList[index].serviceName,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          databaseProvider.serviceMasterDbList[index],
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
  }

  Widget servicesList(DatabaseHelper databaseProvider,
      CenterMasterDatabase centerMasterDatabase) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: ListView.builder(
              itemCount: databaseProvider.serviceMasterDbList.length,
              itemBuilder: (context, index) {
                return MedicalServices(
                  index: index,
                  serviceMasterDatabase:
                      databaseProvider.serviceMasterDbList[index],
                  centerMasterDatabase: centerMasterDatabase,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
