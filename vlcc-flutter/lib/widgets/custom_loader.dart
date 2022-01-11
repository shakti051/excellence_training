import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/heading_title_text.dart';

enum CustomLoaderType { quoted, defaultCupertino }

class CustomLoader extends StatefulWidget {
  final CustomLoaderType customLoaderType;
  const CustomLoader(
      {Key? key, this.customLoaderType = CustomLoaderType.quoted})
      : super(key: key);

  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return body(customLoaderType: widget.customLoaderType);
  }

  Widget body({required CustomLoaderType customLoaderType}) {
    // return marineColor();
    switch (customLoaderType) {
      case CustomLoaderType.quoted:
        return marineColor();
      case CustomLoaderType.defaultCupertino:
        return Center(
          child: CupertinoActivityIndicator(
            animating: true,
          ),
        );
      default:
        return Center(
          child: CupertinoActivityIndicator(
            animating: true,
          ),
        );
    }
  }

  Widget marineColor() {
    return Padding(
      padding: const EdgeInsets.all(PaddingSize.extraLarge),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              color: AppColors.marineBlue,
            ),
            SizedBox(
              height: 20,
            ),
            HeadingTitleText(
              fontSize: FontSize.large,
              title: 'Beauty is the promise of happiness.',
              color: AppColors.grey,
              fontWeight: FontWeight.normal,
            ),
            HeadingTitleText(
              fontSize: FontSize.normal,
              title: '~ Edmund Burke',
              color: AppColors.grey,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}
