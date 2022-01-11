import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlcc/models/center_master_model.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';

class ClinicDescription extends StatelessWidget {
  final CenterMasterDatabase centerMasterDatabase;
  const ClinicDescription({Key? key, required this.centerMasterDatabase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: MarginSize.small),
        padding: const EdgeInsets.only(top: PaddingSize.normal, bottom: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 64, 128, 0.04),
                  blurRadius: 10,
                  offset: Offset(0, 5))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.all(MarginSize.middle),
                child: Image.asset("assets/images/rounded.png")),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(centerMasterDatabase.centerName,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.heading)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: MarginSize.small),
                    child: Text(centerMasterDatabase.centerType,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.normal)),
                  ),
                  Text(
                      "${centerMasterDatabase.areaName}, ${centerMasterDatabase.cityName}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.normal)),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SvgPicture.asset(SVGAsset.stars),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(centerMasterDatabase.centerRatelist,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.normal)),
                      ),
                      // Text("(1387 Feedback)",
                      //     style: TextStyle(
                      //         color: Colors.grey,
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: FontSize.normal)),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
