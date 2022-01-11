import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/components/clinic_name.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/appointment_widgets/appointment_widgets.dart';

class SearchSpecialityAppointment extends StatefulWidget {
  const SearchSpecialityAppointment({Key? key}) : super(key: key);
  @override
  _SearchSpecialityAppointmentState createState() =>
      _SearchSpecialityAppointmentState();
}

class _SearchSpecialityAppointmentState
    extends State<SearchSpecialityAppointment> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final databaseProvider = context.watch<DatabaseHelper>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSize.extraLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: _searchController,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Dermatalogist',
                            prefixIcon:
                                Icon(Icons.search, color: Colors.black54),
                            suffixIcon: InkWell(
                              onTap: () {
                                _searchController.text = '';
                              },
                              child: Icon(Icons.clear_rounded,
                                  color: Colors.black54),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.aquaGreen),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          onChanged: (text) {
                            setState(() {});
                          },
                          onSaved: (text) {},
                        ),
                      ),
                      SizedBox(width: 23),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _searchController.text = '';
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: AppColors.orange,
                                fontFamily: FontName.frutinger,
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.normal),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text("< 5km",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.normal)),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text("< 30km",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.normal)),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text("< 50km",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.normal)),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.backBorder),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text("< 50-100km",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.normal)),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
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
                          child: Container(
                            height: 58,
                            decoration: BoxDecoration(
                                color: (index % 2 == 0)
                                    ? AppColors.greyBackground
                                    : AppColors.backgroundColor,
                                border: Border.all(
                                    width: 1, color: AppColors.greyBackground),
                                borderRadius: index == 0
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))
                                    : index == 4
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))
                                        : BorderRadius.circular(0)),
                            child: ListTile(
                              title: Text("Dermatalogy",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: FontSize.normal)),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: 32),
                  Text("Clinics(17)",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.large)),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppointmentClinics()));
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
      ),
    );
  }
}
