import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/service_master_model.dart';
import 'package:vlcc/models/unique_service_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/screens/appointments/book_service.dart';
import 'package:vlcc/widgets/custom_text_field.dart';
import 'package:vlcc/widgets/nodata.dart';

class Specialities extends StatefulWidget {
  final UniqueServiceModel uniqueServiceModel;
  const Specialities({Key? key, required this.uniqueServiceModel})
      : super(key: key);

  @override
  State<Specialities> createState() => _SpecialitiesState();
}

class _SpecialitiesState extends State<Specialities> {
  List<ServiceMasterDatabase> subService = [];
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    subServiceFilter().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataBaseHelper = context.watch<DatabaseHelper>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _appBar(),
      floatingActionButton: Visibility(
        visible: _scrollController.hasClients && _scrollController.offset > 240
            ? true
            : false,
        child: FloatingActionButton.small(
          onPressed: _scrollUp,
          child: Icon(Icons.arrow_upward),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 0,
              left: PaddingSize.extraLarge,
              right: PaddingSize.extraLarge,
              bottom: PaddingSize.extraLarge),
          child: Column(
            children: [
              Column(
                children: [
                  CustomTextField(
                    showHeadingTitle: false,
                    isReadOnly: false,
                    textEditingController: _searchTextController,
                    textFormatter: [LengthLimitingTextInputFormatter(50)],
                    hintText:
                        'Search ${widget.uniqueServiceModel.serviceCategory.toLowerCase()}',
                    fillColor: AppColors.greyBackground,
                    onChanged: (value) {
                      _runFilter(
                        enteredKeyword: value.trim(),
                        databaseHelper: databaseHelper,
                      );
                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        SVGAsset.searchIcon,
                        color: Colors.grey,
                      ),
                    ),
                    isPrefixIcon: true,
                    ontap: () {
                      log('hello');
                    },
                    customField: CustomField.clickable,
                  ),
                ],
              ),
              SizedBox(height: 18),
              Expanded(
                child: subService.isNotEmpty
                    ? Card(
                        elevation: 1,
                        margin: const EdgeInsets.all(0),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: subService.length,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return serviceNameCard(
                              index: index,
                              databaseHelper: dataBaseHelper,
                              context: context,
                            );
                          },
                        ),
                      )
                    : NoDataScreen(
                        noDataSelect: NoDataSelectType.feelsEmptyHere,
                        feelsEmptyHereMessage: 'Try with other search term',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _runFilter({
    required String enteredKeyword,
    required DatabaseHelper databaseHelper,
  }) {
    subService = databaseHelper.serviceMasterDbList;
    List<ServiceMasterDatabase> _filterService = [];
    if (enteredKeyword.isEmpty) {
      _filterService = databaseHelper.serviceMasterDbList;
    } else {
      _filterService = subService
          .where(
            (service) => service.serviceName.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
      log('_filterService = ${_filterService.length}');
    }
    // Refresh the UI
    databaseHelper.serviceFilterList = _filterService;

    log('_filterService serviceMasterDbList = ${databaseHelper.serviceFilterList.length}');
    setState(() {
      subService = _filterService;
    });
  }

  Future<void> subServiceFilter() async {
    subService = databaseHelper.serviceMasterDbList
        .where(
          (service) => service.serviceCategory.toLowerCase().contains(
                widget.uniqueServiceModel.serviceCategory.toLowerCase(),
              ),
        )
        .toList();
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Transform.scale(
          scale: 1.4,
          child: Container(
            margin: EdgeInsets.only(left: 24, top: 12, bottom: 12),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.backBorder),
                borderRadius: BorderRadius.circular(8)),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(SVGAsset.backButton),
            ),
          ),
        ),
        title: Text(
          widget.uniqueServiceModel.serviceCategory,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.extraLarge),
        ),
      ),
    );
  }

  ServiceListTiles serviceNameCard({
    required int index,
    required DatabaseHelper databaseHelper,
    required BuildContext context,
  }) {
    return ServiceListTiles(
      subService: subService,
      index: index,
      context: context,
      databaseHelper: databaseHelper,
    );
  }

  void _scrollUp() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}

class ServiceListTiles extends StatelessWidget {
  const ServiceListTiles({
    Key? key,
    required this.subService,
    required this.index,
    required this.databaseHelper,
    required this.context,
  }) : super(key: key);

  final List<ServiceMasterDatabase> subService;
  final int index;
  final DatabaseHelper databaseHelper;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(),
      margin: EdgeInsets.all(0),
      color:
          index % 2 == 0 ? AppColors.greyBackground : AppColors.backgroundColor,
      child: ListTile(
        leading: Container(
          width: 52,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(PNGAsset.clinicLogo),
        ),
        title: Badge(
          showBadge: false,
          // subService[index].serviceAppFor.toLowerCase() ==
          // 'video consultations',
          badgeColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          badgeContent: SvgPicture.asset(SVGAsset.videoAsset),
          alignment: Alignment.topLeft,
          child: Text(
            subService[index].serviceName.trim(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: FontName.frutinger,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.defaultFont,
            ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '₹ ${subService[index].serviceType.trim().toLowerCase().toTitleCase}',
            style: TextStyle(
              fontFamily: FontName.frutinger,
              fontWeight: FontWeight.w600,
              fontSize: FontSize.small,
              color: AppColors.orangeCategoryTextBackground,
            ),
          ),
        ),
        trailing: Padding(
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
              primary: Colors.white,

              // index % 2 == 0
              //     ? AppColors.greyBackground
              //     : AppColors.backgroundColor,
              onPrimary: AppColors.orange,
            ),
            onPressed: () {
              databaseHelper.centerMasterFilterList =
                  databaseHelper.centerMasterDbList;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return BookService(
                    isFromSearch: true,
                    centerMasterDatabase: databaseHelper.centerMasterDbList[0],
                    serviceMasterDatabase: subService[index],
                  );
                }),
              );
            },
            child: Text('Book'),
          ),
        ),
      ),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Flexible(
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Badge(
      //           showBadge: subService[index].serviceAppFor.toLowerCase() ==
      //               'video consultations',
      //           badgeColor: Colors.transparent,
      //           padding: const EdgeInsets.all(0),
      //           badgeContent: SvgPicture.asset(SVGAsset.videoAsset),
      //           child: Text(subService[index].serviceName,
      //               style: TextStyle(
      //                   fontFamily: FontName.frutinger,
      //                   fontWeight: FontWeight.w400,
      //                   fontSize: FontSize.large)),
      //         ),
      //       ),
      //     ),
      //
      //   ],
      // ),
    );
  }
}
