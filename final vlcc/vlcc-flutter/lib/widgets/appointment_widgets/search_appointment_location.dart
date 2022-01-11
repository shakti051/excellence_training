import 'package:flutter/material.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/appointment_widgets/appointment_widgets.dart';

class SearchAppointmentLocation extends StatelessWidget {
  const SearchAppointmentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) => SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: LocationBottomBar())));
        },
        child: Row(
          children: const [
            Icon(Icons.location_on, color: Colors.black87),
            Text(
              "Sharda,New Delhi",
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w400,
                  fontSize: FontSize.normal),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.black87),
          ],
        ),
      ),
    );
  }
}
