import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/components/components.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/consultation/search_consultation.dart';

class ConsultPopularSpeciality extends StatefulWidget {
  const ConsultPopularSpeciality({Key? key}) : super(key: key);

  @override
  State<ConsultPopularSpeciality> createState() =>
      _ConsultPopularSpecialityState();
}

class _ConsultPopularSpecialityState extends State<ConsultPopularSpeciality> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    // _databaseHelper.initializeDatabase().then((value) {
    //   log('Database Initialized');
    //   // loadReminders();
    //   // count++;
    // });
    // loadServices();
    super.initState();
  }

  void loadServices() {
    _databaseHelper.getServices();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = context.watch<DatabaseHelper>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular Speciality",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: FontSize.large)),
        SizedBox(height: 20),
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
                        builder: (context) => SearchConsultation()),
                  );
                },
                child: Speciality(
                  index: index,
                  serviceMasterList:
                      databaseProvider.serviceMasterDbList[index],
                ),
              );
            }),
      ],
    );
  }
}
