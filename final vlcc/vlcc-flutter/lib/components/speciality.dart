import 'package:flutter/material.dart';
import 'package:vlcc/models/service_master_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';

class Speciality extends StatelessWidget {
  final int index;
  final ServiceMasterDatabase serviceMasterList;
  const Speciality({Key? key, this.index = 0, required this.serviceMasterList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
          color: (index % 2 == 0)
              ? AppColors.greyBackground
              : AppColors.backgroundColor,
          border: Border.all(width: 1, color: AppColors.greyBackground),
          borderRadius: index == 0
              ? BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))
              : index == 4
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))
                  : BorderRadius.circular(0)),
      child: ListTile(
        title: Text(serviceMasterList.serviceName,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: FontSize.normal)),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
