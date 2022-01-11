import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/models/package_listing_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/packages/color_cards.dart';
import 'package:vlcc/screens/packages/invoice_listing.dart';
import 'package:vlcc/screens/packages/package_cards.dart';
import 'package:vlcc/screens/packages/package_tags.dart';
import 'package:vlcc/screens/packages/packages.dart';
import 'package:vlcc/screens/packages/renew_package.dart';
import 'package:vlcc/widgets/heading_title_text.dart';
import 'package:vlcc/widgets/nodata.dart';

class PackageDashboard extends StatefulWidget {
  const PackageDashboard({Key? key}) : super(key: key);

  @override
  _PackageDashboardState createState() => _PackageDashboardState();
}

class _PackageDashboardState extends State<PackageDashboard> {
  PackageProvider _packageProvider = PackageProvider();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  var apiHit = true;

  @override
  void initState() {
    super.initState();

    // _packageProvider.getPackageModelData().then((value) {
    //   setState(() {
    //     apiHit = true;
    //   });
    // });
  }

  Future<void> _refresh() async {
    await _packageProvider.getPackageModelData();
    await _packageProvider.getCashInvoice();
  }

  @override
  void dispose() {
    _refreshIndicatorKey.currentState?.dispose();
    super.dispose();
  }

  void _runFilter(String enteredKeyword, PackageProvider packageListProvider) {
    var packageList = packageListProvider.packageListingModel.packageDetails!;
    List<PackageDetail> results = [];
    List<PackageDetail> _activePackageResult = [];
    List<PackageDetail> _inActivePackageResult = [];
    var todaysDate = DateTime.now();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = packageList;
      _activePackageResult.clear();
      _inActivePackageResult.clear();
      for (var package in results) {
        if (todaysDate.isBefore(package.bookingExpiryDate ?? DateTime.now())) {
          _activePackageResult.add(package);
        } else {
          _inActivePackageResult.add(package);
        }
      }
      // _activePackageResult = packageListProvider.activePackages;
      // _inActivePackageResult = packageListProvider.inActivePackages;
    } else {
      results = packageList
          .where(
            (package) =>
                (package.bookingNumber
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase())) ||
                package.centerName.toLowerCase().contains(
                      enteredKeyword.toLowerCase(),
                    ),
          )
          .toList();

      _activePackageResult.clear();
      _inActivePackageResult.clear();
      for (var package in results) {
        if (todaysDate.isBefore(package.bookingExpiryDate ?? DateTime.now())) {
          _activePackageResult.add(package);
        } else {
          _inActivePackageResult.add(package);
        }
      }

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    packageListProvider.activePackages = _activePackageResult;
    packageListProvider.inActivePackages = _inActivePackageResult;
  }

  final TextEditingController _searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final packageList = context.watch<PackageProvider>();
    _packageProvider = context.watch<PackageProvider>();
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: RefreshIndicator(
          onRefresh: _refresh,
          key: _refreshIndicatorKey,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                backgroundColor: AppColors.backgroundColor,
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 14),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(PaddingSize.small),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
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
                actions: [
                  SvgPicture.asset('assets/icons/invoiceIcon.svg'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return InvoiceListing();
                      }));
                    },
                    child: HeadingTitleText(
                      fontSize: FontSize.normal,
                      title: 'Invoices history',
                      color: AppColors.orange,
                    ),
                  )
                ],
              ),
              body(packageList),
            ],
          ),
        ),
      ),
    );
  }

  Widget body(PackageProvider packageList) => SliverToBoxAdapter(
        child: apiHit
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: PaddingSize.extraLarge,
                    horizontal: PaddingSize.extraLarge),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchBarController,
                      onChanged: (value) => _runFilter(value, packageList),
                      decoration: const InputDecoration(
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.orangeProfile),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.greyBackground,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.greyBackground,
                          ),
                        ),
                        fillColor: AppColors.greyBackground,
                        hintText: 'Search packages...',
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        HeadingTitleText(
                            fontSize: FontSize.heading, title: 'Packages'),
                      ],
                    ),
                    Visibility(
                      visible: packageList.activePackages.isNotEmpty,
                      child: Column(
                        children: List.generate(
                          packageList.activePackages.length,
                          (index) => PackageCards(
                            color: _packageProvider.packageCardColor,
                            index: index,
                            packageDetail: packageList.activePackages[index],
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return PackageDetails(
                                  packageDetail:
                                      packageList.activePackages[index],
                                );
                              }));
                            },
                            tags: GestureDetector(
                                onTap: extensionTags,
                                child: GetTag(
                                  variableTag: VariableTag.none,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: packageList.inActivePackages.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 36.0, bottom: 16),
                        child: CenteredContentDivider(
                          content: 'Inactive packages',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: packageList.inActivePackages.isNotEmpty,
                      child: Column(
                        children: List.generate(
                          packageList.inActivePackages.length,
                          (index) => PackageCards(
                            index: index,
                            color: _packageProvider.packageCardColor,
                            packageDetail: packageList.inActivePackages[index],
                            isInfo: true,
                            cardType: 'Renew',
                            onTap: () {
                              _modalBottomSheetMenu(
                                  renewIndex: index,
                                  packageDetail:
                                      packageList.inActivePackages[index]);
                            },
                            tags: GetTag(
                              variableTag: VariableTag.information,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: packageList.activePackages.isEmpty &&
                          packageList.inActivePackages.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * 0.2),
                        child: NoDataScreen(
                          noDataSelect: NoDataSelectType.package,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      );
  Future<void> extensionTags() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: HeadingTitleText(
                      fontSize: FontSize.large,
                      title: 'Free Package Extension'),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 91,
                      width: 99,
                      child: SvgPicture.asset(SVGAsset.bookmark),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Your Package: ',
                        style: TextStyle(
                          color: AppColors.profileEnabled,
                          fontWeight: FontWeight.normal,
                          fontSize: FontSize.normal,
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                            text: '“Package name”',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: ' has been extended till '),
                          TextSpan(
                            text: 'Jul 20, 2022',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  ' for FREE of cost. Enjoy extended services!')
                        ]),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Know more',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Got it, thanks!'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _modalBottomSheetMenu(
      {required PackageDetail packageDetail, required int renewIndex}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (builder) {
          return RenewPackageBottomSheet(
            packageDetail: packageDetail,
            renewIndex: renewIndex,
          );
        });
  }
}
