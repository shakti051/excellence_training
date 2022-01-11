import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/screens/packages/package_provider.dart';

class ColorPickerOverlay extends StatefulWidget {
  const ColorPickerOverlay({Key? key}) : super(key: key);

  @override
  _ColorPickerOverlayState createState() => _ColorPickerOverlayState();
}

class _ColorPickerOverlayState extends State<ColorPickerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final packageProvider = context.watch<PackageProvider>();
    List<Color> colorList = [
      AppColors.pink,
      AppColors.facebookBlue,
      AppColors.aquaGreen,
      Colors.lightGreen
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 64.0, right: 24.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(colorList.length, (index) {
                    return colorAvatar(
                        packageProvider, context, colorList[index]);
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding colorAvatar(
      PackageProvider packageProvider, BuildContext context, Color color) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: () {
          packageProvider.packageCardColor = color;
          Navigator.pop(context);
        },
        child: CircleAvatar(
          backgroundColor: color,
        ),
      ),
    );
  }
}
