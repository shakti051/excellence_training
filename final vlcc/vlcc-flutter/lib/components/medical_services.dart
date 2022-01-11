import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/models/center_master_model.dart';
import 'package:vlcc/models/service_master_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/screens/appointments/book_service.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';

class MedicalServices extends StatelessWidget {
  final int index;
  final CenterMasterDatabase centerMasterDatabase;
  final ServiceMasterDatabase serviceMasterDatabase;
  const MedicalServices({
    Key? key,
    this.index = 0,
    required this.serviceMasterDatabase,
    required this.centerMasterDatabase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final dashboardProvider = context.read<DashboardProvider>();
    return ListTile(
      tileColor:
          index % 2 == 0 ? AppColors.greyBackground : AppColors.backgroundColor,
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
        //     'video consultations',
        badgeColor: Colors.transparent,
        padding: const EdgeInsets.all(0),
        badgeContent: SvgPicture.asset(SVGAsset.videoAsset),
        alignment: Alignment.topLeft,
        child: Text(
          serviceMasterDatabase.serviceName,
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
          '₹ ${serviceMasterDatabase.serviceType.trim().toLowerCase().toTitleCase}',
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
            profileProvider.isLoading = false;
            dashboardProvider.centerName = '';
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return BookService(
                  centerMasterDatabase: centerMasterDatabase,
                  serviceMasterDatabase: serviceMasterDatabase,
                );
              }),
            );
          },
          child: Text('Book'),
        ),
      ),
    );
  }
}
