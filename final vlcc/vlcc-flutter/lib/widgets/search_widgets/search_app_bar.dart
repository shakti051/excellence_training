import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              padding: EdgeInsets.all(PaddingSize.small),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.backBorder),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                Icons.keyboard_backspace,
                size: 24,
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: MarginSize.small),
                child: SvgPicture.asset("assets/images/map.svg")),
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: Text(
                "Explore ",
                style: TextStyle(
                    color: AppColors.orangeProfile,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                    fontSize: FontSize.normal),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
