import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';

class SlimmingPackages extends StatelessWidget {
  final int? index;
  const SlimmingPackages({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: (index! % 2 == 0)
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
      child: Stack(
        children: [
          Positioned(
            left: 12,
            top: 12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text("Coolsculpting",
                      style: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.large)),
                ),
                Visibility(
                    visible: false,
                    child: SvgPicture.asset(SVGAsset.videoAsset))
              ],
            ),
          ),
          Positioned(
            left: 12,
            top: 38,
            child: RichText(
              text: TextSpan(
                text: '1 usages left',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: FontName.frutinger,
                    fontWeight: FontWeight.w400,
                    fontSize: FontSize.small),
                children: const <TextSpan>[
                  TextSpan(
                      text: '',
                      style: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 101,
              height: 37,
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.only(right: MarginSize.normal),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.orange),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "Book",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.orange,
                    fontFamily: FontName.frutinger,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
