import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/vlcc_theme.dart';
import 'package:vlcc/screens/packages/cash_invoice_detail.dart';
import 'package:vlcc/screens/packages/invoice_details.dart';
import 'package:vlcc/screens/packages/package_provider.dart';
import 'package:vlcc/widgets/heading_title_text.dart';
import 'package:vlcc/widgets/nodata.dart';

class InvoiceListing extends StatefulWidget {
  const InvoiceListing({Key? key}) : super(key: key);

  @override
  _InvoiceListingState createState() => _InvoiceListingState();
}

class _InvoiceListingState extends State<InvoiceListing>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final PackageProvider _packageProvider = PackageProvider();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
    // _packageProvider.getPackageInvoice();
  }

  Future<void> _refresh() async {
    // await Future.delayed(Duration(seconds: 1));
    // setState(() {
    return _packageProvider.getPackageInvoice();
    // });
  }

  @override
  void dispose() {
    tabController.dispose();
    _refreshIndicatorKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final packageListProvider = context.watch<PackageProvider>();

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(
          'VLCC',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: AppColors.logoOrange,
            fontWeight: FontWeight.w700,
            fontSize: FontSize.heading,
            fontFamily: FontName.frutinger,
          ),
        ),
        centerTitle: false,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 14,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(PaddingSize.small),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.backBorder),
                    borderRadius: BorderRadius.circular(16)),
                child: Icon(
                  Icons.keyboard_backspace,
                  size: 24,
                  color: AppColors.profileEnabled,
                ),
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        key: _refreshIndicatorKey,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: TabBar(
                  isScrollable: true,
                  unselectedLabelStyle: TextStyle(
                      color: AppColors.profileEnabled,
                      fontWeight: FontWeight.w500),
                  labelStyle: TextStyle(
                    color: AppColors.profileEnabled,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.heading,
                  ),
                  padding: EdgeInsets.only(right: screenSize.width * 0.35),
                  indicatorColor: AppColors.profileEnabled,
                  controller: tabController,
                  tabs: const <Widget>[
                    Tab(
                      child: Text(
                        'Booking',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Packages',
                      ),
                    ),
                  ],
                ),
                pinned: true,
                floating: true,
                backgroundColor: AppColors.backgroundColor,
              ),
            ];
          },
          body:
              body(context: context, packageListProvider: packageListProvider),
        ),
      ),
    );
  }

  Widget body(
      {required BuildContext context,
      required PackageProvider packageListProvider}) {
    var cashInvoiceListLength =
        packageListProvider.cashBookingInvoiceModel.invoiceDetails!.length;
    var packageInvoiceListLength =
        packageListProvider.packageInvoiceListingModel.invoiceDetails!.length;
    return TabBarView(
      controller: tabController,
      children: [
        cashInvoiceListLength != 0
            ? listing(
                packageProvider: packageListProvider,
                isBooking: true,
                invoiceID: 'Booking ID: #236549',
                date: 'Aug 25, 2021 · 09:45 am',
                packageName: 'Safe Health clinic',
                packageTitle: 'Dermatology',
                price: 'Rs. 1250',
                ontap: () {},
              )
            : NoDataScreen(
                noDataSelect: NoDataSelectType.packageInvoiceList,
              ),
        packageInvoiceListLength != 0
            ? listing(
                packageProvider: packageListProvider,
                invoiceID: 'Invoice ID: #236549',
                date: 'Aug 25, 2021 · 09:45 am',
                packageName: 'Package name',
                packageTitle: 'Safe Health clinic',
                price: 'Rs. 1250',
                ontap: () {},
              )
            : NoDataScreen(
                noDataSelect: NoDataSelectType.packageInvoiceList,
              ),
      ],
    );
  }

  Widget listing(
      {required PackageProvider packageProvider,
      required String invoiceID,
      required String date,
      required String packageName,
      required String packageTitle,
      required String price,
      required void Function() ontap,
      bool isBooking = false}) {
    var cashListFromModel = packageProvider
        .cashBookingInvoiceModel.invoiceDetails?.reversed
        .toList();

    var packageListFromModel = packageProvider
        .packageInvoiceListingModel.invoiceDetails?.reversed
        .toList();

    var listLength =
        isBooking ? cashListFromModel!.length : packageListFromModel!.length;
    return Padding(
      padding: const EdgeInsets.all(PaddingSize.extraLarge),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: List.generate(listLength, (index) {
          // var bookingDate = date;
          // var bookingDate = DateFormat.yMMMd().format(
          //     packageListFromModel![index].invoiceDate ?? DateTime.now());
          // var bookingDate = packageListFromModel![0].invoiceDate.toString();
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeadingTitleText(
                        fontSize: FontSize.small,
                        title: isBooking
                            ? cashListFromModel![index].invoiceId
                            : packageListFromModel![index].invoiceId,
                        color: AppColors.grey,
                      ),
                      HeadingTitleText(
                        fontSize: FontSize.small,
                        title: isBooking
                            ? DateFormat.yMMMd().format(
                                cashListFromModel![index].invoiceDate ??
                                    DateTime.now())
                            : DateFormat.yMMMd().format(
                                packageListFromModel![index].invoiceDate ??
                                    DateTime.now()),
                        color: AppColors.grey,
                      )
                    ],
                  ),
                  Divider(),
                  HeadingTitleText(
                    fontSize: FontSize.large,
                    title: isBooking
                        ? cashListFromModel![index].invoiceNumber
                        : packageListFromModel![index]
                            .invoicePackageBooingNumber,
                  ),
                  HeadingTitleText(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w600,
                    title: isBooking
                        ? cashListFromModel![index].centerName
                        : packageListFromModel![index].centerName,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RichText(
                            text: TextSpan(
                                text: 'Paid ',
                                style: TextStyle(
                                  fontSize: FontSize.small,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.profileEnabled,
                                ),
                                children: <TextSpan>[
                              TextSpan(
                                  text: isBooking
                                      ? "Rs ${cashListFromModel![index].invoiceTotalPaidIncTaxAmount}"
                                      : "Rs ${packageListFromModel![index].invoiceTotalPaidIncTaxAmount}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ))
                            ])),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: isBooking
                            ? () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CashInvoice(
                                    invoiceID: isBooking
                                        ? cashListFromModel![index].invoiceId
                                        : packageListFromModel![index]
                                            .invoiceId,
                                    packageName:
                                        cashListFromModel![index].invoiceNumber,
                                    invoiceDetail: cashListFromModel[index],
                                  );
                                }));
                              }
                            : () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return InvoiceDetails(
                                    invoiceID: isBooking
                                        ? cashListFromModel![index].invoiceId
                                        : packageListFromModel![index]
                                            .invoiceId,
                                    packageName: packageListFromModel![index]
                                        .invoicePackageBooingNumber,
                                    invoiceDetail: packageListFromModel[index],
                                  );
                                }));
                              },
                        child: Text('View details'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  bool getIsInvoiceAvailable({required String packageName}) {
    var isPresent = true;
    var package = _packageProvider
        .getPackageSpecificInvoice(packageName: packageName)
        .then((value) {
      if (value.invoicePackageBooingNumber != '') {
        isPresent = true;
      } else {
        isPresent = false;
      }
    });
    return isPresent;
  }
}
