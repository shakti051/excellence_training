import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

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
          title: Text(
            "Anti-Aeging & Feature\ncorrection - Injectables",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: FontSize.extraLarge),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 8),
            // child: Padding(
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: PaddingSize.extraLarge),
            //   child: Column(
            //     children: [
            //       SizedBox(height: 32),
            //       ListView.builder(
            //           itemCount: 5,
            //           physics: ClampingScrollPhysics(),
            //           shrinkWrap: true,
            //           scrollDirection: Axis.vertical,
            //           itemBuilder: (context, index) {
            //             return GestureDetector(
            //                 onTap: () {
            //                   Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) => BookAppointment()),
            //                   );
            //                 },
            //                 child: MedicalServices(
            //                   index: index,
            //                   serviceMasterDatabase:
            //                       databaseProvider.serviceMasterDbList[index],
            //                       centerMasterDatabase: ,
            //                 ));
            //           }),
            //     ],
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
