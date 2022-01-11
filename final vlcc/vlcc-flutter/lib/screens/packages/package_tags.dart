import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlcc/resources/assets_path.dart';

enum VariableTag { information, gift, starTag, none }

class GetTag extends StatefulWidget {
  final VariableTag variableTag;
  const GetTag({Key? key, this.variableTag = VariableTag.gift})
      : super(key: key);

  @override
  State<GetTag> createState() => _GetTagState();
}

class _GetTagState extends State<GetTag> {
  @override
  Widget build(BuildContext context) {
    return body(widget.variableTag);
  }

  Widget body(VariableTag tags) {
    switch (tags) {
      case VariableTag.none:
        return SizedBox();
      case VariableTag.gift:
        return SvgPicture.asset(SVGAsset.gift);
      case VariableTag.information:
        return SvgPicture.asset(
          SVGAsset.info,
          fit: BoxFit.cover,
        );
      case VariableTag.starTag:
        return SvgPicture.asset(SVGAsset.bookmark);
      default:
        return SvgPicture.asset(SVGAsset.gift);
    }
  }
}
