import 'package:flutter/material.dart';
import 'package:vlcc/resources/assets_path.dart';

class AddClinicLogo extends StatelessWidget {
  const AddClinicLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(PNGAsset.clinicLogo),
    );
  }
}
