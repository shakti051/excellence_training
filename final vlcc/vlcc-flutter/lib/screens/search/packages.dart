import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/package_listing_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/appointments/book_service.dart';
import 'package:vlcc/screens/packages/packages.dart';
import 'package:vlcc/widgets/heading_title_text.dart';

class Packages extends StatefulWidget {
  final PackageDetail packageDetail;
  const Packages({Key? key, required this.packageDetail}) : super(key: key);

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  bool findServiceType(
      {required String serviceCode, required DatabaseHelper databaseHelper}) {
    var result = databaseHelper.serviceMasterDbList.where((service) {
      // log(service.serviceCode);
      return service.serviceCode == serviceCode;
    });
    try {
      if (result.first.serviceAppFor.toLowerCase() == 'general') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final databaseHelper = context.watch<DatabaseHelper>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
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
            // title: Container(
            //   margin: EdgeInsets.only(top: MarginSize.small),
            //   child: Text(
            //     "Book appointment",
            //     style: TextStyle(
            //         color: Colors.black87,
            //         fontWeight: FontWeight.w700,
            //         fontSize: FontSize.extraLarge),
            //   ),
            // ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingTitleText(
                  fontSize: FontSize.heading,
                  title: 'Book Appointment',
                ),
                SizedBox(height: 32),
                packageDetailsCard(context),
                SizedBox(height: 32),
                SizedBox(
                  height: 50,
                  child: AppBar(
                    backgroundColor: AppColors.backgroundColor,
                    elevation: 0,
                    bottom: TabBar(
                      isScrollable: true,
                      labelColor: AppColors.selectedTab,
                      indicatorColor: Colors.black87,
                      unselectedLabelColor: AppColors.navyBlue,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelStyle: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.heading),
                      labelStyle: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.heading),
                      tabs: const [
                        Tab(
                          text: "Appointments",
                        ),
                        Tab(
                          text: "Video Consultation",
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // first tab bar view widget
                      Column(
                        children: [
                          SizedBox(height: 32),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  widget.packageDetail.packageItemDtl!.length,
                              itemBuilder: (context, index) {
                                var isGeneral = findServiceType(
                                    serviceCode: widget.packageDetail
                                        .packageItemDtl![index].serviceCode,
                                    databaseHelper: databaseHelper);
                                return isGeneral
                                    ? serviceNameCard(index, context,
                                        databaseHelper: databaseHelper,
                                        bookingType: 'General')
                                    : SizedBox();
                              },
                            ),
                          ),
                        ],
                      ),
                      // second tab bar view widget
                      Column(
                        children: [
                          SizedBox(height: 32),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  widget.packageDetail.packageItemDtl!.length,
                              itemBuilder: (context, index) {
                                var isVideo = !findServiceType(
                                    serviceCode: widget.packageDetail
                                        .packageItemDtl![index].serviceCode,
                                    databaseHelper: databaseHelper);
                                return isVideo
                                    ? serviceNameCard(index, context,
                                        databaseHelper: databaseHelper,
                                        bookingType: 'Video Consultations')
                                    : SizedBox();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack packageDetailsCard(BuildContext context) {
    final packageProvider = context.watch<PackageProvider>();
    var expiryDate = DateFormat.yMMMMd('en_US')
        .format(widget.packageDetail.bookingExpiryDate ?? DateTime.now());
    var todaysDate = DateTime.now();
    var expiry = widget.packageDetail.bookingExpiryDate ?? DateTime.now();

    double daysLeft() {
      int daysLeft = expiry.difference(todaysDate).inDays;
      if (daysLeft < 0) {
        return 0;
      } else {
        var ceil = (daysLeft / 356).ceil();
        return daysLeft / (356 * ceil);
      }
    }

    // var percentage = (widget);
    return Stack(
      children: [
        ColorfulCard(
          cardHeight: 165,
          cardColor: packageProvider.packageCardColor,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: MarginSize.normal,
                  top: MarginSize.normal,
                  bottom: MarginSize.extraSmall),
              child: Text(
                widget.packageDetail.bookingNumber,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontName.frutinger,
                    fontWeight: FontWeight.w700,
                    fontSize: FontSize.heading),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: MarginSize.normal),
              child: Text(
                widget.packageDetail.centerName,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontName.frutinger,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.small),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.only(top: 4),
            //   margin: EdgeInsets.only(left: MarginSize.normal),
            //   child: Text(
            //     "Men's grooming",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontFamily: FontName.frutinger,
            //         fontWeight: FontWeight.w600,
            //         fontSize: FontSize.small),
            //   ),
            // ),
            SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadingTitleText(
                    fontSize: FontSize.small,
                    title: 'Usage left',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  HeadingTitleText(
                    fontSize: FontSize.small,
                    title: "*Valid till $expiryDate",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: LinearPercentIndicator(
                  percent: daysLeft(),
                  backgroundColor: Colors.white54,
                  progressColor: Colors.white,
                )
                // LinearProgressIndicator(
                //   minHeight: 5.0,
                //   value: 30.0,
                //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                //   backgroundColor: Colors.white54,
                // ),
                )
          ],
        ),
      ],
    );
  }

  Card serviceNameCard(int index, BuildContext context,
      {required DatabaseHelper databaseHelper, required String bookingType}) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.packageDetail.packageItemDtl![index].serviceName,
                      style: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.large)),
                  HeadingTitleText(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.normal,
                    title:
                        '${widget.packageDetail.packageItemDtl![index].serviceLeftQty} usages left',
                  )
                ],
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
                Navigator.push(
                    context,
                    PageTransition(
                        child: BookService(
                            bookingTypePackage: bookingType,
                            isBookViaPackage: true,
                            bookingId: widget.packageDetail.bookingId,
                            bookingItemId: widget.packageDetail
                                .packageItemDtl![index].bookingItemId,
                            serviceCode: widget.packageDetail
                                .packageItemDtl![index].serviceCode,
                            serviceName: widget.packageDetail
                                .packageItemDtl![index].serviceName,
                            centerCode: widget.packageDetail.centerCode,
                            centerName: widget.packageDetail.centerName,
                            centerMasterDatabase:
                                databaseHelper.centerMasterDbList.first,
                            serviceMasterDatabase:
                                databaseHelper.serviceMasterDbList.first),
                        type: PageTransitionType.rightToLeft));
              },
              child: Text('Book'),
            ),
          ),
        ],
      ),
    );
  }
}
