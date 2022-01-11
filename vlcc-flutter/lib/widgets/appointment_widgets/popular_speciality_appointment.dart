import 'package:flutter/material.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/appointment_widgets/appointment_widgets.dart';

class PopularSpecialityAppointment extends StatelessWidget {
  const PopularSpecialityAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        builder: (context) => SearchSpecialityAppointment()),
                  );
                },
                child: Container(
                  // height: 58,
                  decoration: BoxDecoration(
                      color: (index % 2 == 0)
                          ? AppColors.greyBackground
                          : AppColors.backgroundColor,
                      border:
                          Border.all(width: 1, color: AppColors.greyBackground),
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
      ],
    );
  }
}
