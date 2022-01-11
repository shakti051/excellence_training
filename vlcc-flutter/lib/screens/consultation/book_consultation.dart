import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlcc/components/package_name.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/consultation/subscribed_pack_details.dart';
import 'package:vlcc/widgets/consultation_widgets/consult_popular_speciality.dart';

class BookConsultation extends StatelessWidget {
  const BookConsultation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          margin: EdgeInsets.only(top: 8),
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
              Text(
                "Book Consultation",
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: FontSize.heading),
              ),
              SizedBox(height: 24),
              Container(
                height: 48,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 5, right: 0, bottom: 15),
                            child: SizedBox(
                              height: 4,
                              child: SvgPicture.asset(SVGAsset.searchIcon),
                            )),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        hintText: 'Search location,clinic , speciality'),
                    keyboardType: TextInputType.text),
              ),
              SizedBox(height: 24),
              Text("Subscribed packages (s)",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: FontSize.large)),
              SizedBox(height: 24),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubscribedPackageDetails()),
                    );
                  },
                  child: PackageName()),
              SizedBox(height: 32),
              ConsultPopularSpeciality(),
              SizedBox(height: 24),
            ],
          ),
        ),
      )),
    );
  }
}
