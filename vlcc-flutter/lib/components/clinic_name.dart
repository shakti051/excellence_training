import 'package:flutter/material.dart';
import 'package:vlcc/models/center_master_model.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';

class ClinicName extends StatelessWidget {
  final double distance;
  final CenterMasterDatabase centerMasterDatabase;
  const ClinicName(
      {Key? key, required this.centerMasterDatabase, this.distance = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: MarginSize.small),
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
              width: 56,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(MarginSize.middle),
              child: Image.network(
                centerMasterDatabase.centerPic,
                loadingBuilder: (context, widget, chunk) => Image.asset(
                  PNGAsset.clinicLogo,
                ),
                errorBuilder: (context, obh, stack) => Image.asset(
                  PNGAsset.clinicLogo,
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Text(
                    centerMasterDatabase.centerName.toLowerCase().toTitleCase,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.defaultFont,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: MarginSize.small),
                    child: Text(
                      'VLCC Health Centre',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.normal),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text:
                          "${centerMasterDatabase.areaName.toLowerCase().toTitleCase}, ${centerMasterDatabase.cityName.toLowerCase().toTitleCase}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.normal),
                    ),
                  ),
                  SizedBox(height: 12),
                  if (distance > 0)
                    Text(
                      'Distance $distance kms',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.normal,
                      ),
                    ),
                  SizedBox(height: 12),
                ],
              ),
            )
          ],
        ));
  }
}
