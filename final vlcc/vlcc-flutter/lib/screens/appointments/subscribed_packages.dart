import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/components/components.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/packages/package_cards.dart';
import 'package:vlcc/screens/packages/package_provider.dart';
import 'package:vlcc/screens/packages/package_tags.dart';
import 'package:vlcc/screens/search/packages.dart';
import 'package:vlcc/widgets/nodata.dart';

class SubscribedPackages extends StatelessWidget {
  const SubscribedPackages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final databaseProvider = context.watch<DatabaseHelper>();
    final packageProviderList = context.watch<PackageProvider>();

    return Scaffold(
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
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Text("Book Appointment",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.heading)),
                SizedBox(height: 32),
                Visibility(
                  visible: packageProviderList.activePackages.isNotEmpty,
                  child: Column(
                      children: List.generate(
                    packageProviderList.activePackages.length,
                    (index) => PackageCards(
                      color: packageProviderList.packageCardColor,
                      tags: GestureDetector(
                          child: GetTag(
                        variableTag: VariableTag.none,
                      )),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Packages(
                                    packageDetail: packageProviderList
                                        .activePackages[index],
                                  )),
                        );
                      },
                      packageDetail: packageProviderList.activePackages[index],
                    ),
                  )),
                ),
                Visibility(
                  visible: packageProviderList.activePackages.isEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: NoDataScreen(
                      noDataSelect: NoDataSelectType.empty,
                    ),
                  ),
                ),

                // PackageValidity(),
                SizedBox(height: 32),
                Text("Services",
                    style: TextStyle(
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.extraLarge)),
                SizedBox(height: 24),
                ListView.builder(
                    itemCount: 5,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {},
                          child: MedicalServices(
                            centerMasterDatabase:
                                databaseProvider.centerMasterDbList[0],
                            index: index,
                            serviceMasterDatabase:
                                databaseProvider.serviceMasterDbList[index],
                          ));
                    }),
                SizedBox(height: 32),
                // SlimmingServices(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
