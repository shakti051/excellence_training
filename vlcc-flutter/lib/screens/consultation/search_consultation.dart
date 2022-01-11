import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/components/clinic_name.dart';
import 'package:vlcc/components/speciality.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/consultation/consultation_clinics.dart';

class SearchConsultation extends StatefulWidget {
  const SearchConsultation({Key? key}) : super(key: key);

  @override
  _SearchConsultationState createState() => _SearchConsultationState();
}

class _SearchConsultationState extends State<SearchConsultation> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final databaseProvider = context.watch<DatabaseHelper>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Container(
            margin: EdgeInsets.only(top: 10, right: 16, bottom: 1),
            height: 48,
            child: TextFormField(
              controller: _searchController,
              keyboardType: TextInputType.name,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: 'Dermatalogist',
                prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 5, right: 0, bottom: 15),
                    child: SizedBox(
                      height: 4,
                      child: SvgPicture.asset(SVGAsset.searchIcon),
                    )),
                suffixIcon: InkWell(
                  onTap: () {
                    _searchController.text = '';
                  },
                  child: Icon(Icons.clear_rounded, color: Colors.black54),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.aquaGreen),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onChanged: (text) {
                setState(() {});
              },
              onSaved: (text) {},
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                _searchController.text = '';
              },
              child: Container(
                margin: EdgeInsets.only(right: 24, top: 18),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: AppColors.orange,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.normal),
                ),
              ),
            ),
          ],
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
                SizedBox(height: 36),
                Text("Specialities(2)",
                    style: TextStyle(
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => Specialities()),
                            // );
                          },
                          child: Speciality(
                            index: index,
                            serviceMasterList:
                                databaseProvider.serviceMasterDbList[index],
                          ));
                    }),
                SizedBox(height: 32),
                Text("Clinics(17)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: FontSize.large)),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConsultationClinics()));
                  },
                  child: ListView.builder(
                      itemCount: 4,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ClinicName(
                          centerMasterDatabase:
                              databaseProvider.centerMasterDbList[index],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
