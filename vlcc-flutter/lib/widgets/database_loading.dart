import 'package:flutter/material.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/custom_loader.dart';
import 'package:vlcc/widgets/heading_title_text.dart';

class DatabaseLoader extends StatefulWidget {
  const DatabaseLoader({Key? key}) : super(key: key);

  @override
  _DatabaseLoader createState() => _DatabaseLoader();
}

class _DatabaseLoader extends State<DatabaseLoader>
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
    return Padding(
      padding: const EdgeInsets.only(top: 64.0, right: 24.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Card(
              // elevation: 6,
              // shadowColor: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  HeadingTitleText(
                      fontSize: FontSize.large,
                      title:
                          'Please wait while we acquire the required details to get you moving.'),
                  CustomLoader(
                    customLoaderType: CustomLoaderType.quoted,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
