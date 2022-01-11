import 'package:flutter/material.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';

class HeadingTitleText extends StatelessWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String title;
  final double padding;

  const HeadingTitleText({
    Key? key,
    required this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.color = AppColors.profileEnabled,
    required this.title,
    this.padding = PaddingSize.extraSmall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        title.toLowerCase().toTitleCase,
        style: TextStyle(
          fontFamily: FontName.frutinger,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
