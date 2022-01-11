import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/screens/appointments/reminders.dart';
import 'package:vlcc/screens/dashboard/about.dart';
import 'package:vlcc/screens/packages/package_routes.dart';
import 'package:vlcc/screens/packages/packages.dart';
import 'package:vlcc/screens/profile/profile.dart';
import 'package:vlcc/screens/profile/profile_page_routes.dart';

class ProfileDialouge extends StatefulWidget {
  final bool isCustomerApp;
  const ProfileDialouge({Key? key, this.isCustomerApp = true})
      : super(key: key);

  @override
  State<ProfileDialouge> createState() => _ProfileDialougeState();
}

class _ProfileDialougeState extends State<ProfileDialouge>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final _vlccSharedPrefs = context.watch<VlccShared>();
    return ScaleTransition(
      scale: scaleAnimation,
      child: Stack(
        children: [
          Positioned(
            top: 58,
            right: 0,
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: PaddingSize.large, vertical: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                      width: 52,
                                      height: 52,
                                      child: widget.isCustomerApp
                                          ? Image.network(
                                              _vlccSharedPrefs.profileImage,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, stack, obj) {
                                                return Image.asset(
                                                  PNGAsset.avatar,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            )
                                          : Image.asset(
                                              PNGAsset.avatar,
                                              fit: BoxFit.cover,
                                            ))),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        _vlccSharedPrefs.name
                                            .toLowerCase()
                                            .toTitleCase,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20)),
                                    Visibility(
                                      visible: widget.isCustomerApp &&
                                          _vlccSharedPrefs.email
                                              .toLowerCase()
                                              .isNotEmpty,
                                      child: Flexible(
                                        child: Text(
                                          _vlccSharedPrefs.email.toLowerCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: FontSize.normal,
                                          ),
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.clear, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColors.divider,
                          height: 40,
                          thickness: 2,
                          indent: 0,
                          endIndent: 0,
                        ),
                        customerAppDialog(context),
                        dialogTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => About()));
                            },
                            imgPath: 'assets/images/info-circle.svg',
                            tileName: 'About Us'),
                        dialogTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PackageRoutes.privacyPolicy);
                            },
                            imgPath: SVGAsset.privacyPolicy,
                            tileName: 'Privacy Policy'),
                        dialogTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PackageRoutes.termsAndConditions);
                            },
                            imgPath: 'assets/images/document-text.svg',
                            tileName: 'Terms of Service'),
                        dialogTile(
                            onTap: () {
                              _vlccSharedPrefs.signOut().then((value) {
                                if (value) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      PackageRoutes.welcomeScreen,
                                      (route) => false);
                                }
                              });
                            },
                            imgPath: 'assets/images/logout.svg',
                            tileName: 'Sign Out'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Visibility customerAppDialog(BuildContext context) {
    return Visibility(
      visible: widget.isCustomerApp,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          dialogTile(
              onTap: () {
                Navigator.pushNamed(context, ProfilePageRoutes.profileMain);
              },
              imgPath: 'assets/images/myprofile.svg',
              tileName: 'My profile'),
          dialogTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Reminders();
                }));
              },
              imgPath: 'assets/images/alarm.svg',
              tileName: 'Reminders'),
          dialogTile(
              imgPath: 'assets/images/bill.svg',
              onTap: () {
                Navigator.pushNamed(context, PackageRoutes.packageInvoice);
              },
              tileName: 'Invoices'),
          dialogTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PackageDashboard();
                }));
              },
              imgPath: 'assets/images/ticket-star.svg',
              tileName: 'Active Packages'),
          Divider(
            color: AppColors.divider,
            thickness: 2,
            indent: 0,
            endIndent: 0,
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget dialogTile(
      {required void Function() onTap,
      required String imgPath,
      required String tileName}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: MarginSize.normal),
                  child: SvgPicture.asset(imgPath)),
              Text(
                tileName,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.defaultFont),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
