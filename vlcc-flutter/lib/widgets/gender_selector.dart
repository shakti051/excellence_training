import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    Key? key,
    // required this.profiles,
  }) : super(key: key);

  // final ProfileProvider profiles;

  @override
  Widget build(BuildContext context) {
    final profiles = context.watch<ProfileProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: profiles.selectMale,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: profiles.getmaleColored
                      ? const [
                          BoxShadow(
                              color: AppColors.orangeShadow,
                              blurRadius: 20,
                              offset: Offset(0, 10)),
                        ]
                      : null,
                ),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                      width: 72,
                      height: 72,
                      padding: const EdgeInsets.all(PaddingSize.normal),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: AppColors.backBorder),
                          borderRadius: BorderRadius.circular(20),
                          color: profiles.getmaleColored
                              ? AppColors.orange
                              : null),
                      child: SvgPicture.asset("assets/images/ic_male.svg",
                          color: profiles.getmaleColored
                              ? Colors.white
                              : AppColors.disabledBackground)),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Male",
              style: TextStyle(
                  color: profiles.getmaleColored
                      ? Colors.black87
                      : AppColors.disabledBackground,
                  fontWeight: profiles.getmaleColored
                      ? FontWeight.w700
                      : FontWeight.w400,
                  fontSize: FontSize.normal),
            ),
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: profiles.selectFemale,
              child: Container(
                decoration: profiles.getfemaleColored
                    ? BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: AppColors.orangeShadow,
                              blurRadius: 20,
                              offset: Offset(0, 10)),
                        ],
                      )
                    : null,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                      width: 72,
                      height: 72,
                      padding: const EdgeInsets.all(PaddingSize.normal),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: AppColors.backBorder),
                          borderRadius: BorderRadius.circular(20),
                          color: profiles.getfemaleColored
                              ? AppColors.orange
                              : null),
                      child: SvgPicture.asset("assets/images/ic_female.svg",
                          color: profiles.getfemaleColored
                              ? Colors.white
                              : AppColors.disabledBackground)),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Female",
              style: TextStyle(
                  color: profiles.getfemaleColored
                      ? Colors.black87
                      : AppColors.disabledBackground,
                  fontWeight: profiles.getfemaleColored
                      ? FontWeight.w700
                      : FontWeight.w400,
                  fontSize: FontSize.normal),
            ),
          ],
        ),
        Column(children: [
          GestureDetector(
            onTap: profiles.selectCommon,
            child: Container(
              decoration: profiles.getcommonColored
                  ? BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: AppColors.orangeShadow,
                            blurRadius: 20,
                            offset: Offset(0, 10)),
                      ],
                    )
                  : null,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                    width: 72,
                    height: 72,
                    padding: const EdgeInsets.all(PaddingSize.normal),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(20),
                        color: profiles.getcommonColored
                            ? AppColors.orange
                            : null),
                    child: SvgPicture.asset("assets/images/common_gender.svg",
                        color: profiles.getcommonColored
                            ? Colors.white
                            : AppColors.disabledBackground)),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Other",
            style: TextStyle(
                color: profiles.getcommonColored
                    ? Colors.black87
                    : AppColors.disabledBackground,
                fontWeight: profiles.getcommonColored
                    ? FontWeight.w700
                    : FontWeight.w400,
                fontSize: FontSize.normal),
          ),
        ]),
      ],
    );
  }
}
