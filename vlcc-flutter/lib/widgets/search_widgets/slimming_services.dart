import 'package:flutter/material.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/search_widgets/slimming_packages.dart';

class SlimmingServices extends StatelessWidget {
  const SlimmingServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Slimming services",
            style: TextStyle(
                fontFamily: FontName.frutinger,
                fontWeight: FontWeight.w700,
                fontSize: FontSize.extraLarge)),
        SizedBox(height: 24),
        ListView.builder(
            itemCount: 5,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => Specialities()),
                    // );
                  },
                  child: SlimmingPackages(index: index));
            }),
      ],
    );
  }
}
