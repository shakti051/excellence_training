import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/components/medical_services.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/screens/search/book_appointment.dart';

class ClinicServices extends StatelessWidget {
  const ClinicServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final databaseProvider = context.watch<DatabaseHelper>();
    return ListView.builder(
        itemCount: 5,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookAppointment()),
                );
              },
              child: MedicalServices(
                centerMasterDatabase: databaseProvider.centerMasterDbList[0],
                index: index,
                serviceMasterDatabase:
                    databaseProvider.serviceMasterDbList[index],
              ));
        });
  }
}
