import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/heading_title_text.dart';

class ColorfulCard extends StatelessWidget {
  final bool infoCard;
  final double cardHeight;
  final Color cardColor;
  const ColorfulCard({
    Key? key,
    this.cardHeight = 155.0,
    this.infoCard = false,
    this.cardColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: cardHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: (cardColor == Colors.transparent)
                ? AppColors.randomColor
                : cardColor,
          ),
        ),
        if (!infoCard) ...[
          Image.asset(SVGAsset.watermarkStar,
              filterQuality: FilterQuality.high),
        ],
        if (infoCard) ...[
          Image.asset(SVGAsset.watermarkInfo,
              filterQuality: FilterQuality.high),
        ],
        Container(
            height: cardHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.black38,
                  ],
                  stops: const [
                    0.0,
                    1.0
                  ]),
            )),
      ],
    );
  }
}

class CenteredContentDivider extends StatelessWidget {
  final String content;
  const CenteredContentDivider({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          color: AppColors.profileEnabled,
        )),
        HeadingTitleText(fontSize: FontSize.small, title: content),
        Expanded(
            child: Divider(
          color: AppColors.profileEnabled,
        ))
      ],
    );
  }
}
