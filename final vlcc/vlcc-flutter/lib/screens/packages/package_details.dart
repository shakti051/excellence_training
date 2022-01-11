import 'package:badges/badges.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/models/package_listing_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/vlcc_theme.dart';
import 'package:vlcc/screens/packages/color_cards.dart';
import 'package:vlcc/screens/packages/package_provider.dart';
import 'package:vlcc/widgets/heading_title_text.dart';
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';

import 'package_color_select.dart';

class PackageDetails extends StatefulWidget {
  final bool isExpired;
  final PackageDetail? packageDetail;
  final int index;
  const PackageDetails(
      {Key? key, this.isExpired = false, this.packageDetail, this.index = 1})
      : super(key: key);

  @override
  _PackageDetailsState createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isExtensionContent = true;
  final Services _services = Services();
  final VlccShared _vlccShared = VlccShared();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      // duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {
          controller.value = 30.0;
        });
      });
    // controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ = context.watch<PackageProvider>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            backgroundColor: AppColors.backgroundColor,
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
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
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
            title: Column(
              children: [
                HeadingTitleText(
                  title: 'Package details',
                  fontSize: FontSize.extraLarge,
                ),
                if (widget.isExpired) ...[
                  HeadingTitleText(
                    title: 'Expired',
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w600,
                    color: AppColors.pink,
                  ),
                ]
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (_) => ColorPickerOverlay(),
                    );
                  },
                  child: Image.asset(
                    SVGAsset.colorWheel,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ],
          ),
          body(context),
        ],
      ),
    );
  }

  Widget body(BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(PaddingSize.extraLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              packageDetailsCard(context),
              SizedBox(
                height: PaddingSize.large,
              ),
              HeadingTitleText(fontSize: FontSize.heading, title: 'Services'),
              Column(
                children: List.generate(
                  widget.packageDetail!.packageItemDtl!.length,
                  (index) => expansionServiceCard(
                      servicesOffered:
                          widget.packageDetail!.packageItemDtl![index]),
                ),
              )
            ],
          ),
        ),
      );

  Widget expansionServiceCard({required PackageItemDtl servicesOffered}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(12.0)),
        child: ExpansionTileCard(
          expandedTextColor: Colors.grey[600],
          expandedColor: VlccColor.primaryTheme,
          elevation: 0,
          initialElevation: 0,
          shadowColor: Colors.transparent,
          title: HeadingTitleText(
              fontWeight: FontWeight.w700,
              fontSize: FontSize.large,
              title:
                  '${servicesOffered.serviceName} (${servicesOffered.serviceQty})'),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Colors.grey[300],
              ),
            ),
            Column(
              children: List.generate(
                1,
                (index) =>
                    progressBarServices(servicesOffered: servicesOffered),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding progressBarServices({required PackageItemDtl servicesOffered}) {
    var serviceQty = int.parse(servicesOffered.serviceQty);
    var servicePaidQty = int.parse(servicesOffered.servicePaidQty);
    var serviceLeftQty = servicesOffered.serviceLeftQty;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: HeadingTitleText(
                  fontSize: FontSize.large,
                  title: servicesOffered.serviceName,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                      text: '$serviceLeftQty/',
                      style: TextStyle(
                        color: AppColors.profileEnabled,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.large,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '$serviceQty left',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: widget.isExpired
                ? Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: LinearPercentIndicator(
                        // progressColor: AppColors.aquaPurple.withOpacity(0.6),
                        lineHeight: 12,
                        // linearGradientBackgroundColor: LinearGradient(
                        //     colors: [Colors.white, VlccColor.primaryTheme]),
                        linearGradient: LinearGradient(colors: [
                          Colors.primaries[serviceLeftQty],
                          Colors.primaries[serviceLeftQty + 1]
                        ]),
                        percent: serviceLeftQty / serviceQty,
                      ),
                    ),
                  )
                : LinearPercentIndicator(
                    // progressColor: AppColors.aquaPurple.withOpacity(0.6),
                    lineHeight: 12,
                    // linearGradientBackgroundColor: LinearGradient(
                    //     colors: [Colors.white, VlccColor.primaryTheme]),
                    linearGradient: LinearGradient(colors: [
                      Colors.primaries[serviceLeftQty],
                      Colors.primaries[serviceLeftQty + 1]
                    ]),
                    percent: serviceLeftQty / serviceQty,
                  ),
          )
        ],
      ),
    );
  }

  Widget freeExtensionContentCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PaddingSize.extraLarge),
      child: Visibility(
        visible: isExtensionContent,
        child: Badge(
          badgeColor: Colors.white,
          badgeContent: InkWell(
            onTap: () {
              setState(() {
                isExtensionContent = false;
              });
            },
            child: Icon(
              Icons.close,
              color: VlccColor.darkGreyDivider,
            ),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: VlccColor.lightOrange),
                borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    text: 'Congratulations, your Package: ',
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
                              ' for \nFREE of cost.\n \nEnjoy extended services!')
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stack packageDetailsCard(BuildContext context) {
    final packageProvider = context.watch<PackageProvider>();
    var expiryDate = DateFormat.yMMMMd('en_US')
        .format(widget.packageDetail!.bookingExpiryDate ?? DateTime.now());
    var todaysDate = DateTime.now();
    var expiry = widget.packageDetail!.bookingExpiryDate ?? DateTime.now();

    double daysLeft() {
      int daysLeft = expiry.difference(todaysDate).inDays;
      if (daysLeft < 0) {
        return 0;
      } else {
        var ceil = (daysLeft / 356).ceil();
        return daysLeft / (356 * ceil);
      }
    }

    return Stack(
      children: [
        ColorfulCard(
          cardHeight: 165,
          infoCard: widget.isExpired,
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
                widget.packageDetail!.bookingNumber,
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
                widget.packageDetail!.centerName,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontName.frutinger,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.small),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: !widget.isExpired
                  ? Row(
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
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadingTitleText(
                                fontSize: FontSize.small,
                                title: 'Usage left',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              HeadingTitleText(
                                fontSize: FontSize.extraSmall,
                                title: "*Expired on $expiryDate",
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 8),
                            onPrimary: packageProvider.packageCardColor,
                          ),
                          onPressed: () {
                            renewPackageService().then((value) {
                              // profileProvider.setPackageFinalRenewStatus(
                              //     index: 0, value: true);
                            });
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Renew',
                              style: TextStyle(
                                color: packageProvider.packageCardColor,
                                fontWeight: FontWeight.w600,
                                fontFamily: FontName.frutinger,
                                fontSize: FontSize.large,
                              ),
                              // children: <TextSpan>[
                              //   TextSpan(
                              //       text: '',
                              //       // 'Rs. ${widget.packageDetail!.bookingTotalAmount}',
                              //       style: TextStyle(
                              //         fontSize: FontSize.extraSmall,
                              //       ))
                              // ]
                            ),
                          ),
                        )
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

  Future<void> renewPackageService() async {
    var body = {
      'auth_token': _vlccShared.authToken,
      'device_id': _vlccShared.deviceId,
      'client_mobile': _vlccShared.mobileNum,
      'bookingId': widget.packageDetail?.bookingId ?? '',
      'bookingNo': widget.packageDetail?.bookingNumber ?? '',
      'reqComment': ''
    };
    _services.callApi(
        body, '/api/api_package_renew.php?request=api_package_renew');
  }
}
