import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/models/package_listing_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/packages/package_cards.dart';
import 'package:vlcc/screens/packages/package_details.dart';
import 'package:vlcc/screens/packages/package_provider.dart';
import 'package:vlcc/screens/packages/package_tags.dart';
import 'package:vlcc/widgets/heading_title_text.dart';
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';

class RenewPackageBottomSheet extends StatefulWidget {
  final PackageDetail packageDetail;
  final int renewIndex;
  const RenewPackageBottomSheet(
      {Key? key, required this.packageDetail, required this.renewIndex})
      : super(key: key);

  @override
  _RenewPackageBottomSheetState createState() =>
      _RenewPackageBottomSheetState();
}

class _RenewPackageBottomSheetState extends State<RenewPackageBottomSheet> {
  final Services _services = Services();
  final VlccShared _vlccShared = VlccShared();
  PackageProvider _packageProvider = PackageProvider();

  Future<void> renewPackageService() async {
    var body = {
      'auth_token': _vlccShared.authToken,
      'device_id': _vlccShared.deviceId,
      'client_mobile': _vlccShared.mobileNum,
      'bookingId': widget.packageDetail.bookingId,
      'bookingNo': widget.packageDetail.bookingNumber,
      'reqComment': ''
    };
    _services.callApi(
        body, '/api/api_package_renew.php?request=api_package_renew');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _packageProvider = context.watch<PackageProvider>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(PaddingSize.extraLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
              indent: size.width * 0.35,
              thickness: 5,
              endIndent: size.width * 0.35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: PaddingSize.normal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadingTitleText(
                      fontSize: FontSize.large, title: 'Renew Package'),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey[500],
                      ))
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 2,
              color: AppColors.divider,
            ),
            bookingPaymentCard(context),
          ],
        ),
      ),
    );
  }

  Widget bookingPaymentCard(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return !profileProvider.renewPackagePass[widget.renewIndex]
        ? Column(
            children: [
              PackageCards(
                color: _packageProvider.packageCardColor,
                packageDetail: widget.packageDetail,
                isInfo: true,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PackageDetails(
                      isExpired: true,
                      packageDetail: widget.packageDetail,
                    );
                  }));
                },
                tags: GetTag(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.orange.withOpacity(0.8),
                            shadowColor: AppColors.appBarColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: PaddingSize.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            )),
                        onPressed: () {
                          renewPackageService().then((value) {
                            profileProvider.setPackageFinalRenewStatus(
                                index: widget.renewIndex, value: true);
                          });

                          // Navigator.pop(context);
                          // final snackBar = SnackBar(
                          //     behavior: SnackBarBehavior.fixed,
                          //     backgroundColor: AppColors.orange,
                          //     content: Text(
                          //       'We will be right back in a moment',
                          //       style: TextStyle(fontWeight: FontWeight.w600),
                          //     ));
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            HeadingTitleText(
                              fontSize: FontSize.large,
                              title: 'Request renewal',
                              // 'Continue Rs. ${widget.packageDetail.bookingTotalAmount}',
                              color: AppColors.appBarColor,
                            ),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Column(
            children: [
              Image.asset(
                'assets/icons/success.png',
                filterQuality: FilterQuality.high,
              ),
              SizedBox(
                height: 20,
              ),
              HeadingTitleText(
                fontSize: FontSize.heading,
                title: 'Success',
                color: Colors.green.withOpacity(0.7),
              )
            ],
          );
  }
}
