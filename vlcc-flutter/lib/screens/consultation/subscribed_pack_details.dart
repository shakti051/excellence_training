import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:vlcc/components/components.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/consultation/seclect_consult_service.dart';
import 'package:vlcc/widgets/search_widgets/search_widgets.dart';

class SubscribedPackageDetails extends StatelessWidget {
  const SubscribedPackageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final databaseProvider = context.watch<DatabaseHelper>();
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
                Text("Book Consultation",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.heading)),
                SizedBox(height: 32),
                PackageValidity(),
                SizedBox(height: 32),
                Text("Dermatology Services",
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SelectConsultationService()),
                            );
                          },
                          child: MedicalServices(
                            centerMasterDatabase:
                                databaseProvider.centerMasterDbList[0],
                            index: index,
                            serviceMasterDatabase:
                                databaseProvider.serviceMasterDbList[index],
                          ));
                    }),
                SizedBox(height: 32),
                SlimmingServices(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
