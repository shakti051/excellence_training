import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/packages/package_routes.dart';

class ViewPackages extends StatelessWidget {
  const ViewPackages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: BadgePosition.topStart(top: -5, start: 5),
      badgeColor: Colors.white,
      borderRadius: BorderRadius.zero,
      padding: EdgeInsets.zero,
      badgeContent: SvgPicture.asset(
        SVGAsset.info,
      ),
      child: Container(
        padding: EdgeInsets.all(14),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: MarginSize.normal),
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.pink,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.packagesExpiringSoonRenew,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.normal,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, PackageRoutes.packageDashboard);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "View Packages",
                          style: TextStyle(
                            shadows: const [
                              Shadow(
                                  color: AppColors.orange,
                                  offset: Offset(0, -2))
                            ],
                            color: Colors.transparent,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.orange,
                            decorationThickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SvgPicture.asset(
                            SVGAsset.arrowRight,
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
